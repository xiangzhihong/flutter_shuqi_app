import 'package:flutter/material.dart';
import '../widget/default_cell.dart';


class MeCell extends StatelessWidget {
  final VoidCallback? onPressed;
  final String iconName;
  final String title;

  MeCell({required this.title, required this.iconName, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DefaultCell(
      title: title,
      leftWidget: Image.asset(iconName),
      isSeparatorVisible: true,
      isArrowVisible: true,
      onPressed: onPressed,
    );
  }
}
