import 'package:flutter/material.dart';

class VerifyProvider with ChangeNotifier {
  String _identity = "cccd";
  String get identity => _identity;

  String _photo = "";
  String get photo => _photo;
   setIndentity(int identity) {
    _identity = identity == 0
        ? "cccd"
        : identity == 1
            ? "cmnd"
            : "gplx";
    notifyListeners();
  }

  setPhoto(String photo) {
    _photo = photo;
    notifyListeners();
  }
}
