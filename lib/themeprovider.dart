import 'package:flutter/material.dart';
import 'package:noteapp/theme.dart';

class Themeprivoder extends ChangeNotifier {
  ThemeData _themeData = lightmode;
  ThemeData get themeData => _themeData;

  bool get isdarkmode => _themeData == darkmode;

  set themedata(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toogletheme() {
    if (_themeData == lightmode) {
      _themeData = darkmode;
    } else {
      _themeData = lightmode;
    }
    notifyListeners();
  }
}
