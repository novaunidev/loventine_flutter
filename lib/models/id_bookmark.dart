class IdBookmark {
  final String id;
  final String postId;
  final String userId;
  IdBookmark({
    required this.id,
    required this.postId,
    required this.userId
  });

  static IdBookmark toIdBookmark(Map<String, dynamic> data) {
    return IdBookmark(
      id: data["_id"] ?? "",
      postId: data["postId"] ?? "",
      userId: data["userId"] ?? ""
    );
  }
}
