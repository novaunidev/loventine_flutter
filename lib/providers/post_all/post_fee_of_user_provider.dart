import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:loventine_flutter/services/apply/post_service.dart';

class PostFeeOfUserProvider extends ChangeNotifier {
  final _dio = Dio();
  List<PostAll> _postFeeUser = [];
  List<PostAll> get postFeeUser => _postFeeUser;
  Future<void> getAllFeePostsOfUser(String userId) async {
    try {
      var result = await _dio.get("$baseUrl/post/getAllFeePostOfUser/$userId");

      List<dynamic> data = result.data as List<dynamic>;
      _postFeeUser = [];
      for (int i = 0; i < data.length; i++) {
        _postFeeUser.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }

      // Sắp xếp ngược lại danh sách
      _postFeeUser = _postFeeUser.reversed.toList();

      // Lấy danh sách bài đăng có chứa "postType" = "fee"

      notifyListeners();
    } catch (e) {
      _postFeeUser = [];
      print(e);
      notifyListeners();
    }
  }

  deleteFeePostofUser(int i) {
    _postFeeUser.removeAt(i);
    notifyListeners();
  }

  updateBookmarkInFeePostofUser(String id, bool isBookmark) {
    int index = _postFeeUser.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _postFeeUser[index].id,
          userId: _postFeeUser[index].userId,
          postingTime: _postFeeUser[index].postingTime,
          title: _postFeeUser[index].title,
          name: _postFeeUser[index].name,
          verified: _postFeeUser[index].verified,
          content: _postFeeUser[index].content,
          price: _postFeeUser[index].price,
          adviseType: _postFeeUser[index].adviseType,
          emoji: _postFeeUser[index].emoji,
          images: _postFeeUser[index].images,
          postType: _postFeeUser[index].postType,
          avatar: _postFeeUser[index].avatar,
          view: _postFeeUser[index].view,
          applyCount: _postFeeUser[index].applyCount,
          likeCounts: _postFeeUser[index].likeCounts,
          isLike: _postFeeUser[index].isLike,
          adviseTypeValue: _postFeeUser[index].adviseTypeValue,
          isDelete: _postFeeUser[index].isDelete,
          deleteTime: _postFeeUser[index].deleteTime,
          userAddress: _postFeeUser[index].userAddress,
          userAge: _postFeeUser[index].userAge,
          isPublic: _postFeeUser[index].isPublic,
          isBookmark: isBookmark,
          online: _postFeeUser[index].online,
          countPaymentVerified: _postFeeUser[index].countPaymentVerified);

      _postFeeUser[index] = updatedPost;
    }
    notifyListeners();
  }

  bool _isLoadingVerify = false;
  bool get isLoadingVerify => _isLoadingVerify;

  void setIsLoadingVerify(bool value) {
    _isLoadingVerify = value;
  }

  Future<String> verifyPayment(String postId) async {
    var result = await PostService.verifyPayment(postId);

    if (result == successMessageDefault) {
      _postFeeUser.forEach((element) {
        if (element.id == postId) {
          element.countPaymentVerified = 1;
        }
      });
      notifyListeners();
      return clientSuccessDefault;
    }
    if (result == errorMessageDefault) return clientErrorDefault;
    return result;
  }

  Future<String> cancelVerifyPayment(String postId) async {
    var result = await PostService.cancelVerifyPayment(postId);

    if (result == successMessageDefault) {
      _postFeeUser.forEach((element) {
        if (element.id == postId) {
          element.countPaymentVerified = 0;
        }
      });
      notifyListeners();
      return clientSuccessDefault;
    }
    if (result == errorMessageDefault) return clientErrorDefault;
    return result;
  }

  Future<String> autoVerifyPayment() async {
    var result = await PostService.autoVerifyPayment();

    if (result == successMessageDefault) {
      await getAllFeePostsOfUser(SocketProvider.current_user_id);
      return clientSuccessDefault;
    }
    if (result == errorMessageDefault) return clientErrorDefault;
    return result;
  }
}
