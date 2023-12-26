// ignore_for_file: unused_field

import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import '../../../providers/app_socket.dart';
import '../../constant.dart';
import '../../services/notification/notifi_service.dart' as NotifiLocal;
import '../../services/notification/notification_service.dart';
import '../../models/notification.dart' as NotificationModel;
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

final _winNotifyPlugin = WindowsNotification(
    applicationId:
        r"{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}\WindowsPowerShell\v1.0\powershell.exe");

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel.Notification> _notifications = [];
  List<NotificationModel.Notification> get notifications => _notifications;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoading;

  // only increase when last api get is not empty
  int _page = 0;

  void init() {
    _page = 0;
    _isLoading = false;
    _isLoadingMore = false;
    _notifications.clear();
    getMyNotification();
  }

  void NotificationProvider_init_socket() {
    appSocket.socket.on('receive_notification', (jsonData) {
      print('receive_notification');

      final new_t = json.encode(jsonData);
      final data = json.decode(new_t) as Map<String, dynamic>;
      print('kiet');
      print(data);

      NotifiLocal.NotificationService().showNotification(
        title: 'Thông báo',
        body: data['notification_body'],
        payLoad: data['notification_name_screen'],
      );

      NotificationMessage message = NotificationMessage.fromPluginTemplate(
        "01",
        "Thông báo",
        data['notification_body'],
      );

      // show notification
      _winNotifyPlugin.showNotificationPluginTemplate(message);

      getMyNotification();
    });
  }

  void getMyNotification() async {
    _isLoading = true;
    notifyListeners();

    _notifications.clear();
    _notifications = await NotificationService.getMyNotification(
        SocketProvider.current_user_id,
        _page * notificationPerPage,
        notificationPerPage);

    if (_notifications.isNotEmpty) {
      _page++;
    }
    _isLoading = false;
    notifyListeners();
  }

  void getMore() async {
    _isLoadingMore = true;
    notifyListeners();

    var data = await NotificationService.getMyNotification(
        SocketProvider.current_user_id,
        _page * notificationPerPage,
        notificationPerPage);
    if (data.isNotEmpty) {
      _page++;
    }
    data.forEach((element) {
      _notifications.add(element);
    });

    _isLoadingMore = false;
    notifyListeners();
  }
}
