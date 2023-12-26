// ignore_for_file: unused_field

import 'package:flutter/cupertino.dart';

import 'package:loventine_flutter/services/chat/chat_room_service.dart';

import '../../models/chat/get.dart';

class ChatSearchProvider extends ChangeNotifier {
  late List<ChatRoom> _chatRooms;
  List<ChatRoom> get chatRooms => _chatRooms;

  late String _searchString;

  void initSearchPage() {
    _chatRooms.clear();
    _isLoadingMoreOtherUsers = false;
    _isLoadingSearchChatRoom = false;
    _isLoadingSearchUser = false;
    _isLoadingGetChatRoom = false;
    _searchString = '';
  }

  void setterSearchString(String searchString) {
    _searchString = searchString;
  }

  bool _isLoadingMoreOtherUsers = false;
  bool get isLoadingMoreOtherUsers => _isLoadingMoreOtherUsers;

  void initMoreOtherUsersPage() async {
    try {
      _isLoadingMoreOtherUsers = true;
      notifyListeners();

      // _users = await UserService.searchOtherUserInChat(
      //     _searchString, chat_search_user_max);

      _isLoadingMoreOtherUsers = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoadingMoreOtherUsers = false;
      notifyListeners();
    }
  }

  bool _isLoadingSearchChatRoom = false;
  bool get isLoadingSearchChatRoom => _isLoadingSearchChatRoom;

  bool _isLoadingSearchUser = false;
  bool get isLoadingSearchUser => _isLoadingSearchUser;

  void search(String searchString) async {
    try {
      if (_isLoadingSearchChatRoom == true) {
        return;
      }
      _isLoadingSearchChatRoom = true;
      notifyListeners();

      _chatRooms = await ChatRoomService.gets(
        0,
        100,
        null,
        -1,
        null,
        searchString,
        null,
        null,
        null,
      );

      _isLoadingSearchChatRoom = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoadingSearchChatRoom = false;
      notifyListeners();
    }
  }

  bool _isLoadingGetChatRoom = false;
  bool get isLoadingGetChatRoom => _isLoadingGetChatRoom;
  Future<ChatRoom> getChatRoomFromChatRoomItem(ChatRoom chatRoomItem) async {
    try {
      if (_isLoadingGetChatRoom == false) {
        _isLoadingGetChatRoom = true;
        var chatRoom = await ChatRoomService.getOne(chatRoomItem.sId);
        _isLoadingGetChatRoom = false;
        return chatRoom;
      }
      throw ('error');
    } catch (e) {
      _isLoadingGetChatRoom = false;
      print(e);
      throw (e);
    }
  }
}
