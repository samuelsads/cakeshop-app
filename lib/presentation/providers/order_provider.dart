import 'package:flutter/material.dart';

class OrderProvider with ChangeNotifier {
  bool _downOrUp = false;
  PageController _pageController = PageController();
  int _currentPage = 0;

  int get currentPage => _currentPage;

  void changePage(int valor) {
    _currentPage = valor;
  }

  set currentPage(int valor) {
    _currentPage = valor;

    _pageController.jumpToPage(valor);
    notifyListeners();
  }

  PageController get pageController => _pageController;

  bool get downOrUp => _downOrUp;

  set downOrUp(bool status) {
    _downOrUp = status;
    notifyListeners();
  }
}
