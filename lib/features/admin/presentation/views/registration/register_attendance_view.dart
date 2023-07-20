import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/admin/domain/entities/attendance.dart';
import 'package:y23/features/admin/presentation/views/registration/state/providers/attendance_provider.dart';

class RegisterAttendance extends ConsumerStatefulWidget {
  const RegisterAttendance({
    super.key,
    this.title,
  });

  final String? title;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RegisterAttendanceState();
}

class _RegisterAttendanceState extends ConsumerState<RegisterAttendance> {
  late final TextEditingController _titleController;
  late final StreamController<List<MemberWidget>> _memberController;
  List<MemberWidget>? _membersWidget;
  final List<String> _names = [];
  List<GlobalKey<MemberWidgetState>> globalKeys =
      <GlobalKey<MemberWidgetState>>[];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _memberController = StreamController<List<MemberWidget>>.broadcast();
    if (widget.title != null) _titleController.text = widget.title!;
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _memberController.close();
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
        appBar: AppBar(
          title: Text(AppStrings.registerAttendance.tr()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addNames,
          child: const Icon(Icons.save),
        ),
        body: Column(
          children: [
            _titleInputWidget(context),
            StreamBuilder<List<MemberWidget>?>(
              stream: _memberController.stream,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Column(children: snapshot.data!)
                    : _membersWidget != null
                        ? Column(children: _membersWidget!)
                        : Container();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p10),
              child: InkWell(
                  onTap: () {
                    final GlobalKey<MemberWidgetState> globalKey = GlobalKey();
                    globalKeys.add(globalKey);
                    _membersWidget = [
                      ...?_membersWidget,
                      MemberWidget(
                        key: globalKey,
                        onAdd: (name) => _names.add(name),
                      ),
                    ];
                    _memberController.sink.add(_membersWidget!);
                  },
                  child: Container(
                    height: AppSizes.s50,
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .onSecondary
                          .withAlpha(120),
                      borderRadius: BorderRadius.circular(AppSizes.s10),
                      border: Border.all(color: AppColors.fakeWhite),
                    ),
                    child: Center(
                      child: Text(AppStrings.addName.tr()),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }

  Padding _titleInputWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: _titleController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          labelText: AppStrings.titleHintText.tr(),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  Future<void> _addNames() async {
    _names.clear();
    for (var key in globalKeys) {
      key.currentState!.getPoints();
    }

    if (_names.isEmpty) return;

    final attendance = Attendance(
      id: null,
      attendance: {_titleController.text: _names},
    );
    ref.read(loadingProvider.notifier).loading();
    final result = await ref
        .read(attendanceFunctionalityProvider.notifier)
        .addAttendance(attendance);
    ref.read(loadingProvider.notifier).doneLoading();
    if (context.mounted) {
      if (result) {
        customShowSnackBar(
          context: context,
          message: AppStrings.done.tr(),
        );
      } else {
        customShowSnackBar(
          context: context,
          message: AppStrings.generalError.tr(),
          isError: true,
        );
      }
      Navigator.pop(context);
      if (widget.title != null) Navigator.pop(context);
    }
  }
}

typedef MemberWidgetCallback = void Function(String point);

class MemberWidget extends StatefulWidget {
  const MemberWidget({
    super.key,
    required this.onAdd,
  });

  final MemberWidgetCallback onAdd;

  @override
  State<MemberWidget> createState() => MemberWidgetState();
}

class MemberWidgetState extends State<MemberWidget> {
  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        controller: nameController,
        decoration: InputDecoration(
          fillColor: Colors.white,
          label: Text(AppStrings.name.tr()),
          labelStyle: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.grey),
        ),
      ),
    );
  }

  void getPoints() {
    if (nameController.text.isNotEmpty) {
      widget.onAdd(nameController.text);
    }
  }
}
