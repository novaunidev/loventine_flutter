import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/models/post_all.dart';

class PostFreeOfUserProvider extends ChangeNotifier {
  final _dio = Dio();
  List<PostAll> _postFreeUser = [];
  List<PostAll> get postFreeUser => _postFreeUser;
  Future<void> getAllFreePostsOfUser(String userId) async {
    try {
      var result = await _dio.get("$baseUrl/post/getAllFreePostOfUser/$userId");

      List<dynamic> data = result.data as List<dynamic>;

      _postFreeUser = [];
      for (int i = 0; i < data.length; i++) {
        _postFreeUser.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }
      // Sắp xếp ngược lại danh sách
      _postFreeUser = _postFreeUser.reversed.toList();

      // Lấy danh sách bài đăng có chứa "postType" = "fee"

      notifyListeners();
    } catch (e) {
      _postFreeUser = [];
      print(e);
      notifyListeners();
    }
  }

  deleteFreePostofUser(int i) {
    _postFreeUser.removeAt(i);
    notifyListeners();
  }

  updateLikeInFreePostofUser(String id, bool like) {
    int index = _postFreeUser.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFreeUser[index].id,
          userId: _postFreeUser[index].userId,
          postingTime: _postFreeUser[index].postingTime,
          title: _postFreeUser[index].title,
          name: _postFreeUser[index].name,
          verified: _postFreeUser[index].verified,
          content: _postFreeUser[index].content,
          price: _postFreeUser[index].price,
          adviseType: _postFreeUser[index].adviseType,
          emoji: _postFreeUser[index].emoji,
          images: _postFreeUser[index].images,
          postType: _postFreeUser[index].postType,
          avatar: _postFreeUser[index].avatar,
          view: _postFreeUser[index].view,
          applyCount: _postFreeUser[index].applyCount,
          likeCounts: like
              ? _postFreeUser[index].likeCounts + 1
              : _postFreeUser[index].likeCounts - 1,
          isLike: like,
          adviseTypeValue: _postFreeUser[index].adviseTypeValue,
          isDelete: _postFreeUser[index].isDelete,
          deleteTime: _postFreeUser[index].deleteTime,
          userAddress: _postFreeUser[index].userAddress,
          userAge: _postFreeUser[index].userAge,
          isPublic: _postFreeUser[index].isPublic,
          isBookmark: _postFreeUser[index].isBookmark,
          online: _postFreeUser[index].online,
          countPaymentVerified: _postFreeUser[index].countPaymentVerified);

      _postFreeUser[index] = updatedPost;
    }

    notifyListeners();
  }

  updateObjectInFreePostofUser(String id, bool isPublic) {
    int index = _postFreeUser.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFreeUser[index].id,
          userId: _postFreeUser[index].userId,
          postingTime: _postFreeUser[index].postingTime,
          title: _postFreeUser[index].title,
          name: _postFreeUser[index].name,
          verified: _postFreeUser[index].verified,
          content: _postFreeUser[index].content,
          price: _postFreeUser[index].price,
          adviseType: _postFreeUser[index].adviseType,
          emoji: _postFreeUser[index].emoji,
          images: _postFreeUser[index].images,
          postType: _postFreeUser[index].postType,
          avatar: _postFreeUser[index].avatar,
          view: _postFreeUser[index].view,
          applyCount: _postFreeUser[index].applyCount,
          likeCounts: _postFreeUser[index].likeCounts,
          isLike: _postFreeUser[index].isLike,
          adviseTypeValue: _postFreeUser[index].adviseTypeValue,
          isDelete: _postFreeUser[index].isDelete,
          deleteTime: _postFreeUser[index].deleteTime,
          userAddress: _postFreeUser[index].userAddress,
          userAge: _postFreeUser[index].userAge,
          isPublic: isPublic,
          isBookmark: _postFreeUser[index].isBookmark,
          online: _postFreeUser[index].online,
          countPaymentVerified: _postFreeUser[index].countPaymentVerified);

      _postFreeUser[index] = updatedPost;
    }

    notifyListeners();
  }

  updateBookmarkInFreePostofUser(String id, bool isBookmark) {
    int index = _postFreeUser.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFreeUser[index].id,
          userId: _postFreeUser[index].userId,
          postingTime: _postFreeUser[index].postingTime,
          title: _postFreeUser[index].title,
          name: _postFreeUser[index].name,
          verified: _postFreeUser[index].verified,
          content: _postFreeUser[index].content,
          price: _postFreeUser[index].price,
          adviseType: _postFreeUser[index].adviseType,
          emoji: _postFreeUser[index].emoji,
          images: _postFreeUser[index].images,
          postType: _postFreeUser[index].postType,
          avatar: _postFreeUser[index].avatar,
          view: _postFreeUser[index].view,
          applyCount: _postFreeUser[index].applyCount,
          likeCounts: _postFreeUser[index].likeCounts,
          isLike: _postFreeUser[index].isLike,
          adviseTypeValue: _postFreeUser[index].adviseTypeValue,
          isDelete: _postFreeUser[index].isDelete,
          deleteTime: _postFreeUser[index].deleteTime,
          userAddress: _postFreeUser[index].userAddress,
          userAge: _postFreeUser[index].userAge,
          isPublic: _postFreeUser[index].isPublic,
          isBookmark: isBookmark,
          online: _postFreeUser[index].online,
          countPaymentVerified: _postFreeUser[index].countPaymentVerified);

      _postFreeUser[index] = updatedPost;
    }

    notifyListeners();
  }
}
