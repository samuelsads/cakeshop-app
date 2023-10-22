import 'package:shared_preferences/shared_preferences.dart';

class ColorPreference {
  static final ColorPreference _instancia = ColorPreference._internal();

  factory ColorPreference() {
    return _instancia;
  }

  ColorPreference._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int get primaryColor => _prefs.getInt("primaryColor") ?? 0;

  set primaryColor(int data) {
    _prefs.setInt("primaryColor", data);
  }
}
