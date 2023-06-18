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
import 'package:y23/features/admin/presentation/views/quizzes/widgets/quiz_question_widget.dart';
import 'package:y23/features/admin/presentation/widgets/text_input_widget.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';
import 'package:y23/features/user/domain/entities/quizzes/quiz.dart';
import 'package:y23/features/user/presentation/views/quizzes/state/providers/quiz_result_provider.dart';

class AddQuizView extends ConsumerStatefulWidget {
  const AddQuizView({
    super.key,
    required this.quiz,
  });

  final Quiz? quiz;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddQuizViewState();
}

class _AddQuizViewState extends ConsumerState<AddQuizView> {
  List<GlobalKey<QuizQuestionWidgetState>> globalKeys =
      <GlobalKey<QuizQuestionWidgetState>>[];
  late final TextEditingController _titleController;
  late final StreamController<List<QuizQuestionWidget>> _questionsController;
  List<QuizQuestionWidget>? _questionsWidget;
  List<Question>? _questions;
  late final StreamController<File> _photoController;
  String? photoPath;
  File? previewPhoto;
  final AppMedia _appMedia = instance<AppMedia>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _questionsController =
        StreamController<List<QuizQuestionWidget>>.broadcast();
    _photoController = StreamController<File>.broadcast();
    if (widget.quiz != null) {
      _titleController.text = widget.quiz!.title;
      _questions = widget.quiz!.questions;
      _setQuestionsWidget();
      if (widget.quiz!.photoUrl != null) {
        previewPhoto = File(widget.quiz!.photoUrl!);
      }
    }
  }

  void _setQuestionsWidget() {
    for (var question in _questions!) {
      final GlobalKey<QuizQuestionWidgetState> globalKey = GlobalKey();
      globalKeys.add(globalKey);
      _questionsWidget = [
        ...?_questionsWidget,
        QuizQuestionWidget(
          key: globalKey,
          question: question,
          isTrueOfFalse: question.options.length == 2,
          onAdd: (question) => _questions = [...?_questions, question],
        )
      ];
    }
    _questionsController.sink.add(_questionsWidget!);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _questionsController.close();
    _photoController.close();
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
        appBar: AppBar(
          title: Text(AppStrings.addQuiz.tr()),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addQuiz,
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
                const Divider(),
                StreamBuilder<List<QuizQuestionWidget>?>(
                  stream: _questionsController.stream,
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? Column(children: snapshot.data!)
                        : _questionsWidget != null
                            ? Column(children: _questionsWidget!)
                            : Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: InkWell(
                    onTap: () {
                      final GlobalKey<QuizQuestionWidgetState> globalKey =
                          GlobalKey();
                      globalKeys.add(globalKey);
                      _questionsWidget = [
                        ...?_questionsWidget,
                        QuizQuestionWidget(
                          key: globalKey,
                          onAdd: (question) =>
                              _questions = [...?_questions, question],
                        )
                      ];
                      _questionsController.sink.add(_questionsWidget!);
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
                        child: Text(AppStrings.addQuestion.tr()),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addQuiz() async {
    if (_questions != null) _questions!.clear();
    for (var key in globalKeys) {
      key.currentState!.getQuestions();
    }
    if (_questions == null ||
        _questions!.isEmpty ||
        _titleController.text.isEmpty) {
      if (context.mounted) {
        customShowSnackBar(
          context: context,
          message: AppStrings.fillFieldsError.tr(),
          isError: true,
        );
        return;
      }
    }
    final Quiz quiz = Quiz(
      id: widget.quiz != null ? widget.quiz!.id : null,
      title: _titleController.text,
      questions: _questions!,
      photoUrl: photoPath,
    );

    ref.read(loadingProvider.notifier).loading();
    await ref.read(quizResultsProvider.notifier).addOrUpdateQuiz(quiz);
    ref.read(loadingProvider.notifier).doneLoading();
    if (context.mounted) {
      customShowSnackBar(
        context: context,
        message: AppStrings.done.tr(),
      );
      Navigator.pop(context);
    }
  }
}
