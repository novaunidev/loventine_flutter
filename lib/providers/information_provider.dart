

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class InformationProvider with ChangeNotifier {
  String _sex = "Không muốn trả lời";
  String get sex => _sex;

  String _birthday = "";
  String get birthday => _birthday;

  XFile _pickedFile = XFile("");
  XFile get pickedFile => _pickedFile;

  bool _isSignUp = false;
  bool get isSignUp => _isSignUp;


  setSex(int sex) {
    _sex = sex == 1
        ? "Không muốn trả lời"
        : sex == 2
            ? "Nam"
            : sex == 3
                ? "Nữ"
                : sex == 4
                    ? "Đồng tính nam"
                    : sex == 5
                        ? "Đồng tính nữ"
                        : sex == 6
                            ? "Song tính"
                            : "Chuyển giới";
    notifyListeners();
  }

  setPickedFile(XFile file) {
    _pickedFile = file;
    print(file.path);
    notifyListeners();
  }


  setBirthday(String birthday) {
    _birthday = birthday;
    notifyListeners();
  }

  setIsSignUpTrue(){
    _isSignUp = true;
    notifyListeners();
  }

  setIsSignUpFalse(){
    _isSignUp = false;
    notifyListeners();
  }
}
