import 'package:flutter/foundation.dart';
import 'package:shoes_app/services/drak_theme_pref.dart';

class DarkThemeProvider with ChangeNotifier {
  //made obj from dark theme preferance
  DrakThemePref drakThemePref = DrakThemePref();
  bool _darkTheme = false;

  //function to get bool value
  bool get getDarkTheme => _darkTheme;

  //set theme function
  set setDarkTheme(bool value) {
    _darkTheme = value;
    drakThemePref.setDarkTheme(value);
    notifyListeners();
  }
}
