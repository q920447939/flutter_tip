import 'package:flutter/material.dart';
import 'package:flutter_web_demo_trip/main.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDark() {
    var result = SP.getBool(_local_key_theme_dark);
    return result ?? false;
  }

  String _local_key_theme_dark = "local_key_theme_dark";

  void setDarkTheme(bool isDark) {
    SP.setBool(_local_key_theme_dark, isDark);
    notifyListeners();
  }
}
