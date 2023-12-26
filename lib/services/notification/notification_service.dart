import 'dart:convert';
import 'package:http/http.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import '../../../config.dart';
import '../../models/notification.dart';

class NotificationService {
  static int num_notification_unwatch = 0;
  static Future<String> updateIsWatchedNotifications(
    String notificationId,
  ) async {
    try {
      var uri = Uri.parse("$urlNotification/$notificationId");

      Response res = await patch(
        uri,
        headers: await appAuth.createHeaders(),
      );

      if (res.statusCode == 200) {
        return "pass";
      }
    } catch (e) {
      print(e);
    }
    return "error";
  }

  static Future<List<Notification>> getMyNotification(
      String userId, int skipNum, int limitNum) async {
    try {
      Map<String, String> paramsValue = Map<String, String>();
      paramsValue["userId"] = userId;
      paramsValue["skipNum"] = skipNum.toString();
      paramsValue["limitNum"] = limitNum.toString();
      var uri =
          Uri.parse(urlNotification).replace(queryParameters: paramsValue);

      Response res = await get(
        uri,
        headers: await appAuth.createHeaders(),
      );
      appAuth.checkResponse(res);
      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('params :');
        print(paramsValue);
        print('response :');
        print(json.decode(res.body));
      }

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        num_notification_unwatch = body['num_notification_unwatch'];
        List<dynamic> data = body['data'];
        List<Notification> notifications =
            data.map((dynamic item) => Notification.fromJson(item)).toList();
        return notifications;
      }
    } catch (e) {
      print('getAllWithUserId error');
      print(e);
      return [];
    }
    return [];
  }
}
