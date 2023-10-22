import 'package:cakeshopapp/config/sharepreferences/color_preference.dart';
import 'package:flutter/material.dart';

List data = [
  [Colors.pink.shade50, Colors.pink.shade100],
  [Colors.blue.shade50, Colors.black]
];

List<Color> buttonsColor = [Colors.black, Colors.white];

List<Color> textButtonColors = [Colors.white, Colors.black];

class ColorProvider extends ChangeNotifier {
  List<Color> _backgroundColor = data[ColorPreference().primaryColor];

  Color _buttonColor = buttonsColor[ColorPreference().primaryColor];

  Color _textButtonColor = textButtonColors[ColorPreference().primaryColor];

  Color get textButtonColor => _textButtonColor;

  void changeTextButtonColor(int position) {
    _textButtonColor = textButtonColors[position];
    notifyListeners();
  }

  Color get buttonColor => _buttonColor;

  void changeButtonColor(int position) {
    _buttonColor = buttonsColor[position];
    notifyListeners();
  }

  List<Color> get backgroundColor => _backgroundColor;

  void changeBackgroundColor(int color) {
    ColorPreference().primaryColor = color;
    _backgroundColor = data[ColorPreference().primaryColor];
    notifyListeners();
  }
}
