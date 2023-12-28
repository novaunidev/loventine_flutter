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

  Future<void> moveToTrash(String postId, PostAll post) async {
    try {
      await _dio.put("$urlPosts/$postId", data: {
        "_id": post.id,
        "author": post.userId,
        "title": post.title,
        "content": post.content,
        "postingTime": post.postingTime,
        "likeAllUserId": post.likeAllUserId,
        "likeCounts": post.likeCounts,
        "comments": post.comments,
        "images": post.images,
        "postType": post.postType,
        "price": null,
        "adviseType": null,
        "emoji": null,
        "view": 0,
        "applyCount": 0,
        "isLike": post.isLike,
        "isDelete": true,
        'deleteTime': DateTime.now().toString(),
        "userAddress": post.userAddress,
        "isPublic": post.isPublic,
        "isBookmark": false,
        "countPaymentVerified": 0,
        "numConsultingJobStart": 0,
        "countPayment": 0,
      });
    } catch (e) {
      print('Failed moveToTrash: $e');
    }
  }

  Future<void> restorePost(String postId, String userId, PostAll post) async {
    try {
      await _dio.put("$urlPosts/$postId", data: {
        "_id": post.id,
        "author": post.userId,
        "title": post.title,
        "content": post.content,
        "postingTime": post.postingTime,
        "likeAllUserId": post.likeAllUserId,
        "likeCounts": post.likeCounts,
        "comments": post.comments,
        "images": post.images,
        "postType": post.postType,
        "price": null,
        "adviseType": null,
        "emoji": null,
        "view": 0,
        "applyCount": 0,
        "isLike": post.isLike,
        "isDelete": false,
        'deleteTime': DateTime.now().toString(),
        "userAddress": post.userAddress,
        "isPublic": post.isPublic,
        "isBookmark": false,
        "countPaymentVerified": 0,
        "numConsultingJobStart": 0,
        "countPayment": 0,
      });
    } catch (e) {
      print('Failed restore: $e');
    }
  }
}
