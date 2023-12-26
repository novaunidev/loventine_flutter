class Notification {
  late String sId;
  late String receiver;
  Author? author;
  late String text;
  late String type;
  late bool isWatched;
  late String createdAt;
  late String updatedAt;
  late int iV;

  Notification(
      {required this.sId,
      required this.receiver,
      this.author,
      required this.text,
      required this.type,
      required this.isWatched,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});

  Notification.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    receiver = json['receiver'];
    author =
        json['author'] != null ? new Author.fromJson(json['author']) : null;
    text = json['text'];
    type = json['type'];
    isWatched = json['isWatched'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['receiver'] = this.receiver;
    if (this.author != null) {
      data['author'] = this.author?.toJson();
    }
    data['text'] = this.text;
    data['type'] = this.type;
    data['isWatched'] = this.isWatched;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

class Author {
  late String sId;
  late String name;
  late String avatarUrl;

  Author({required this.sId, required this.name, required this.avatarUrl});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    avatarUrl = json['avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['avatarUrl'] = this.avatarUrl;
    return data;
  }
}
