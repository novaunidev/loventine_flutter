class IdBookmark {
  final String id;
  final String postId;
  IdBookmark({
    required this.id,
    required this.postId
  });

  static IdBookmark toIdBookmark(Map<String, dynamic> data) {
    return IdBookmark(
      id: data["_id"] ?? "",
      postId: data["postId"]["_id"] ?? "",
    );
  }
}
