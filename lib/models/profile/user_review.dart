class UserReview {
  final String id;
  final int star;
  final String title;
  final String time;
  final String content;
  final String avatarUser;
  final String nameUser;

  const UserReview(
      {required this.id,
      required this.star,
      required this.title,
      required this.time,
      required this.content,
      required this.avatarUser,
      required this.nameUser});

  static toUserReview(Map<String, dynamic> data) {
    return UserReview(
      id: data["_id"] ?? "",
      star: data["star"] ?? "",
      title: data["title"] ?? "",
      time: data["time"] ?? "",
      content: data["content"] ?? "",
      avatarUser: data["avatarUser"] ?? "",
      nameUser: data["nameUser"] ?? "",
    );
  }
}
