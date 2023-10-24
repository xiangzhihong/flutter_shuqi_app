
import 'package:flutter/material.dart';

class ThemeConfig {

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF23B38E),
    dividerColor: Color(0xFFBBBBBB),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  );

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF333333),
    dividerColor: Color(0xFFF5F5F5),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
  );

}


