import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter/foundation.dart';
import 'package:loventine_flutter/models/hives/userid.dart';

import 'package:flutter/material.dart';

class SocketProvider extends ChangeNotifier {
  SocketProvider() {
    initialize();
  }

  Future<void> initialize() async {
    final box = Hive.box<UserId>('userBox');
    UserId? userId = box.get('userid');
    if (userId != null) {
      current_user_id = userId.userid!;
    }
    notifyListeners();
  }

  static String current_user_id = ''; //''63283a8550714dd6a28d1478';
}
