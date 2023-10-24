import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  bool isDarkMode = false;

  bool get darkMode => isDarkMode;

  void changeTheme(bool isDarkMode) {
    this.isDarkMode = isDarkMode;
    notifyListeners();
  }
}
