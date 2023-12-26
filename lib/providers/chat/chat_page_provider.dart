// ignore_for_file: unnecessary_set_literal

import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/chat/get.dart';
import '../../widgets/scroll_to_index/scroll_to_index.dart';
import '../app_socket.dart';
import '../../services/chat/image_service.dart';
import 'package:uuid/uuid.dart';
import '../../services/notification/notifi_service.dart' as NotifiLocal;

class ChatPageProvider extends ChangeNotifier {
  List<Message> _messages = [];
  int page = 0;

  ///===>
  // final _dio = Dio();

  bool _statusCode = false;
  bool get statusCode => _statusCode;

  ///===>

  List<Message> _messagesCustom = [];
  List<Message> get messagesCustom => _messagesCustom;

  late ChatRoom _chatRoom;
  ChatRoom get chatRoom => _chatRoom;

  // ScrollController controller = ScrollController();
  late bool isFirstTimeNavigateToPage = true;
  late bool isTop = true;
  late bool isNotTop = false;
  List<int> indexOnViews = [];
  late bool isLoading = false;

  bool _isLoadingInit = false;
  bool get isLoadingInit => _isLoadingInit;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool isUpdatedApply = false;
  bool isLoadingMessages = false;

  final AutoScrollController controller = AutoScrollController();

  bool _isLoadingKeyBoard = false;
  bool get isLoadingKeyBoard => _isLoadingKeyBoard;

  Future<void> jumbToLastedMessage(int position, {Duration? duration}) async {
    print("❗❗❗❗đang ở đây nè");
    if (_messages.isEmpty) return;

    duration ??= const Duration(milliseconds: 200);

    await controller.scrollToIndex(position,
        preferPosition: AutoScrollPosition.begin, duration: duration);
  }

  Future jumbWhenShowKeyBoard() async {
    _isLoadingKeyBoard = true;

    print("❗❗❗❗đang ở đây nè");
    if (_messages.isEmpty) return;
    if (_messagesCustom.isNotEmpty && isTop == false) {
      await controller.scrollToIndex(0,
          //  duration : const  Duration(milliseconds: 200),
          preferPosition: AutoScrollPosition.begin);
    }

    await Future.delayed(Duration(seconds: 1), () {
      _isLoadingKeyBoard = false;
    });
  }

  Map<String, dynamic> apply = {};
  bool isLoading_apply = false;

  // String partnerId = "";
  // // String applyState = '';

  // int myUnWatched = 0;
  // int partnerUnWatched = 0;

  bool _isBottom = true;
  bool get isBottom => _isBottom;

