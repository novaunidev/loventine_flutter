import 'package:flutter/foundation.dart';
import 'package:loventine_flutter/models/id_bookmark.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/providers/post_all/post_fee_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_fee_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_provider.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import '../../config.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class BookmarkProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  List<PostAll> _bookmarks = [];

  List<IdBookmark> _idBookmarks = [];

  List<PostAll> get bookmarks => _bookmarks;

  List<IdBookmark> get idBookmarks => _idBookmarks;

  Future<void> getAllBookmarkOfUser(String userId) async {
    var response = await _dio.get("$baseUrl/bookmark/getBookmarkOfUer/$userId");
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      _bookmarks = [];
      _idBookmarks = [];
      _bookmarks = data
          .map((bookmarkData) => PostAll.toPostAll(bookmarkData['postId']))
          .toList();
      _bookmarks = _bookmarks.reversed.toList();
      _idBookmarks = data
          .map((idBookmarkData) => IdBookmark.toIdBookmark(idBookmarkData))
          .toList();
      _idBookmarks = _idBookmarks.reversed.toList();
    }
  }

  Future<void> addBookmark(
      String postId,
      String userId,
      BuildContext context,
      PostFeeProvider postFeeProvider,
      PostFreeProvider postFreeProvider,
      PostFreeOfUserProvider postFreeUserProvider,
      PostFeeOfUserProvider postFeeUserProvider) async {
    try {
      var response = await _dio
          .post("$baseUrl/bookmark/addBookmark/$userId/$postId", data: {});

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        postFeeProvider.updateBookmarkInFeePost(postId, true);
        postFeeUserProvider.updateBookmarkInFeePostofUser(postId, true);
        postFreeProvider.updateBookmarkInFreePost(postId, true);
        postFreeProvider.updateBookmarkInFreePost1(postId, true);
        postFreeUserProvider.updateBookmarkInFreePostofUser(postId, true);
        updateBookmarkInBookmarkPost(postId, true);
        getAllBookmarkOfUser(userId);
        CustomSnackbar.show(
          context,
          title: 'Lưu thành công',
          type: SnackbarType.success,
        );
      }
    } catch (e) {
      print('Failed to add bookmark: $e');
    }
  }

  Future<bool> deleteBookmark(
      String bookmarkId,
      BuildContext context,
      String userId,
      int index,
      String postId,
      PostFeeProvider postFeeProvider,
      PostFreeProvider postFreeProvider,
      PostFreeOfUserProvider postFreeUserProvider,
      PostFeeOfUserProvider postFeeUserProvider) async {
    try {
      print("$baseUrl/bookmark/deleteBookmark/$bookmarkId");
      var response = await _dio.delete(
          "$baseUrl/bookmark/deleteBookmark/$bookmarkId/$userId",
          data: {});
      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        _bookmarks.removeAt(index);
        postFeeProvider.updateBookmarkInFeePost(postId, false);
        postFeeUserProvider.updateBookmarkInFeePostofUser(postId, false);
        postFreeProvider.updateBookmarkInFreePost(postId, false);
        postFreeProvider.updateBookmarkInFreePost1(postId, false);
        postFreeUserProvider.updateBookmarkInFreePostofUser(postId, false);
        updateBookmarkInBookmarkPost(postId, false);
        CustomSnackbar.show(
          context,
          title: 'Thông báo',
          message: 'Bạn đã xóa thành công',
          type: SnackbarType.success,
        );

        return true;
      }
    } catch (e) {}
    notifyListeners();
    return false;
  }

  String findIdByPostId(String searchPostId) {
    var bookmark = _idBookmarks.firstWhere(
      (item) => item.postId == searchPostId,
    );
    return bookmark.id;
  }

  updateLikeInBookmarkPost(String id, bool like) {
    int index = _bookmarks.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _bookmarks[index].id,
          userId: _bookmarks[index].userId,
          postingTime: _bookmarks[index].postingTime,
          title: _bookmarks[index].title,
          name: _bookmarks[index].name,
          verified: _bookmarks[index].verified,
          content: _bookmarks[index].content,
          price: _bookmarks[index].price,
          adviseType: _bookmarks[index].adviseType,
          emoji: _bookmarks[index].emoji,
          images: _bookmarks[index].images,
          postType: _bookmarks[index].postType,
          avatar: _bookmarks[index].avatar,
          view: _bookmarks[index].view,
          applyCount: _bookmarks[index].applyCount,
          likeCounts: like
              ? _bookmarks[index].likeCounts + 1
              : _bookmarks[index].likeCounts - 1,
          isLike: like,
          adviseTypeValue: _bookmarks[index].adviseTypeValue,
          isDelete: _bookmarks[index].isDelete,
          deleteTime: _bookmarks[index].deleteTime,
          userAddress: _bookmarks[index].userAddress,
          userAge: _bookmarks[index].userAge,
          isPublic: _bookmarks[index].isPublic,
          isBookmark: _bookmarks[index].isBookmark,
          online: _bookmarks[index].online,
          countPaymentVerified: _bookmarks[index].countPaymentVerified);

      _bookmarks[index] = updatedPost;
    }
    notifyListeners();
  }

  updateObjectInBookmarkPost(String id, bool isPublic) {
    int index = _bookmarks.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _bookmarks[index].id,
          userId: _bookmarks[index].userId,
          postingTime: _bookmarks[index].postingTime,
          title: _bookmarks[index].title,
          name: _bookmarks[index].name,
          verified: _bookmarks[index].verified,
          content: _bookmarks[index].content,
          price: _bookmarks[index].price,
          adviseType: _bookmarks[index].adviseType,
          emoji: _bookmarks[index].emoji,
          images: _bookmarks[index].images,
          postType: _bookmarks[index].postType,
          avatar: _bookmarks[index].avatar,
          view: _bookmarks[index].view,
          applyCount: _bookmarks[index].applyCount,
          likeCounts: _bookmarks[index].likeCounts,
          isLike: _bookmarks[index].isLike,
          adviseTypeValue: _bookmarks[index].adviseTypeValue,
          isDelete: _bookmarks[index].isDelete,
          deleteTime: _bookmarks[index].deleteTime,
          userAddress: _bookmarks[index].userAddress,
          userAge: _bookmarks[index].userAge,
          isPublic: isPublic,
          isBookmark: _bookmarks[index].isBookmark,
          online: _bookmarks[index].online,
          countPaymentVerified: _bookmarks[index].countPaymentVerified);

      _bookmarks[index] = updatedPost;
    }
    notifyListeners();
  }

  updateBookmarkInBookmarkPost(String id, bool isBookmark) {
    int index = _bookmarks.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _bookmarks[index].id,
          userId: _bookmarks[index].userId,
          postingTime: _bookmarks[index].postingTime,
          title: _bookmarks[index].title,
          name: _bookmarks[index].name,
          verified: _bookmarks[index].verified,
          content: _bookmarks[index].content,
          price: _bookmarks[index].price,
          adviseType: _bookmarks[index].adviseType,
          emoji: _bookmarks[index].emoji,
          images: _bookmarks[index].images,
          postType: _bookmarks[index].postType,
          avatar: _bookmarks[index].avatar,
          view: _bookmarks[index].view,
          applyCount: _bookmarks[index].applyCount,
          likeCounts: _bookmarks[index].likeCounts,
          isLike: _bookmarks[index].isLike,
          adviseTypeValue: _bookmarks[index].adviseTypeValue,
          isDelete: _bookmarks[index].isDelete,
          deleteTime: _bookmarks[index].deleteTime,
          userAddress: _bookmarks[index].userAddress,
          userAge: _bookmarks[index].userAge,
          isPublic: _bookmarks[index].isPublic,
          isBookmark: isBookmark,
          online: _bookmarks[index].online,
          countPaymentVerified: _bookmarks[index].countPaymentVerified);

      _bookmarks[index] = updatedPost;
    }
    notifyListeners();
  }

  updateDeleteInBookmarkPost(String id) {
    int index = _bookmarks.indexWhere((post) => post.id == id);
    if (index != -1) {
      PostAll updatedPost = PostAll(
          id: _bookmarks[index].id,
          userId: _bookmarks[index].userId,
          postingTime: _bookmarks[index].postingTime,
          title: _bookmarks[index].title,
          name: _bookmarks[index].name,
          verified: _bookmarks[index].verified,
          content: _bookmarks[index].content,
          price: _bookmarks[index].price,
          adviseType: _bookmarks[index].adviseType,
          emoji: _bookmarks[index].emoji,
          images: _bookmarks[index].images,
          postType: _bookmarks[index].postType,
          avatar: _bookmarks[index].avatar,
          view: _bookmarks[index].view,
          applyCount: _bookmarks[index].applyCount,
          likeCounts: _bookmarks[index].likeCounts,
          isLike: _bookmarks[index].isLike,
          adviseTypeValue: _bookmarks[index].adviseTypeValue,
          isDelete: true,
          deleteTime: _bookmarks[index].deleteTime,
          userAddress: _bookmarks[index].userAddress,
          userAge: _bookmarks[index].userAge,
          isPublic: _bookmarks[index].isPublic,
          isBookmark: _bookmarks[index].isBookmark,
          online: _bookmarks[index].online,
          countPaymentVerified: _bookmarks[index].countPaymentVerified);

      _bookmarks[index] = updatedPost;
    }
    notifyListeners();
  }
}
