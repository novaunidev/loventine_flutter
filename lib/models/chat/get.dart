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
    partner = User.fromJson(json['partner'] ?? {});
    me = User.fromJson(json['me'] ?? {});
    sId = json['_id'] ?? '';
    type = json['type'] ?? '';
    isExprired = json['isExprired'] ?? false;
    createdAt = json['createdAt'] ?? '';
    updatedAt = json['updatedAt'] ?? '';
    iV = json['__v'] ?? 0;
    isConsultant = json['isConsultant'] ?? false;
    lastMessage = json['lastMessage'] != null
        ? Message.fromJson(json['lastMessage'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['partner'] = this.partner.toJson();
    data['me'] = this.me.toJson();
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['isExprired'] = this.isExprired;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    if (this.lastMessage != null) {
      data['lastMessage'] = this.lastMessage?.toJson();
    }
    data['isConsultant'] = this.isConsultant;
    return data;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['online'] = this.online;
    data['avatarUrl'] = this.avatarUrl;
    data['num_unwatched'] = this.numUnwatched;
    data['isAllowNotifiCation'] = this.isAllowNotifiCation;
    return data;
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
