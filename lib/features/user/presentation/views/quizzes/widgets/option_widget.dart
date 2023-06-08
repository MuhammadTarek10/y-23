import 'package:flutter/material.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    super.key,
    required this.onPressed,
    required this.isSelected,
    required this.option,
  });

  final VoidCallback onPressed;
  final bool isSelected;
  final String option;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(
          option,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: isSelected
                    ? Theme.of(context).colorScheme.onSecondary
                    : Theme.of(context).colorScheme.background,
              ),
        ),
        trailing: Radio<String>(
          value: option,
          groupValue: isSelected ? option : null,
          onChanged: (_) => onPressed(),
          activeColor: MaterialStateColor.resolveWith(
              (states) => Theme.of(context).colorScheme.outline),
        ),
      ),
    );
  }
}
