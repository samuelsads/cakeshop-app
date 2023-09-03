import 'package:flutter/material.dart';

class BoxdecorationCustom {
  static BoxDecoration customBoxdecoration() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.pink.shade50, Colors.pink.shade100]));
  }
}
