import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewProvider with ChangeNotifier {
  late bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isSnackbarActive = false;
  bool get isSnackbarActive => _isSnackbarActive;
}
