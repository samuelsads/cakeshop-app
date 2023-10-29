import 'package:flutter/foundation.dart';

class ClientProvider extends ChangeNotifier {
  bool _downOrUp = false;
  bool get downOrUp => _downOrUp;

  set downOrUp(bool status) {
    _downOrUp = status;
    notifyListeners();
  }
}
