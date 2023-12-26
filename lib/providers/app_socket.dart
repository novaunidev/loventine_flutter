import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:loventine_flutter/providers/chat/chat_room_provider.dart';

import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../config.dart';
import 'chat/socket_provider.dart';
import 'notification/notification_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSocket {
  late IO.Socket _socket;
  IO.Socket get socket => _socket;
  bool isFirstTime = true;
  static bool is_connect_to_server = false;

  init(String current_user_id, BuildContext context) async {
    try {
      appAuth.handleAuth();

      is_connect_to_server = false;

      // _socket.dispose();
      print("kiet debug ${current_user_id}");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // ignore: unused_local_variable
      String? _userId = prefs.getString('userId');

      await prefs.setString('userId', current_user_id);

      if (isFirstTime == true) {
        isFirstTime = false;
      }

      _socket = IO.io(
        baseUrl,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .enableForceNew()
            .setQuery({'token': 'token_str'})
            .build(),
      );

      // Handle socket events
      _socket.on('connect', (_) {
        print('connect: ${_socket.id}');
        Map data = {'userId': current_user_id, 'socket_id': _socket.id};
        is_connect_to_server = true;
        _socket.emit('update_client', data);
        Future.delayed(const Duration(seconds: 3), () async {
          await prefs.setBool('is_allowed_connect_socket_background', true);
        });
      });

      _socket.on('server_connect', (_) {
        print('connect: ${_socket.id}');
        Map data = {'userId': current_user_id, 'socket_id': _socket.id};
        is_connect_to_server = true;
        _socket.emit('update_client', data);
      });
      _socket.on('disconnect', (_) {
        print('disconnect');
      });
      _socket.onDisconnect((_) => print('disconnect 001'));

      _socket.connect();

      Map data = {'userId': current_user_id, 'socket_id': _socket.id};

      _socket.emit('update_client', data);

      SocketProvider.current_user_id = current_user_id;
      // await Provider.of<SocketProvider>(context, listen: false).init();

      Provider.of<NotificationProvider>(context, listen: false)
          .NotificationProvider_init_socket();

      Provider.of<ChatRoomProvider>(context, listen: false).init();

      Provider.of<CallProvider>(context, listen: false).setIsInCallPage(false);

      if (!Platform.isWindows) {
        Provider.of<CallProvider>(context, listen: false).init();
      }
    } catch (e) {
      print(e);
    }
  }

  close() {
    try {
      _socket.dispose();
    } catch (e) {
      print(e);
    }
  }
}

final appSocket = AppSocket();
