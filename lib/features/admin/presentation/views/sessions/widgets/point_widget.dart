import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:y23/config/utils/strings.dart';
import 'package:y23/features/admin/presentation/widgets/text_input_widget.dart';

typedef PointCallback = void Function(Map<String, dynamic> point);

class PointWidget extends StatefulWidget {
  const PointWidget({
    super.key,
    this.point,
    required this.onAdd,
    required this.onDelete,
  });

  final Map<String, dynamic>? point;
  final PointCallback onAdd;
  final PointCallback onDelete;

  @override
  State<PointWidget> createState() => PointWidgetState();
}

class PointWidgetState extends State<PointWidget> {
  late final TextEditingController _headerController;
  late final TextEditingController _descriptionController;
  bool exclude = false;

  @override
  void initState() {
    super.initState();
    _headerController = TextEditingController();
    _descriptionController = TextEditingController();

    if (widget.point != null) {
      _headerController.text = widget.point!.keys.first;
      _descriptionController.text = widget.point!.values.first;
    }
  }

  @override
  void dispose() {
    _headerController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) => exclude = true,
      child: Row(
        children: [
          TextInputWidget(
            controller: _headerController,
            hintText: AppStrings.headerHintText.tr(),
          ),
          TextInputWidget(
            controller: _descriptionController,
            hintText: AppStrings.descriptionHintText.tr(),
          ),
        ],
      ),
    );
  }

  void getPoints() {
    if (_headerController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        !exclude) {
      widget.onAdd({_headerController.text: _descriptionController.text});
    }
  }
}
