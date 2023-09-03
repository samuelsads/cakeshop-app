import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  bool _downOrUp = false;

  bool get downOrUp => _downOrUp;

  set downOrUp(bool status) {
    _downOrUp = status;
    notifyListeners();
  }
}
