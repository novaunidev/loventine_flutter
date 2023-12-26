class Review {
  late String sId;
  late String consultingJobId;
  late String avatarUser;
  late String nameUser;
  late int star;
  late String title;
  late String time;
  late String content;
  late String createdAt;
  late String updatedAt;
  late int iV;

  Review(
      {required this.sId,
      required this.consultingJobId,
      required this.avatarUser,
      required this.nameUser,
      required this.star,
      required this.title,
      required this.time,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      required this.iV});

  Review.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    consultingJobId = json['consultingJobId'];
    avatarUser = json['avatarUser'];
    nameUser = json['nameUser'];
    star = json['star'];
    title = json['title'];
    time = json['time'];
    content = json['content'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['consultingJobId'] = this.consultingJobId;
    data['avatarUser'] = this.avatarUser;
    data['nameUser'] = this.nameUser;
    data['star'] = this.star;
    data['title'] = this.title;
    data['time'] = this.time;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
