import 'package:shared_preferences/shared_preferences.dart';

//this is small db to save bool value for theme

class DrakThemePref {
  //theme key-value storage
  static const themeStatus = "THEMESTATUS";

  setDarkTheme(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(themeStatus, value);
  }

  Future<bool> getTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //getting error because of intial values define as falue since it bool
    return prefs.getBool(themeStatus) ?? false;
  }
}
