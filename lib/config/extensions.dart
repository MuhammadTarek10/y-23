import 'package:flutter/material.dart';

extension MediaQueryExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;
}

extension SortSession on Map<String, dynamic>? {
  Map<String, dynamic> sort() {
    return Map.fromEntries(
      this!.entries.toList()
        ..sort(
          (a, b) => int.parse(a.key.split('.')[0].trimLeft())
              .compareTo(int.parse(b.key.split('.')[0].trimLeft().trimRight())),
        ),
    );
  }
}
