import 'package:flutter/material.dart';

class AppInfoProvider with ChangeNotifier {
  String _themeColor = '';
  String get themeColor => _themeColor;
  setThemeColor(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}
