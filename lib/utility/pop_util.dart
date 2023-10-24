
import 'package:flutter/material.dart';

class PopUtil{

  static void showPopDialog(BuildContext context, Widget widget) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return widget;
        });
  }

  static void bottomSheetDialog(BuildContext context, Widget widget) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return widget;
      },
    );
  }

}