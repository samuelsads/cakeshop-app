import 'package:cakeshopapp/config/sharepreferences/color_preference.dart';
import 'package:flutter/material.dart';

List data = [
  [Colors.pink.shade50, Colors.pink.shade100],
  [Colors.blue.shade50, Colors.black]
];

List<Color> buttonsColor = [Colors.black, Colors.white];

List<Color> textButtonColors = [Colors.white, Colors.black];

List<Color> textColors = [
  Colors.black,
  Colors.black,
];

List<Color> textColors1 = [
  Colors.black,
  Colors.white,
];

List<Color> textDateColors = [Colors.red, Colors.red];

class ColorProvider extends ChangeNotifier {
  List<Color> _backgroundColor = data[ColorPreference().primaryColor];

  Color _buttonColor = buttonsColor[ColorPreference().primaryColor];

  Color _textButtonColor = textButtonColors[ColorPreference().primaryColor];

  Color _textColor = textColors[ColorPreference().primaryColor];

  Color _textColor1 = textColors1[ColorPreference().primaryColor];

  Color _textDateColor = textDateColors[ColorPreference().primaryColor];

  Color get textDateColor => _textDateColor;

  Color get textColor1 => _textColor1;

  void changeTextColor1(int position) {
    ColorPreference().primaryColor = position;

    _textColor1 = textColors1[ColorPreference().primaryColor];
    notifyListeners();
  }

  void changeTextDateColor(int position) {
    ColorPreference().primaryColor = position;

    _textDateColor = textDateColors[ColorPreference().primaryColor];
    notifyListeners();
  }

  Color get textButtonColor => _textButtonColor;

  Color get textColor => _textColor;

  void changeTextColor(int position) {
    ColorPreference().primaryColor = position;

    _textColor = textColors[ColorPreference().primaryColor];
    notifyListeners();
  }

  void changeTextButtonColor(int position) {
    ColorPreference().primaryColor = position;
    _textButtonColor = textButtonColors[ColorPreference().primaryColor];
    notifyListeners();
  }

  Color get buttonColor => _buttonColor;

  void changeButtonColor(int position) {
    ColorPreference().primaryColor = position;
    _buttonColor = buttonsColor[ColorPreference().primaryColor];
    notifyListeners();
  }

  List<Color> get backgroundColor => _backgroundColor;

  void changeBackgroundColor(int color) {
    ColorPreference().primaryColor = color;
    _backgroundColor = data[ColorPreference().primaryColor];
    notifyListeners();
  }
}
