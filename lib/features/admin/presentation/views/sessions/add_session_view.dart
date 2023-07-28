import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/core/di.dart';
import 'package:y23/core/media.dart';
import 'package:y23/core/state/providers/loading_provider.dart';
import 'package:y23/core/widgets/snackbar.dart';
import 'package:y23/features/admin/presentation/views/sessions/widgets/point_widget.dart';
import 'package:y23/features/admin/presentation/widgets/text_input_widget.dart';
import 'package:y23/features/user/domain/entities/sessions/session.dart';
import 'package:y23/features/user/presentation/views/sessions/state/providers/session_functionalities_provider.dart';

class AddSessionView extends ConsumerStatefulWidget {
  const AddSessionView({
    super.key,
    required this.session,
  });

  final Session? session;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddSessionViewState();
}

class _AddSessionViewState extends ConsumerState<AddSessionView> {
  List<GlobalKey<PointWidgetState>> globalKeys =
      <GlobalKey<PointWidgetState>>[];
  late final TextEditingController _titleController;
  late final TextEditingController _instructorController;
  late final TextEditingController _documentationController;
  late final StreamController<List<PointWidget>> _pointsController;
  List<PointWidget>? _pointsWidget;
  Map<String, dynamic> _points = {};
  late final StreamController<File> _photoController;
  String? photoPath;
  File? previewPhoto;
  final AppMedia _appMedia = instance<AppMedia>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _instructorController = TextEditingController();
    _documentationController = TextEditingController();
    _pointsController = StreamController<List<PointWidget>>.broadcast();
    _photoController = StreamController<File>.broadcast();

    if (widget.session != null) {
      _titleController.text = widget.session!.title;
      _instructorController.text = widget.session!.instructor;
      _documentationController.text = widget.session!.documentationLink ?? "";
      _points = Map.fromEntries(
        widget.session!.points!.entries.toList()
          ..sort(
            (a, b) => int.parse(a.key.split('.')[0].trimLeft()).compareTo(
                int.parse(b.key.split('.')[0].trimLeft().trimRight())),
          ),
      );
      _setPointsWidget();
      if (widget.session!.photoUrl != null) {
        previewPhoto = File(widget.session!.photoUrl!);
      }
    }
  }

  void _setPointsWidget() {
    for (var entry in _points.entries) {
      final point = {entry.key: entry.value};
      final GlobalKey<PointWidgetState> globalKey = GlobalKey();
      globalKeys.add(globalKey);
      _pointsWidget = [
        ...?_pointsWidget,
        PointWidget(
          key: globalKey,
          point: point,
          onAdd: (point) => _points.addEntries(point.entries),
          onDelete: (point) => _points.remove(point),
        ),
      ];
    }
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _instructorController.dispose();
    _documentationController.dispose();
    _pointsController.close();
    _photoController.close();
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
          title: Text(AppStrings.addSession.tr()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addSession,
          child: const Icon(Icons.save_outlined),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                StreamBuilder<File?>(
                  stream: _photoController.stream,
                  builder: (context, snapshot) {
                    previewPhoto = snapshot.data ?? previewPhoto;
                    return snapshot.hasData
                        ? Image.file(previewPhoto!)
                        : previewPhoto != null
                            ? Image.network(previewPhoto!.path)
                            : Container();
                  },
                ),
                Row(
                  children: [
                    TextInputWidget(
                      controller: _titleController,
                      hintText: AppStrings.titleHintText.tr(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextInputWidget(
                      controller: _instructorController,
                      hintText: AppStrings.instructorHintText.tr(),
                    ),
                    IconButton(
                      onPressed: () async {
                        final XFile? file = await _appMedia.pickImage();
                        if (file != null) {
                          photoPath = file.path;
                          _photoController.add(File(file.path));
                        }
                      },
                      icon: const Icon(Icons.add_a_photo),
                    ),
                  ],
                ),
                Row(
                  children: [
                    TextInputWidget(
                      controller: _documentationController,
                      hintText: AppStrings.documentation.tr(),
                    ),
                  ],
                ),
                const Divider(),
                StreamBuilder<List<PointWidget>?>(
                  stream: _pointsController.stream,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(children: snapshot.data!)
                        : _pointsWidget != null
                            ? Column(children: _pointsWidget!)
                            : Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: InkWell(
                      onTap: () {
                        final GlobalKey<PointWidgetState> globalKey =
                            GlobalKey();
                        globalKeys.add(globalKey);
                        _pointsWidget = [
                          ...?_pointsWidget,
                          PointWidget(
                            key: globalKey,
                            onAdd: (point) => _points.addEntries(point.entries),
                            onDelete: (point) => _points.remove(point),
                          ),
                        ];
                        _pointsController.sink.add(_pointsWidget!);
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
                          child: Text(AppStrings.addPoint.tr()),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addSession() async {
    _points.clear();
    for (var key in globalKeys) {
      key.currentState!.getPoints();
    }
    if (_points.isEmpty ||
        _titleController.text.isEmpty ||
        _instructorController.text.isEmpty) {
      if (context.mounted) {
        customShowSnackBar(
          context: context,
          message: AppStrings.fillSession.tr(),
          isError: true,
        );
        return;
      }
    }
    final Session session = Session(
      id: widget.session != null ? widget.session!.id : null,
      title: _titleController.text,
      instructor: _instructorController.text,
      documentationLink: _documentationController.text,
      points: _points,
      photoUrl: photoPath ??
          (widget.session != null ? widget.session!.photoUrl : null),
    );

    ref.read(loadingProvider.notifier).loading();
    final result = await ref
        .read(sessionFunctionalitiesProvider.notifier)
        .addOrUpdateSession(session);
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
    }
  }
}
