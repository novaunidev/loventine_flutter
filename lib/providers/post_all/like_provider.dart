import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/config.dart';

class LikeProvider extends ChangeNotifier {
  final _dio = Dio();
  List<Like> _like = [];
  List<Like> get like => _like;
  Future<void> addLike(String postId, String userId) async {
    try {
      _dio.post(urlLikes, data: {"postId": postId, "userLikeId": userId});
    } catch (e) {
      print(e);
    }
    await getAllLike();
    notifyListeners();
  }

  Future<void> getAllLike() async {
    try {
      final response = await _dio.get(urlLikes);
      final result = response.data;
      _like = [];
      for (int i = 0; i < result.length; i++) {
        _like.add(Like.toLike(result[i] as Map<String, dynamic>));
      }
      print(_like);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> deleteLike(String postId, String userId) async {
    try {
      int index = _like.indexWhere(
          (like) => like.postId == postId && like.userLikeId == userId);
      if (index != -1) {
         _dio.delete('$urlLikes/${_like[index].id}');
      }
      await getAllLike();
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}

class Like {
  final String id;
  final String postId;
  final String userLikeId;

  Like({required this.id, required this.postId, required this.userLikeId});

  static Like toLike(Map<String, dynamic> data) {
    return Like(
        id: data["_id"] ?? "",
        postId: data["postId"] ?? "",
        userLikeId: data["userLikeId"] ?? "");
  }
}
