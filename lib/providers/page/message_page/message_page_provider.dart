// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:loventine_flutter/models/banner/banner_home.dart';
import 'package:loventine_flutter/models/hives/image_url.dart';
import 'package:loventine_flutter/models/hives/userid.dart';
import 'dart:convert';
import './user.dart';
import './message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class MessagePageProvider with ChangeNotifier {
  List<User> users = [];

  MessagePageProvider() {
    initialize();
  }
  Future<void> initialize() async {
    final box = Hive.box<UserId>('userBox');
    final loginBox = await Hive.openBox("loginBox");
    UserId? userId = box.get('userid');
    if (userId != null) {
      current_user_id = userId.userid!;
      loginBox.put("isLogin", true);
      print("isLogin bằng true");
    } else {
      loginBox.put("isLogin", false);
      print("isLogin bằng false");
    }
    isLogin = loginBox.get("isLogin");
    notifyListeners();
  }

  Future<void> setCurrentUserId(String userid) async {
    current_user_id = userid;
    final box = Hive.box<UserId>('userBox');
    box.put('userid', UserId(userid: userid));
    notifyListeners();
  }

  //====== Set and Get Avatar Url
  Future<void> getAvatarUrl() async {
    final box = Hive.box<UserId>('userBox');
    UserId? avatarUrl = box.get('avatarUrl');
    if (avatarUrl != null) {
      avatar_url = avatarUrl.avatarUrl!;
      avatar_cloundinary_public_id = avatarUrl.avatarCloundinaryPublicId!;
    }
    notifyListeners();
  }

  Future<void> setAvatarUrl(
      String avatarUrl, String avatarCloundinaryPublicId) async {
    final box = Hive.box<UserId>('userBox');
    box.put(
        'avatarUrl',
        UserId(
            avatarUrl: avatarUrl,
            avatarCloundinaryPublicId: avatarCloundinaryPublicId));
    await getAvatarUrl();
    notifyListeners();
  }

  //===End

  //===Get Banner
  Future<void> getBannerUrl() async {
    final box = Hive.box<ImageUrl>('imageUrl');
    ImageUrl? imageUrl = box.get('bannerHome');
    if (imageUrl != null) {
      bannerMorning = imageUrl.bannerMorning!;
      bannerAfternoon = imageUrl.bannerAfternoon!;
      bannerEvening = imageUrl.bannerEvening!;
    }

    notifyListeners();
  }

  Future<void> setBannerUrl(BannerHome bannerHome) async {
    final box = Hive.box<ImageUrl>('imageUrl');
    box.put(
        'bannerHome',
        ImageUrl(
            bannerMorning: bannerHome.morning,
            bannerAfternoon: bannerHome.afternoon,
            bannerEvening: bannerHome.evening));
    await getBannerUrl();
    notifyListeners();
  }

  //==End

  //late User currentUser;
  late List<User> friendList = [];
  late List<Message> messages = [];
  late IO.Socket socket;
  late String current_user_id = ''; //''63283a8550714dd6a28d1478';
  late String avatar_url = '';
  late String bannerMorning = '';
  late String bannerAfternoon = '';
  late String bannerEvening = '';
  late String avatar_cloundinary_public_id = "";
  late int num_fetch_message = 1;
  late bool isLogin = false;

  // Message Page
  Future<void> fetchAndSetUsers() async {
    final url = Uri.parse(urlGetAlUser);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      //print(extractedData["message"]);

      users = extractedData["message"].map<User>((prodData) {
        //print(prodData["name"]);
        return User(
          prodData["phone"],
          prodData["_id"],
        );
      }).toList();

      friendList =
          users.where((user) => user.chatID != current_user_id).toList();

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  // Chat Page
  Future<void> fetchAndSetMessages(String userId_To) async {
    // ignore: unused_local_variable
    final url = Uri.parse(urlGetAllMessage);
    try {
      print("Imfomation of fetch message");
      print("uid : $userId_To");
      print("mFrorm : $current_user_id");
      print("numLoad : $num_fetch_message");
      Response response = await post(
        Uri.parse(urlGetAllMessage),
        body: {
          //'userid': current_user_id,
          'uid': userId_To,
          'mFrom': current_user_id,
          'numLoad': '$num_fetch_message',
        },
      );

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      print(extractedData["message"]);

      List<Message> new_messages =
          extractedData["message"].map<Message>((prodData) {
        return Message(
          prodData["message"],
          prodData["from"],
          prodData["to"],
        );
      }).toList();

      new_messages.forEach((message) {
        messages.insert(0, message);
      });

      print("Message data");
      print(messages);

      //print(users[0].name);
      //print(users[0].chatID);

      num_fetch_message++;

      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  void init_Chat_Page() {
    messages = [];
    num_fetch_message = 1;
    notifyListeners();
  }

  void init() {
    //currentUser = users[1];

    //friendList = users.where((user) => user.chatID != current_user_id).toList();

    socket = IO.io(
      urlSocket_deploy,
      IO.OptionBuilder().setTransports(['websocket']).setQuery(
          {'chatID': '${current_user_id}'}).build(),
    );

    print('init message page provider');

    socket.onConnect((_) {
      print('connect');
    });

    socket.on('receive_message', (jsonData) {
      print('get message from another');
      print(jsonData);
      // Map<String, dynamic> data = json.decode(jsonData) as Map<String, dynamic>;
      print(json.encode(jsonData));
      final new_t = json.encode(jsonData);
      final data = json.decode(new_t) as Map<String, dynamic>;
      messages.add(Message(
        data['content'],
        data['senderChatID'],
        data['receiverChatID'],
      ));
      notifyListeners();
    });
  }

  void sendMessage(String text, String receiverChatID) {
    messages.add(Message(text, current_user_id, receiverChatID));

    print(
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': current_user_id,
        'content': text,
      }),
    );
    socket.emit(
      'send_message',
      json.encode({
        'receiverChatID': receiverChatID,
        'senderChatID': current_user_id,
        'content': text,
      }),
    );
    notifyListeners();
  }

  List<Message> getMessagesForChatID(String chatID) {
    return messages
        .where((msg) => msg.senderID == chatID || msg.receiverID == chatID)
        .toList();
  }

  List getMessagesForChatID_json(String chatID) {
    List message = [];

    messages.forEach((msg) {
      if (msg.senderID == chatID || msg.receiverID == chatID) {
        message.add({
          "text": msg.text,
          "isMe": (current_user_id == msg.senderID),
          "createdAt": '2:30 PM',
        });
      }
    });

    return message;
  }
}
