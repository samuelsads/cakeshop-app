import 'package:flutter/material.dart';

class CustomStyles {
  static TextStyle titleStyle() => const TextStyle(
      fontSize: 20, color: Colors.black, fontWeight: FontWeight.w600);

  static TextStyle descriptionStyle() => const TextStyle(
      fontSize: 10, color: Colors.grey, fontWeight: FontWeight.w500);

  static TextStyle dontHaveResult(Color color) =>
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color);

  static TextStyle text14W800(Color color) =>
      TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w800);

  static TextStyle text14W400(Color color) =>
      TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w400);

  static TextStyle text20W500(Color color) =>
      TextStyle(fontSize: 20, color: color, fontWeight: FontWeight.w500);

  static TextStyle text24W800(Color color) =>
      TextStyle(fontSize: 24, color: color, fontWeight: FontWeight.w800);

  static TextStyle text12W500(Color color) =>
      TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w500);

  static TextStyle text10W500(Color color) =>
      TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w500);
}
