import 'package:http/http.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import '../../config.dart' as config;

class MessageService {
  static Future<void> create(
    String chatRoomId,
    String userId,
    String type,
    String _message,
  ) async {
    try {
      var uri = Uri.parse(
        config.urlMessage,
      );
      Response res = await post(
        uri,
        body: {
          'message': _message,
          'userId': userId,
          'chatRoomId': chatRoomId,
          'type': type,
        },
        headers: await appAuth.createHeaders(),
      );
      appAuth.checkResponse(res);
      if (res.statusCode == 200) {
      } else {
        throw "Failed to create message";
      }
    } catch (e) {
      print(e);
    }
  }
}
