import 'package:flutter/cupertino.dart';
import 'package:loventine_flutter/constant.dart';
import '../../models/chat/get.dart';
import 'package:loventine_flutter/providers/app_socket.dart';

import '../../services/chat/chat_room_service.dart';

class ChatRoomProvider extends ChangeNotifier {
  List<ChatRoom> _chatRooms = [];
  List<ChatRoom> get chatRooms => _chatRooms;

  // only increase when last api get is not empty
  int page = 0;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool isInitFirstTime = false;

  init() {
    try {
      page = 0;
      _chatRooms.clear();
      if (isInitFirstTime == false) {
        appSocket.socket.on('reload_chatRooms', getChatRooms);
        isInitFirstTime = true;
      }
    } catch (e) {
      print(e);
    }
  }

  void getChatRooms(value) async {
    try {
      print("getChatRooms.......");
      if (_chatRooms.isEmpty) {
        _isLoading = true;
        notifyListeners();
      }

      await ChatRoomService.gets(
        0,
        chatRoomPerPage,
        null,
        -1,
        -1,
        null,
        null,
        null,
        null,
      ).then((value) {
        _chatRooms = value;
        _isLoading = false;
        if (_chatRooms.isNotEmpty) {
          page++;
        }
        _num_message_unwatch = ChatRoomService.num_message_unwatch;
        notifyListeners();
      });
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      print(e);
    }
  }

  void getMoreChatRooms() async {
    try {
      if (page < limitPage) {
        _isLoadingMore = true;
        notifyListeners();

        await ChatRoomService.gets(
          page * chatRoomPerPage,
          chatRoomPerPage,
          null,
          -1,
          -1,
          null,
          null,
          null,
          null,
        ).then((value) {
          if (value.isNotEmpty) {
            page++;
          }
          for (var i = 0; i < value.length; i++) {
            _chatRooms.add(value[i]);
          }

          _isLoading = false;
          notifyListeners();
        });
        _num_message_unwatch = ChatRoomService.num_message_unwatch;
        _isLoadingMore = false;
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  int _num_message_unwatch = 0;
  int get num_message_unwatch => _num_message_unwatch;
}
