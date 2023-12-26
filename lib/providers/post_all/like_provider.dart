import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/config.dart';

class LikeProvider extends ChangeNotifier {
  final _dio = Dio();
  Future<void> addLike(String postId, String userId) async {
    try {
      _dio.post("$baseUrl/like/addLike/$postId/$userId");
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  Future<void> deleteLike(String postId, String userId) async {
    try {
      _dio.delete("$baseUrl/like/deleteLike/$postId/$userId");
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
}
