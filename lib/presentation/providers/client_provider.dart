import 'package:flutter/foundation.dart';

class ClientProvider extends ChangeNotifier {
  bool _downOrUp = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool status) {
    _isLoading = status;
    notifyListeners();
  }

  bool get downOrUp => _downOrUp;

  set downOrUp(bool status) {
    _downOrUp = status;
    notifyListeners();
  }
}
