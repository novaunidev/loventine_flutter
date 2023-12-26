import '../../config.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loventine_flutter/models/post_all.dart';

class PostFeeProvider with ChangeNotifier {
  final _dio = Dio();

  List<PostAll> _postFee = [];
  List<PostAll> get postFee => _postFee;
  bool isGet = true;

  Future<void> getAllFeePost(
    int page,
    bool reload,
    String titles,
    String userId,
    int limit,
  ) async {
    print("Đang get all fee post");
    try {
      var result = await _dio
          .get("$baseUrl/post/getAllFeePost/$userId", queryParameters: {
        'page': page,
        'limit': limit,
        'titles': titles,
      });

      List<dynamic> data = result.data as List<dynamic>;
      if (reload == true) {
        _postFee = [];
      }
      if (data.isEmpty) {
        isGet = false;
      } else {
        isGet = true;
      }

      for (int i = 0; i < data.length; i++) {
        _postFee.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }

  deleteFeePost(String postId) {
    int index = _postFee.indexWhere((post) => post.id == postId);
    if (index != -1) {
      _postFee.removeAt(index);
    }

    notifyListeners();
  }

  Future<void> updateView(String postId, int currentView) async {
    int updatedView = currentView + 1;
    try {
      await _dio.patch("$baseUrl/post/updatePost/$postId", data: {
        'view': updatedView,
      });
    } catch (e) {
      print('Failed to update view: $e');
    }
  }

  updateBookmarkInFeePost(String id, bool isBookmark) {
    int index = _postFee.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFee[index].id,
          userId: _postFee[index].userId,
          postingTime: _postFee[index].postingTime,
          title: _postFee[index].title,
          name: _postFee[index].name,
          verified: _postFee[index].verified,
          content: _postFee[index].content,
          price: _postFee[index].price,
          adviseType: _postFee[index].adviseType,
          emoji: _postFee[index].emoji,
          images: _postFee[index].images,
          postType: _postFee[index].postType,
          avatar: _postFee[index].avatar,
          view: _postFee[index].view,
          applyCount: _postFee[index].applyCount,
          likeCounts: _postFee[index].likeCounts,
          isLike: _postFee[index].isLike,
          adviseTypeValue: _postFee[index].adviseTypeValue,
          isDelete: _postFee[index].isDelete,
          deleteTime: _postFee[index].deleteTime,
          userAddress: _postFee[index].userAddress,
          userAge: _postFee[index].userAge,
          isPublic: _postFee[index].isPublic,
          isBookmark: isBookmark,
          online: _postFee[index].online,
          countPaymentVerified: _postFee[index].countPaymentVerified);

      _postFee[index] = updatedPost;
    }
    notifyListeners();
  }
}
