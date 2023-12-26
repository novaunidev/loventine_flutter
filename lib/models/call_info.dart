class CallInfo {
  String? id;
  String? callerId;
  String? receiverId;
  String? chatRoomId;
  String? callType;
  late bool isCaller;

  CallInfo(
      {this.id,
      required this.callerId,
      required this.receiverId,
      required this.chatRoomId,
      required this.callType,
      required this.isCaller});

  CallInfo.fromJson(Map<String, dynamic> json) {
    callerId = json['callerId'];
    receiverId = json['receiverId'];
    isCaller = json['isCaller'];
    chatRoomId = json['chatRoomId'];
    callType = json['chatRoomId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['callerId'] = callerId;
    data['receiverId'] = receiverId;
    data['isCaller'] = isCaller;
    data['chatRoomId'] = chatRoomId;
    data['chatRoomId'] = callType;

    return data;
  }
}