  void init(ChatRoom chatRoom) async {
    _chatRoom = chatRoom;
    // getCurrentApply();
    // applyState = widget.chatRoom.apply_state;

    //itemScrollController.jumpTo(index: list.length, alignment: 1.0);
    _messages.clear();
    _messagesCustom.clear();
    indexOnViews.clear();
    _messages = [];
    _messagesCustom = [];
    indexOnViews = [];
    isFirstTimeNavigateToPage = true;
    page = 1;
    _isLoadingImage = false;
    _isLoadingMore = false;
    _isTyping = false;
    _isBottom = true;
    _isLoadingKeyBoard = false;

    // if (chatRoom.UserId1 == SocketProvider.current_user_id) {
    //   partnerUnWatched = chatRoom.NumberUnWatched_2;
    //   myUnWatched = chatRoom.NumberUnWatched_1;
    // } else {
    //   partnerUnWatched = chatRoom.NumberUnWatched_1;
    //   myUnWatched = chatRoom.NumberUnWatched_2;
    // }
    if (_chatRoom.partner.numUnwatched > 0) {
      _isSeen = false;
    } else {
      _isSeen = true;
    }

    joinChat(chatRoom.sId);

    if (isFirstTimeNavigateToPage) {
      _isLoadingInit = true;
      notifyListeners();

      await getMessages();
      _isLoadingInit = false;
      notifyListeners();

      isFirstTimeNavigateToPage = false;
    }
    // check top or bottom of message view

    // jumbToLastedMessage(0, duration: const Duration(milliseconds: 50));

    // itemPositionsListener.itemPositions.addListener(() async {
    //   if (_messages.isEmpty) return;
    //   final indices = itemPositionsListener.itemPositions.value
    //       .where((item) {
    //         final isTopVisible = item.itemLeadingEdge >= 0;
    //         final isBottomVisible = item.itemTrailingEdge <= 1;

    //         return isTopVisible && isBottomVisible;
    //       })
    //       .map((item) => item.index)
    //       .toList();

    //   if (indices.contains(0) == false) {
    //     isNotTop = true;
    //   }

    //   isTop = indices.contains(0);
    //   _isBottom = indices.contains(_messagesCustom.length - 1);
    //   notifyListeners();

    //   if (isNotTop == true &&
    //       isTop == true &&
    //       listEquals(indexOnViews, indices) == false &&
    //       isFirstTimeNavigateToPage == false // if go down and go up to top
    //       &&
    //       indices.length != _messagesCustom.length) {
    //     _isLoadingMore = true;
    //     notifyListeners();

    //     await getMessages();
    //     _isLoadingMore = false;
    //     notifyListeners();

    //     isNotTop = false;
    //   }

    //   indexOnViews = indices;

    //   indices.clear();
    // });
    // controller.addListener(() async {
    //   if (controller.offset >= controller.position.maxScrollExtent &&
    //       !controller.position.outOfRange) {
    //     // At the end of the list
    //     _isBottom = true;
    //     notifyListeners();
    //   }

    //   if (controller.offset <= controller.position.minScrollExtent &&
    //       !controller.position.outOfRange) {
    //     // At the top of the list
    //     isTop = true;
    //     notifyListeners();

    //     if (isTop == true && isFirstTimeNavigateToPage == false) {
    //       _isLoadingMore = true;
    //       notifyListeners();

    //       await getMessages();

    //       _isLoadingMore = false;
    //       notifyListeners();

    //       isNotTop = false;
    //     }
    //   }
    // });

    //=====>
    // controller.addListener(() async {
    //   if (controller.offset >= controller.position.maxScrollExtent &&
    //       !controller.position.outOfRange) {
    //     // At the end of the list
    //     _isBottom = true;
    //     notifyListeners();
    //   }

    //   if (controller.offset <= controller.position.minScrollExtent &&
    //       !controller.position.outOfRange) {
    //     // At the top of the list
    //     isTop = true;
    //     notifyListeners();

    //     if (isTop == true &&
    //         isFirstTimeNavigateToPage == false &&
    //         !isLoadingMessages) {
    //       _isLoadingMore = true;
    //       notifyListeners();

    //       isLoadingMessages = true; // Đánh dấu là đang gọi hàm getMessages()

    //       await getMessages();

    //       _isLoadingMore = false;
    //       notifyListeners();

    //       //isNotTop = false;

    //       isLoadingMessages =
    //           false; // Đánh dấu là đã hoàn thành gọi hàm getMessages()
    //     }
    //   }
    // });

    controller.addListener(() async {
      if (controller.offset <= controller.position.minScrollExtent &&
          !controller.position.outOfRange) {
        // At the top of the list
        _isBottom = false;
        _isBottom = true;
        notifyListeners();
      }

      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        // At the end of the list
        isTop = false;

        notifyListeners();

        if (isTop == false &&
            isFirstTimeNavigateToPage == false &&
            !isLoadingMessages) {
          _isLoadingMore = true;
          notifyListeners();

          isLoadingMessages = true; // Đánh dấu là đang gọi hàm getMessages()

          await getMessages();

          _isLoadingMore = false;
          notifyListeners();

          isLoadingMessages =
              false; // Đánh dấu là đã hoàn thành gọi hàm getMessages()
        }
      }
    });
  }

  Future<void> getMessageChatRoom(String chatRoomId, int numLoad) async {
    print("Đang get messages");
    print(page);
    try {
      Response result = await post(
        Uri.parse(urlGetMessageChatRoom + chatRoomId),
        body: {
          'numLoad': numLoad.toString(),
          'userId': SocketProvider.current_user_id,
        },
        headers: await appAuth.createHeaders(),
      );
      appAuth.checkResponse(result);
      var body = jsonDecode(result.body);

      List<dynamic> data = body as List<dynamic>;

      for (int i = 0; i < data.length; i++) {
        _messages.add(Message.toMessage(data[i] as Map<String, dynamic>));
      }

      notifyListeners();
    } catch (e) {
      print('get message error');
      print(e);
      _messages = [];
      notifyListeners();
    }
  }

  Future<void> getMessages() async {
    try {
      print('get messages...');

      // update _message
      await getMessageChatRoom(_chatRoom.sId, page)
          .whenComplete(() => {page++});
      customMessages();
    } catch (e) {
      print(e);
    }
  }

  /*
  Add row date
  */
  Future<void> customMessages() async {
    // update _messagesCustom
    try {
      var customMessages = <Message>[];

      List<Message> temp = _messages.where((message) {
        return message.type != "isDate";
      }).toList();

      for (int i = 0; i < temp.length; i++) {
        Message message = Message(
            sId: temp[i].sId,
            message: temp[i].message,
            userId: temp[i].userId,
            type: temp[i].type,
            chatRoomId: temp[i].chatRoomId,
            isDeleted: false,
            isSent: true);
        message.createdAt = temp[i].createdAt;
        if (temp[i].type == MESSAGE_TYPE.STATUS) {
          if (temp[i].userId == SocketProvider.current_user_id) {
            if (temp[i].message.indexOf(_chatRoom.me.name) == -1) {
              temp[i].message = _chatRoom.me.name + " " + temp[i].message;
            }
          } else {
            if (temp[i].message.indexOf(_chatRoom.partner.name) == -1) {
              temp[i].message = _chatRoom.partner.name + " " + temp[i].message;
            }
          }
        }
        customMessages.add(temp[i]);
        if (i == _messages.length - 1) {
          var newMessage = message;
          newMessage.message = (message.createdAt as String).substring(0, 10);
          newMessage.type = "isDate";
          customMessages.add(newMessage);
        } else {
          var oldMessageDate =
              (temp[i + 1].createdAt as String).substring(0, 10);
          var meesageDate = (message.createdAt as String).substring(0, 10);
          if (oldMessageDate != meesageDate) {
            var newMessage = message;
            newMessage.message = (message.createdAt as String).substring(0, 10);
            newMessage.type = "isDate";
            customMessages.add(newMessage);
          }
        }
        // print(temp[i].toJson());
      }
      // _messagesCustom.clear();

      _messagesCustom = customMessages;
      // customMessages.clear();
      temp.clear();
    } catch (e) {
      print(e);
    }
  }

  void make_message_distinct() {
    var seen = Set<String>();
    _messages = _messages.where((message) => seen.add(message.sId)).toList();
  }

  bool _isTyping = false;
  bool get isTyping => _isTyping;

  bool _isSeen = false;
  bool get isSeen => _isSeen;

  bool isInitSocket = false;

  void joinChat(String chatRoomId) {
    print('join chat');
    try {
      Map data = {
        'value': chatRoomId,
        'userId1': _chatRoom.me.sId,
        'userId2': _chatRoom.partner.sId,
      };
      appSocket.socket.emit("join_chat_room", data);

      if (_chatRoom.me.numUnwatched > 0) {
        Map data = {
          'chatRoomId': _chatRoom.sId,
          'toUseId': _chatRoom.partner.sId,
        };

        appSocket.socket.emit("send_seen", data);
      }

      if (isInitSocket == false) {
        isInitSocket = true;

        appSocket.socket.on('receive_message', (jsonData) async {
          print('get message from another');
          print(jsonData);

          final new_t = json.encode(jsonData);
          final data = json.decode(new_t) as Map<String, dynamic>;

          Message message = Message.fromJson(data);
          message.createdAt = DateTime.now().toIso8601String();
          if (message.chatRoomId == _chatRoom.sId) {
            if (message.userId != SocketProvider.current_user_id) {
              Map _data = {
                'chatRoomId': _chatRoom.sId,
                'toUseId': _chatRoom.partner.sId,
              };
              appSocket.socket.emit("send_seen", _data);
            }

            print('reload data here');

            _messages = [..._messages.reversed.toList(), message];
            _messages = _messages.reversed.toList();

            make_message_distinct();

            await customMessages();

            jumbToLastedMessage(0);

            _isSeen = false;
            notifyListeners();

            SharedPreferences prefs = await SharedPreferences.getInstance();
            String? app_state = prefs.getString('app_state');
            if (app_state == 'PAUSED') {
              NotifiLocal.NotificationService().showNotification(
                title: 'Thông báo',
                body: "${_chatRoom.partner.name} đã gửi tin nhắn",
                payLoad: 'chat_screen',
              );
            }
          }
        });

        appSocket.socket.on('receive_seen', (jsonData) {
          final new_t = json.encode(jsonData);
          final data = json.decode(new_t) as Map<String, dynamic>;
          print('kiet receive_seen');
          if (data['toUseId'] == SocketProvider.current_user_id) {
            _isSeen = true;
            // if (_isBottom == false) return;

            print('receive_seen');
            notifyListeners();

            jumbToLastedMessage(0);
            // Future.delayed(const Duration(milliseconds: 500), () {
            //   jumbToLastedMessage(_messagesCustom.length);
            // });
          }
        });

        appSocket.socket.on('receive_typing', (jsonData) {
          final new_t = json.encode(jsonData);
          final data = json.decode(new_t) as Map<String, dynamic>;

          if (_isTyping == false &&
              _isBottom &&
              data['toUseId'] == SocketProvider.current_user_id) {
            _isTyping = true;
            notifyListeners();
            print('typing');

            //jumbToLastedMessage(_messagesCustom.length);

            Future.delayed(const Duration(seconds: 5), () {
              _isTyping = false;
              _isBottom = true;
              notifyListeners();
              //jumbToLastedMessage(_messagesCustom.length);
            });

            // Future.delayed(const Duration(seconds: 2), () {
            //   jumbToLastedMessage(_messagesCustom.length);
            // });
          }
        });

        appSocket.socket.on('update_message_id', (jsonData) {
          try {
            print('update_message_id 000');
            final new_t = json.encode(jsonData);
            final data = json.decode(new_t) as Map<String, dynamic>;

            updateMessageId(data['messageId'], data['value']);
          } catch (e) {
            print('update message id error');
          }
        });

        appSocket.socket.on('receive_delete_message', (jsonData) {
          print('receive_delete_message');
          print(jsonData);

          final new_t = json.encode(jsonData);
          final data = json.decode(new_t) as Map<String, dynamic>;

          Message messageDeleted = Message.fromJson(data);
          messageDeleted.createdAt = DateTime.now().toIso8601String();
          print('id = ${messageDeleted.sId}');
          for (var message in _messages) {
            print('#${message.sId}');
            if (message.sId == messageDeleted.sId) {
              message.isDeleted = true;
              customMessages();
              notifyListeners();
              break;
            }
          }
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void leaveChat() {
    try {
      _messages.clear();
      _messagesCustom.clear();
      indexOnViews.clear();
      _messages = [];
      _messagesCustom = [];
      indexOnViews = [];

      Map data = {'value': '${_chatRoom.sId}'};
      appSocket.socket.emit("leave_chat_room", data);
      // SocketProvider.filterText_MessagePage = '';
    } catch (e) {
      print(e);
    }
  }

  void sendTyping() {
    try {
      Map data = {
        'chatRoomId': _chatRoom.sId,
        'toUseId': _chatRoom.partner.sId,
      };
      appSocket.socket.emit("send_typing", data);
    } catch (e) {
      print(e);
    }
  }

  void sendMessageText(String text) {
    try {
      Message message = Message(
        sId: const Uuid().v1(),
        message: text,
        userId: SocketProvider.current_user_id,
        chatRoomId: _chatRoom.sId,
        type: MESSAGE_TYPE.TEXT,
        isDeleted: false,
        isSent: false,
      );

      appSocket.socket.emit(
        'send_message',
        message.toJson(),
      );

      message.createdAt = DateTime.now().toIso8601String();

      _messages = [..._messages.reversed.toList(), message];
      _messages = _messages.reversed.toList();
      customMessages();

      _isSeen = false;

      notifyListeners();
      // jumbToLastedMessage(1);

      // controller.scrollToIndex(_messages.length,
      //     preferPosition: AutoScrollPosition.end);
      //print(message.toJson());
    } catch (e) {
      print(e);
    }
  }

  void sendMessageImage() {
    try {
      jumbToLastedMessage(1);
      // Future.delayed(const Duration(milliseconds: 50), () {
      //   jumbToLastedMessage(_messagesCustom.length);
      // });
    } catch (e) {
      print(e);
    }
  }

  void callAudio() {
    try {} catch (e) {
      print(e);
    }
  }

  void callVideo() {
    try {} catch (e) {
      print(e);
    }
  }

  void report() {
    try {} catch (e) {
      print(e);
    }
  }

  void getApply() {
    try {} catch (e) {
      print(e);
    }
  }

  bool _isLoadingImage = false;
  bool get isLoadingImage => _isLoadingImage;

  // void uploadImage(XFile file) {
  //   _isLoadingImage = true;
  //   notifyListeners();

  //   ImageService.uploadFile(file).then((value) {
  //     Message message = Message(
  //       sId: const Uuid().v1(),
  //       message: value,
  //       userId: SocketProvider.current_user_id,
  //       chatRoomId: _chatRoom.sId,
  //       type: "isImage",
  //       isDeleted: false,
  //     );

  //     appSocket.socket.emit(
  //       'send_message',
  //       message.toJson(),
  //     );
  //     message.createdAt = DateTime.now().toIso8601String();

  //     _messages = [..._messages.reversed.toList(), message];
  //     _messages = _messages.reversed.toList();
  //     customMessages();

  //     _isLoadingImage = false;
  //     notifyListeners();

  //     if (_messagesCustom.isNotEmpty) {
  //       jumbToLastedMessage(1);
  //     }
  //   });
  // }

  Future<void> uploadImages(List<AssetEntity> assets) async {
    _isLoadingImage = true;
    notifyListeners();
    ImageService.uploadFiles(assets).then((value) {
      Message message = Message(
        sId: const Uuid().v1(),
        message: value,
        userId: SocketProvider.current_user_id,
        chatRoomId: _chatRoom.sId,
        type: MESSAGE_TYPE.IMAGE,
        isDeleted: false,
        isSent: false,
      );

      appSocket.socket.emit(
        'send_message',
        message.toJson(),
      );

      message.createdAt = DateTime.now().toIso8601String();

      _messages = [..._messages.reversed.toList(), message];
      _messages = _messages.reversed.toList();
      customMessages();
      _isLoadingImage = false;
      notifyListeners();

      if (_messagesCustom.isNotEmpty) {
        jumbToLastedMessage(1);
      }
    });
  }

  void updateMessageId(String messageId, String value) {
    try {
      print('$messageId $value');
      for (var message in _messages) {
        if (message.sId == messageId) {
          message.sId = value;
          message.isSent = true;

          make_message_distinct();

          customMessages();
          notifyListeners();
          break;
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void deleteMessage(Message messageDelete) {
    try {
      print(messageDelete.toJson());
      for (var message in _messages) {
        if (message.sId == messageDelete.sId) {
          message.isDeleted = true;
          customMessages();
          notifyListeners();
          break;
        }
      }
      appSocket.socket.emit('send_delete_message', messageDelete.toJson());
    } catch (e) {
      print(e);
    }
  }
}
