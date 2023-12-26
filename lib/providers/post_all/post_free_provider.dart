import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/models/post_all.dart';

class PostFreeProvider with ChangeNotifier {
  final _dio = Dio();

  List<PostAll> _postFree = [];
  List<PostAll> _postFreePage1 = [];
  int get postFreeCount => _postFree.length;
  List<PostAll> get postFree => _postFree;
  List<PostAll> get postFreePage1 => _postFreePage1;
  bool _statusCode = false;
  bool get statusCode => _statusCode;
  bool isGet = true;

  Future<void> getAllFreePost(int page, bool reload, String userId) async {
    print("Đang get all free post");
    try {
      var result = await _dio.get("$baseUrl/post/getAllFreePost/$userId",
          queryParameters: {'page': page, 'limit': 5});

      List<dynamic> data = result.data as List<dynamic>;
      if (reload == true) {
        _postFree = [];
      }
      if (data.isEmpty) {
        isGet = false;
      } else {
        isGet = true;
      }

      for (int i = 0; i < data.length; i++) {
        _postFree.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }
    } catch (e) {
      _postFree = [];
    }
    notifyListeners();
  }

  Future<void> getAllFreePostPage1(String userId) async {
    print("Đang get all free post");
    try {
      var result = await _dio.get("$baseUrl/post/getAllFreePost/$userId",
          queryParameters: {'page': 1, 'limit': 5});

      List<dynamic> data = result.data as List<dynamic>;

      _postFreePage1 = [];

      for (int i = 0; i < data.length; i++) {
        _postFreePage1.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }
    } catch (e) {
      _postFree = [];
    }
    notifyListeners();
  }

  deleteFreePost(String postId) {
    int index = _postFree.indexWhere((post) => post.id == postId);
    if (index != -1) {
      _postFree.removeAt(index);
    }

    notifyListeners();
  }

  updateLikeInFreePost(String id, bool like) {
    int index = _postFree.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFree[index].id,
          userId: _postFree[index].userId,
          postingTime: _postFree[index].postingTime,
          title: _postFree[index].title,
          name: _postFree[index].name,
          verified: _postFree[index].verified,
          content: _postFree[index].content,
          price: _postFree[index].price,
          adviseType: _postFree[index].adviseType,
          emoji: _postFree[index].emoji,
          images: _postFree[index].images,
          postType: _postFree[index].postType,
          avatar: _postFree[index].avatar,
          view: _postFree[index].view,
          applyCount: _postFree[index].applyCount,
          likeCounts: like
              ? _postFree[index].likeCounts + 1
              : _postFree[index].likeCounts - 1,
          isLike: like,
          adviseTypeValue: _postFree[index].adviseTypeValue,
          isDelete: _postFree[index].isDelete,
          deleteTime: _postFree[index].deleteTime,
          userAddress: _postFree[index].userAddress,
          userAge: _postFree[index].userAge,
          isPublic: _postFree[index].isPublic,
          isBookmark: _postFree[index].isBookmark,
          online: _postFree[index].online,
          countPaymentVerified: _postFree[index].countPaymentVerified);

