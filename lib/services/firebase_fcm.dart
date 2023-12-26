import 'package:firebase_messaging/firebase_messaging.dart';
import '../../services/notification/notifi_service.dart' as NotifiLocal;
import 'package:loventine_flutter/config.dart';
import 'package:dio/dio.dart';

class FirebaseFCM {
  Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
    final token = await messaging.getToken();
    print("token: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (message.notification != null) {
        NotifiLocal.NotificationService().showNotification(
          title: message.notification!.title,
          body: message.notification!.body,
          payLoad: 'notification',
        );
      }
    });
  }

  Future<void> addToken(String userId, List<String> fcm_tokens) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();

    if (token != null && !fcm_tokens.contains(token)) {
      fcm_tokens.add(token);
      print("token login: $fcm_tokens");
      await Dio().put('$baseUrl/auth/updateUser/$userId',
          data: {'fcm_tokens': fcm_tokens});
    }
  }

  Future<void> removeToken(String userId, List<String> fcm_tokens) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();

    fcm_tokens.remove(token);
    print("token logout: $fcm_tokens");
    await Dio().put('$baseUrl/auth/updateUser/$userId',
        data: {'fcm_tokens': fcm_tokens});
  }
}
