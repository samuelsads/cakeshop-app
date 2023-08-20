import 'package:flutter/material.dart';

class MainPageProvider extends ChangeNotifier {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  int get currentPage => _currentPage;

  set currentPage(int current) {
    _currentPage = current;
    _pageController.jumpToPage(
      current,
    );

    notifyListeners();
  }

  PageController get pageController => _pageController;
}
