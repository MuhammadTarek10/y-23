import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/admin/presentation/widgets/text_input_widget.dart';
import 'package:y23/features/user/domain/entities/tasks/task.dart';
import 'package:y23/features/user/presentation/views/tasks/state/providers/task_submissions_provider.dart';

class AddTaskView extends ConsumerStatefulWidget {
  const AddTaskView({super.key, this.task});

  final Task? task;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskViewState();
}

class _AddTaskViewState extends ConsumerState<AddTaskView> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _documentationLinkController;
  late final StreamController<DateTime?> _deadlineStreamController;
  DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _titleController.text = widget.task != null ? widget.task!.title : "";
    _descriptionController = TextEditingController();
    _descriptionController.text =
        widget.task != null ? widget.task!.description : "";
    _documentationLinkController = TextEditingController();
    _documentationLinkController.text =
        widget.task != null ? widget.task!.documentationLink ?? "" : "";
    _deadlineStreamController = StreamController<DateTime?>.broadcast();
    dateTime =
        widget.task != null ? widget.task!.deadline.toDate() : DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _documentationLinkController.dispose();
    _deadlineStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.onSecondary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(AppStrings.addTask.tr()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addTask,
          child: const Icon(Icons.save_outlined),
        ),
        body: SafeArea(
            child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  TextInputWidget(
                    controller: _titleController,
                    hintText: AppStrings.titleHintText.tr(),
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.deadlineHintText.tr()),
                          StreamBuilder<DateTime?>(
                            stream: _deadlineStreamController.stream,
                            builder: (context, snapshot) {
                              dateTime = snapshot.data ?? dateTime;
                              return Text(
                                DateFormat.MEd().add_jm().format(dateTime),
                              );
                            },
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: _getDeadline,
                        icon: const Icon(
                          Icons.date_range_outlined,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TextInputWidget(
                controller: _documentationLinkController,
                hintText: AppStrings.documentationHintText.tr(),
                flex: 0,
              ),
              TextInputWidget(
                controller: _descriptionController,
                hintText: AppStrings.descriptionHintText.tr(),
              ),
              const SizedBox(height: AppSizes.s20),
            ],
          ),
        )),
      ),
    );
  }

  Future<void> _addTask() async {
    final String title = _titleController.text;
    final String description = _descriptionController.text;
    final Timestamp dead = Timestamp.fromDate(dateTime);
    if (title.isEmpty || description.isEmpty) {
      customShowSnackBar(
        context: context,
        message: AppStrings.fillFieldsError.tr(),
        isError: true,
      );
      return;
    }
    final link = _documentationLinkController.text.isNotEmpty
        ? _documentationLinkController.text
        : null;
    final newTask = Task(
      id: widget.task != null ? widget.task!.id : null,
      title: title,
      description: description,
      deadline: dead,
      documentationLink: link,
    );
    ref.read(loadingProvider.notifier).loading();
    await ref.read(taskSubmissionsProvider.notifier).addOrUpdateTask(newTask);
    ref.read(loadingProvider.notifier).doneLoading();
    if (context.mounted) {
      customShowSnackBar(
        context: context,
        message: AppStrings.done.tr(),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _getDeadline() async {
    final deadlineDate = await _getDate();
    if (deadlineDate == null) return;
    final deadlineTime = await _getTime();
    _deadlineStreamController.sink.add(
      DateTime(
        deadlineDate.year,
        deadlineDate.month,
        deadlineDate.day,
        deadlineTime?.hour ?? 0,
        deadlineTime?.minute ?? 0,
      ),
    );
  }

  Future<TimeOfDay?> _getTime() {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: widget.task != null
            ? widget.task!.deadline.toDate().hour
            : dateTime.hour,
        minute: widget.task != null
            ? widget.task!.deadline.toDate().minute
            : dateTime.minute,
      ),
    );
  }

  Future<DateTime?> _getDate() {
    return showDatePicker(
      context: context,
      initialDate:
          widget.task != null ? widget.task!.deadline.toDate() : dateTime,
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    );
  }
}
