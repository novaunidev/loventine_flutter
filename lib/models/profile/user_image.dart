class UserImage {
  final String id;
  final String avatar;

  const UserImage({
    required this.id,
    required this.avatar,
  });

  static toUserImage(Map<String, dynamic> data) {
    return UserImage(
      id: data["_id"] ?? "",
      avatar: data["avatar"] ?? "",
    );
  }
}
