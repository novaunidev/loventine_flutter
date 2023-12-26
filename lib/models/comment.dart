class Comment {
  final String id;
  final String content;
  final String postId;
  final String userCommentId;
  final String nameUserCommentId;
  final String avatarUserCommentId;
  final String time;
  final String replyType;
  final String parentCommentId;
  final String userPostId;
  final List<String> childrenComments;

  Comment(
      {required this.id,
      required this.content,
      required this.postId,
      required this.userCommentId,
      required this.nameUserCommentId,
      required this.avatarUserCommentId,
      required this.time,
      required this.replyType,
      required this.parentCommentId,
      required this.userPostId,
      required this.childrenComments});

    static Comment toComment(Map<String, dynamic> data) {
    return Comment(
      id: data["_id"] ?? "",
      content: data["content"] ?? "",
      postId: data["postId"] ?? "",
      userCommentId: data["userCommentId"]["_id"] ?? "",
      nameUserCommentId: data["userCommentId"]["name"] ?? "",
      avatarUserCommentId: data["userCommentId"]["avatarUrl"] ?? "",
      time: data["time"] ?? "",
      replyType: data["replyType"] ?? "",
      parentCommentId: data["parentCommentId"] ?? "",
      userPostId: data["userPostId"] ?? "",
      childrenComments: (data["childrenComments"] as List).map((e) => e["_id"].toString()).toList(),
    );
  }
}
