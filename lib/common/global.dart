import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  

}