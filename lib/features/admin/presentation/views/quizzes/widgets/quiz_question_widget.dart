import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/colors.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/config/utils/values.dart';
import 'package:y23/features/admin/presentation/widgets/text_input_widget.dart';
import 'package:y23/features/user/domain/entities/quizzes/question.dart';

typedef QuestionAddCallback = void Function(Question question);

class QuizQuestionWidget extends StatefulWidget {
  const QuizQuestionWidget({
    super.key,
    this.isTrueOfFalse = false,
    this.question,
    required this.onAdd,
  });

  final Question? question;
  final bool isTrueOfFalse;
  final QuestionAddCallback onAdd;

  @override
  State<QuizQuestionWidget> createState() => QuizQuestionWidgetState();
}

class QuizQuestionWidgetState extends State<QuizQuestionWidget> {
  late final TextEditingController _titleController;
  List<TextEditingController>? _optionsControllers;
  int _optionsLength = 4;
  bool checkValue = false;
  List<bool> _isCorrect = [];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _optionsLength = widget.isTrueOfFalse ? 2 : 4;
    _createOptions();
    checkValue = widget.isTrueOfFalse;
    if (widget.question != null) {
      _titleController.text = widget.question!.title;
      _optionsControllers![0].text = widget.question!.options[0];
      _optionsControllers![1].text = widget.question!.options[1];
      _isCorrect =
          List.generate(widget.question!.options.length, (index) => false);
      if (!widget.isTrueOfFalse) {
        _optionsControllers![2].text = widget.question!.options[2];
        _optionsControllers![3].text = widget.question!.options[3];
      }
      _findAnswer();
    }
  }

  void _findAnswer() {
    for (int i = 0; i < widget.question!.options.length; i++) {
      if (widget.question!.options[i] == widget.question!.answer) {
        _isCorrect[i] = true;
      }
    }
  }

  void _createOptions() {
    _optionsControllers = List.generate(
      _optionsLength,
      (_) => TextEditingController(),
    );
    if (_optionsLength == 2) {
      _optionsControllers![0].text = "True";
      _optionsControllers![1].text = "False";
    }
    _isCorrect = List.generate(_optionsLength, (index) => false);
  }

  @override
  void dispose() {
    _titleController.dispose();
    for (var controller in _optionsControllers!) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p10),
        child: Column(
          children: [
            Row(
              children: [
                TextInputWidget(
                  controller: _titleController,
                  hintText: AppStrings.titleHintText.tr(),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      checkValue = !checkValue;
                      _optionsLength = checkValue ? 2 : 4;
                      _createOptions();
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(AppStrings.trueOrFalse.tr()),
                      Checkbox(
                        value: checkValue,
                        fillColor: MaterialStateProperty.all<Color>(
                          Theme.of(context).colorScheme.primary,
                        ),
                        onChanged: (value) {
                          setState(() {
                            checkValue = value!;
                            _optionsLength = checkValue ? 2 : 4;
                            _createOptions();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ...List.generate(
              _optionsControllers!.length,
              (index) => StatefulBuilder(
                builder: (context, setState) {
                  return OptionInput(
                    controller: _optionsControllers![index],
                    hintText: AppStrings.optionHintText.tr(),
                    color: _isCorrect[index]
                        ? Colors.green.withOpacity(0.3)
                        : Colors.grey.withOpacity(0.15),
                    isCorrect: _isCorrect[index],
                    onPressed: (option) {
                      setState(() {
                        _isCorrect[index] = !_isCorrect[index];
                      });
                    },
                  );
                },
              ),
            ),
            const Divider(thickness: AppSizes.s4),
          ],
        ),
      ),
    );
  }

  void getQuestions() {
    final List<String> options = <String>[];
    String answer = "";
    bool wrong = false;
    for (var i = 0; i < _optionsControllers!.length; i++) {
      options.add(_optionsControllers![i].text);
      if (_isCorrect[i]) {
        answer = _optionsControllers![i].text;
      }
    }

    for (var i = 0; i < _isCorrect.length; i++) {
      if (_isCorrect[i]) {
        if (wrong) {
          return;
        }
        wrong = true;
      }
    }

    if (options.length == _optionsControllers!.length &&
        answer.isNotEmpty &&
        _titleController.text.isNotEmpty) {
      final question = Question(
        title: _titleController.text,
        options: options,
        answer: answer,
      );
      widget.onAdd(question);
    }
  }
}

typedef OptionCallback = void Function(OptionInput option);

class OptionInput extends StatelessWidget {
  const OptionInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onPressed,
    this.isCorrect = false,
    this.color = Colors.grey,
    this.type = TextInputType.name,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final bool isCorrect;
  final Color color;
  final OptionCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p10,
            ),
            decoration: BoxDecoration(
              color: color,
              border: Border.all(
                color: AppColors.fakeWhite,
              ),
              borderRadius: BorderRadius.circular(AppSizes.s10),
            ),
            child: Stack(
              children: [
                TextField(
                  controller: controller,
                  keyboardType: type,
                  cursorColor: Colors.blue,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Colors.grey,
                        ),
                    border: InputBorder.none,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Checkbox(
                    value: isCorrect,
                    onChanged: (value) => onPressed(this),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
