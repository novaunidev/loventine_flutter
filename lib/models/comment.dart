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

  static Comment toComment(
      Map<String, dynamic> data, Map<String, dynamic> data1) {
    return Comment(
      id: data["_id"] ?? "",
      content: data["content"] ?? "",
      postId: data["postId"] ?? "",
      userCommentId: data["userCommentId"] ?? "",
      nameUserCommentId: data1["name"] ?? "",
      avatarUserCommentId: data1["avatarUrl"] ?? "",
      time: data["time"] ?? "",
      replyType: data["replyType"] ?? "",
      parentCommentId: data["parentCommentId"] ?? "",
      userPostId: data["userPostId"] ?? "",
      childrenComments: List<String>.from(data['childrenComments']),
    );
  }
}
