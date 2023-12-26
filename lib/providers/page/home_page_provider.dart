import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePageProvider with ChangeNotifier {
  late ScrollController _controllerPagination;
  bool _isScrollingDown = false;
  final ValueNotifier<bool> _showAppbar = ValueNotifier(true);

  void scrollToTop() {
    _controllerPagination
        .animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    )
        .then((_) {
      _isScrollingDown = false;
      _showAppbar.value = true;
    });
  }

  void myScroll() {
    _controllerPagination.addListener(() {
      final direction = _controllerPagination.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        if (!_isScrollingDown) {
          _isScrollingDown = true;
          _showAppbar.value = false;
        }
      }
      if (direction == ScrollDirection.forward) {
        if (_isScrollingDown) {
          _isScrollingDown = false;
          _showAppbar.value = true;
        }
      }
    });
  }

  ValueNotifier<bool> get showAppbar => _showAppbar;
  set controllerPagination(ScrollController controller) {
    _controllerPagination = controller;
  }
}
