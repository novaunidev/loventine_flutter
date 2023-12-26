import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/models/post_all.dart';

import '../../config.dart';

class PostDeleteProvider with ChangeNotifier {
  List<PostAll> _postsDelete = [];
  List<PostAll> get postsDelete => _postsDelete;
  final _dio = Dio();
  Future<void> getAllPostsDelete(String userId) async {
    try {
      var result = await _dio.get("$baseUrl/post/getAllPostsDelete/$userId");

      List<dynamic> data = result.data as List<dynamic>;
      _postsDelete = [];
      for (int i = 0; i < data.length; i++) {
        _postsDelete.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }
      _postsDelete = _postsDelete.reversed.toList();
      // Sắp xếp ngược lại danh sách
      // _postAllUser = _postAllUser.reversed.toList();

      // Lấy danh sách bài đăng có chứa "postType" = "fee"
      // _postFeeUser =
      //     _postAllUser.where((post) => post.postType == "fee").toList();
      // _postFreeUser =
      //     _postAllUser.where((post) => post.postType == "free").toList();
      notifyListeners();
    } catch (e) {
      _postsDelete = [];
      notifyListeners();
    }
  }

  Future<void> moveToTrash(String postId) async {
    try {
      await _dio.patch("$baseUrl/post/updatePost/$postId",
          data: {'isDelete': true, 'deleteTime': DateTime.now().toString()});
    } catch (e) {
      print('Failed moveToTrash: $e');
    }
  }

  Future<void> restorePost(String postId, String userId) async {
    try {
      await _dio.patch("$baseUrl/post/updatePost/$postId", data: {
        'isDelete': "false",
      });
    } catch (e) {
      print('Failed restore: $e');
    }
    await getAllPostsDelete(userId);
  }
}
