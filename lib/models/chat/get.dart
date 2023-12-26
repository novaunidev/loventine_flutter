// ignore_for_file: unnecessary_null_comparison

import 'package:loventine_flutter/constant.dart';

class ChatRoom {
  late User partner;
  late User me;
  late String sId;
  late String type;
  late bool isExprired;
  late String createdAt;
  late String updatedAt;
  late int iV;
  Message? lastMessage;
  late bool isConsultant;

  ChatRoom(
      {required this.partner,
      required this.me,
      required this.sId,
      required this.type,
      required this.isExprired,
      required this.createdAt,
      required this.updatedAt,
      required this.iV,
      this.lastMessage,
      required this.isConsultant});

  ChatRoom.fromJson(Map<String, dynamic> json) {
    partner = User.fromJson(json['partner']);
    me = User.fromJson(json['me']);
    sId = json['_id'];
    type = json['type'];
    isExprired = json['isExprired'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    lastMessage = json['lastMessage'] != null
        ? new Message.fromJson(json['lastMessage'])
        : null;
    isConsultant = json['isConsultant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ChatRoom = new Map<String, dynamic>();
    if (this.partner != null) {
      ChatRoom['partner'] = this.partner.toJson();
    }
    if (this.me != null) {
      ChatRoom['me'] = this.me.toJson();
    }
    ChatRoom['_id'] = this.sId;
    ChatRoom['type'] = this.type;
    ChatRoom['isExprired'] = this.isExprired;
    ChatRoom['createdAt'] = this.createdAt;
    ChatRoom['updatedAt'] = this.updatedAt;
    ChatRoom['__v'] = this.iV;
    if (this.lastMessage != null) {
      ChatRoom['lastMessage'] = this.lastMessage?.toJson();
    }
    ChatRoom['isConsultant'] = this.isConsultant;
    return ChatRoom;
  }
}

class User {
  late String sId;
  late String name;
  late bool online;
  late String avatarUrl;
  late int numUnwatched;
  late bool isAllowNotifiCation;

  User(
      {required this.sId,
      required this.name,
      required this.online,
      required this.avatarUrl,
      required this.numUnwatched,
      required this.isAllowNotifiCation});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    online = json['online'];
    avatarUrl = json['avatarUrl'];
    numUnwatched = json['num_unwatched'];
    isAllowNotifiCation = json['isAllowNotifiCation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ChatRoom = new Map<String, dynamic>();
    ChatRoom['_id'] = this.sId;
    ChatRoom['name'] = this.name;
    ChatRoom['online'] = this.online;
    ChatRoom['avatarUrl'] =
        ChatRoom['avatarUrl'] == null ? defaultAvatar : ChatRoom['avatarUrl'];
    ChatRoom['num_unwatched'] = this.numUnwatched;
    ChatRoom['isAllowNotifiCation'] = this.isAllowNotifiCation;
    return ChatRoom;
  }
}

class Message {
  late String sId;
  late String chatRoomId;
  late String userId;
  late String message;
  late String type;
  late bool isDeleted;
  late bool isSent;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Message(
      {required this.sId,
      required this.chatRoomId,
      required this.userId,
      required this.message,
      required this.type,
      required this.isDeleted,
      required this.isSent,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    chatRoomId = json['chatRoomId'];
    userId = json['userId'];
    message = json['message'];
    type = json['type'];
    isDeleted = json['isDeleted'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    isSent = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> ChatRoom = new Map<String, dynamic>();
    ChatRoom['_id'] = this.sId;
    ChatRoom['chatRoomId'] = this.chatRoomId;
    ChatRoom['userId'] = this.userId;
    ChatRoom['message'] = this.message;
    ChatRoom['type'] = this.type;
    ChatRoom['isDeleted'] = this.isDeleted;
    if (createdAt != null) {
      ChatRoom['createdAt'] = this.createdAt;
    }
    if (createdAt != null) {
      ChatRoom['updatedAt'] = this.updatedAt;
    }
    if (iV != null) {
      ChatRoom['__v'] = this.iV;
    }

    return ChatRoom;
  }

  static Message toMessage(Map<String, dynamic> data) {
    return Message(
      sId: data['_id'] ?? "",
      chatRoomId: data['chatRoomId'] ?? "",
      userId: data['userId'] ?? "",
      message: data['message'] ?? "",
      type: data['type'] ?? "",
      isDeleted: data['isDeleted'] ?? false,
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
      iV: data['__v'],
      isSent: true,
    );
  }
}
