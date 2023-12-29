import 'package:dio/dio.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/models/comment.dart';

class CommentProvider {
  // List<Comment> _commentAll = [];
  // List<Comment> _commentPost = [];
  // List<Comment> _commentComment = [];
  // List<Comment> get commentAll => _commentAll;

  // List<Comment> get commentPost => _commentPost;

  // List<Comment> get commentComment => _commentComment;

  final _dio = Dio();
  // Future<void> getAllCommentsOfAPost(String postId) async {
  //   print(postId);
  //   try {
  //     var result = await _dio.get("$baseUrl/comment/getAllCommentsOfAPost/$postId");
  //     List<dynamic> data = result.data as List<dynamic>;
  //     _commentAll = [];
  //     for (int i = 0; i < data.length; i++) {
  //       _commentAll.add(Comment.toComment(data[i] as Map<String, dynamic>));
  //     }

  //     // Lấy danh sách bài đăng có chứa "postType" = "fee"
  //     _commentPost = _commentAll.where((comment) => comment.replyType == "post").toList();
  //     _commentComment = _commentAll.where((comment) => comment.replyType == "comment").toList();
  //     print(_commentAll);

  //   } catch (e) {
  //     _commentAll = [];
  //     print(e);
  //   }
  //   // notifyListeners();
  // }
  Future<void> addComment(
      String postId,
      String userCommentId,
      String parentCommentId,
      String time,
      String replyType,
      String content,
      String userPostId) async {
    try {
      var result = await _dio.post(urlComments, data: {
        "time": time,
        "content": content,
        "replyType": replyType,
        "userPostId": userPostId,
        "parentCommentId": parentCommentId,
        "userCommentId": userCommentId,
        "postId": postId,
        "childrenComments": []
      });
      if (result.statusCode == 200) {
        print("addComment success");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteComment(String commentId, Comment comment) async {
    print("alollllllllllllllllll");
    try {
      await _dio.put("$urlComments/$commentId", data: {
        "_id": comment.id,
        "content": "Bình luận đã xóa",
        "postId": comment.postId,
        "userCommentId": comment.userCommentId,
        "time": comment.time,
        "userPostId": comment.userPostId,
        "parentCommentId": comment.parentCommentId,
        "childrenComments": comment.childrenComments,
        "replyType": comment.replyType
      });
    } catch (error) {
      // Xử lý lỗi tại đây
      print(error.toString());
    }
  }
}
