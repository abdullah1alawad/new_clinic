import 'package:flutter/material.dart';
import '../core/utils/theme_config.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = ThemeConfig.lightTheme;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == ThemeConfig.lightTheme) {
      themeData = ThemeConfig.darkTheme;
    } else {
      themeData = ThemeConfig.lightTheme;
    }
  }
}