      _postFree[index] = updatedPost;
    }

    notifyListeners();
  }

  updateLikeInFreePost1(String id, bool like) {
    int index = _postFreePage1.indexWhere((post) => post.id == id);

    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFreePage1[index].id,
          userId: _postFreePage1[index].userId,
          postingTime: _postFreePage1[index].postingTime,
          title: _postFreePage1[index].title,
          name: _postFreePage1[index].name,
          verified: _postFreePage1[index].verified,
          content: _postFreePage1[index].content,
          price: _postFreePage1[index].price,
          adviseType: _postFreePage1[index].adviseType,
          emoji: _postFreePage1[index].emoji,
          images: _postFreePage1[index].images,
          postType: _postFreePage1[index].postType,
          avatar: _postFreePage1[index].avatar,
          view: _postFreePage1[index].view,
          applyCount: _postFreePage1[index].applyCount,
          likeCounts: like
              ? _postFreePage1[index].likeCounts + 1
              : _postFreePage1[index].likeCounts - 1,
          isLike: like,
          adviseTypeValue: _postFreePage1[index].adviseTypeValue,
          isDelete: _postFreePage1[index].isDelete,
          deleteTime: _postFreePage1[index].deleteTime,
          userAddress: _postFreePage1[index].userAddress,
          userAge: _postFreePage1[index].userAge,
          isPublic: _postFreePage1[index].isPublic,
          isBookmark: _postFreePage1[index].isBookmark,
          online: _postFreePage1[index].online,
          countPaymentVerified: _postFreePage1[index].countPaymentVerified);
      _postFreePage1[index] = updatedPost;
    }

    notifyListeners();
  }

  updateObjectInFreePost(String id, bool isPublic) {
    int index = _postFree.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFree[index].id,
          userId: _postFree[index].userId,
          postingTime: _postFree[index].postingTime,
          title: _postFree[index].title,
          name: _postFree[index].name,
          verified: _postFree[index].verified,
          content: _postFree[index].content,
          price: _postFree[index].price,
          adviseType: _postFree[index].adviseType,
          emoji: _postFree[index].emoji,
          images: _postFree[index].images,
          postType: _postFree[index].postType,
          avatar: _postFree[index].avatar,
          view: _postFree[index].view,
          applyCount: _postFree[index].applyCount,
          likeCounts: _postFree[index].likeCounts,
          isLike: _postFree[index].isLike,
          adviseTypeValue: _postFree[index].adviseTypeValue,
          isDelete: _postFree[index].isDelete,
          deleteTime: _postFree[index].deleteTime,
          userAddress: _postFree[index].userAddress,
          userAge: _postFree[index].userAge,
          isPublic: isPublic,
          isBookmark: _postFree[index].isBookmark,
          online: _postFree[index].online,
          countPaymentVerified: _postFree[index].countPaymentVerified);

      _postFree[index] = updatedPost;
    }
    notifyListeners();
  }

  updateObjectInFreePost1(String id, bool isPublic) {
    int index = _postFreePage1.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFreePage1[index].id,
          userId: _postFreePage1[index].userId,
          postingTime: _postFreePage1[index].postingTime,
          title: _postFreePage1[index].title,
          name: _postFreePage1[index].name,
          verified: _postFreePage1[index].verified,
          content: _postFreePage1[index].content,
          price: _postFreePage1[index].price,
          adviseType: _postFreePage1[index].adviseType,
          emoji: _postFreePage1[index].emoji,
          images: _postFreePage1[index].images,
          postType: _postFreePage1[index].postType,
          avatar: _postFreePage1[index].avatar,
          view: _postFreePage1[index].view,
          applyCount: _postFreePage1[index].applyCount,
          likeCounts: _postFreePage1[index].likeCounts,
          isLike: _postFreePage1[index].isLike,
          adviseTypeValue: _postFreePage1[index].adviseTypeValue,
          isDelete: _postFreePage1[index].isDelete,
          deleteTime: _postFreePage1[index].deleteTime,
          userAddress: _postFreePage1[index].userAddress,
          userAge: _postFreePage1[index].userAge,
          isPublic: isPublic,
          isBookmark: _postFreePage1[index].isBookmark,
          online: _postFreePage1[index].online,
          countPaymentVerified: _postFreePage1[index].countPaymentVerified);

      _postFreePage1[index] = updatedPost;
    }
    notifyListeners();
  }

  updateBookmarkInFreePost(String id, bool isBookmark) {
    int index = _postFree.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFree[index].id,
          userId: _postFree[index].userId,
          postingTime: _postFree[index].postingTime,
          title: _postFree[index].title,
          name: _postFree[index].name,
          verified: _postFree[index].verified,
          content: _postFree[index].content,
          price: _postFree[index].price,
          adviseType: _postFree[index].adviseType,
          emoji: _postFree[index].emoji,
          images: _postFree[index].images,
          postType: _postFree[index].postType,
          avatar: _postFree[index].avatar,
          view: _postFree[index].view,
          applyCount: _postFree[index].applyCount,
          likeCounts: _postFree[index].likeCounts,
          isLike: _postFree[index].isLike,
          adviseTypeValue: _postFree[index].adviseTypeValue,
          isDelete: _postFree[index].isDelete,
          deleteTime: _postFree[index].deleteTime,
          userAddress: _postFree[index].userAddress,
          userAge: _postFree[index].userAge,
          isPublic: _postFree[index].isPublic,
          isBookmark: isBookmark,
          online: _postFree[index].online,
          countPaymentVerified: _postFree[index].countPaymentVerified);

      _postFree[index] = updatedPost;
    }
    notifyListeners();
  }

  updateBookmarkInFreePost1(String id, bool isBookmark) {
    int index = _postFreePage1.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFreePage1[index].id,
          userId: _postFreePage1[index].userId,
          postingTime: _postFreePage1[index].postingTime,
          title: _postFreePage1[index].title,
          name: _postFreePage1[index].name,
          verified: _postFreePage1[index].verified,
          content: _postFreePage1[index].content,
          price: _postFreePage1[index].price,
          adviseType: _postFreePage1[index].adviseType,
          emoji: _postFreePage1[index].emoji,
          images: _postFreePage1[index].images,
          postType: _postFreePage1[index].postType,
          avatar: _postFreePage1[index].avatar,
          view: _postFreePage1[index].view,
          applyCount: _postFreePage1[index].applyCount,
          likeCounts: _postFreePage1[index].likeCounts,
          isLike: _postFreePage1[index].isLike,
          adviseTypeValue: _postFreePage1[index].adviseTypeValue,
          isDelete: _postFreePage1[index].isDelete,
          deleteTime: _postFreePage1[index].deleteTime,
          userAddress: _postFreePage1[index].userAddress,
          userAge: _postFreePage1[index].userAge,
          isPublic: _postFreePage1[index].isPublic,
          isBookmark: isBookmark,
          online: _postFreePage1[index].online,
          countPaymentVerified: _postFreePage1[index].countPaymentVerified);

      _postFreePage1[index] = updatedPost;
    }
    notifyListeners();
  }
}
