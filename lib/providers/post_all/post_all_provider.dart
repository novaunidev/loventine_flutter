import 'package:flutter/foundation.dart';
import '../../config.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loventine_flutter/models/post_all.dart';

class PostAllProvider with ChangeNotifier {
  final _dio = Dio();
  List<PostAll> _postAll = [];
  List<PostAll> _postFee = [];
  List<PostAll> _postFree = [];
  List<PostAll> _postAllUser = [];
  List<PostAll> _postFeeUser = [];
  List<PostAll> _postFreeUser = [];
  List<PostAll> _otherPost = [];
  List<String> _title = [];
  List<PostAll> _postFilter = [];

  List<PostAll> get postAll => _postAll;
  List<PostAll> get postFee => _postFee;
  List<PostAll> get postFree => _postFree;
  List<PostAll> get postAllUser => _postAllUser;
  List<PostAll> get postFreeUser => _postFreeUser;
  List<PostAll> get postFeeUser => _postFeeUser;
  List<PostAll> get otherPost => _otherPost;
  List<String> get title => _title;
  List<PostAll> get postFilter => _postFilter;
  // Future<void> getAllPostAll() async {
  //   try {
  //     var result = await _dio.get("$baseUrl/post/getAllPost");
  //     List<dynamic> data = result.data as List<dynamic>;
  //     _postAll = [];
  //     for (int i = 0; i < data.length; i++) {
  //       _postAll.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
  //     }
  //     // Sắp xếp ngược lại danh sách
  //     _postAll = _postAll.reversed.toList();
  //     // Lấy danh sách bài đăng có chứa "postType" = "fee"
  //     _postFee = _postAll.where((post) => post.postType == "fee").toList();
  //     _postFree = _postAll.where((post) => post.postType == "free").toList();
  //     notifyListeners();
  //   } catch (e) {
  //     _postAll = [];
  //     notifyListeners();
  //   }
  // }

  // Future<void> getAllPostsOfUser(String userId) async {
  //   try {
  //     var result = await _dio.get("$baseUrl/post/getAllPostsOfUser/$userId");

  //     List<dynamic> data = result.data as List<dynamic>;
  //     _postAllUser = [];
  //     for (int i = 0; i < data.length; i++) {
  //       _postAllUser.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
  //     }

  //     // Sắp xếp ngược lại danh sách
  //     _postAllUser = _postAllUser.reversed.toList();

  //     // Lấy danh sách bài đăng có chứa "postType" = "fee"
  //     _postFeeUser =
  //         _postAllUser.where((post) => post.postType == "fee").toList();
  //     _postFreeUser =
  //         _postAllUser.where((post) => post.postType == "free").toList();
  //     notifyListeners();
  //   } catch (e) {
  //     _postAllUser = [];
  //     notifyListeners();
  //   }
  // }

  // Future<void> getAllOtherPost(String userId) async {
  //   try {
  //     var result = await _dio.get("$baseUrl/post/getAllOtherPost/$userId");

  //     List<dynamic> data = result.data as List<dynamic>;
  //     _otherPost = [];
  //     for (int i = 0; i < data.length; i++) {
  //       _otherPost.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
  //     }

  //     // Sắp xếp ngược lại danh sách
  //     _otherPost = _otherPost.reversed.toList();

  //     // Lấy danh sách bài đăng có chứa "postType" = "fee"
  //     _otherPost = _otherPost.where((post) => post.postType == "fee").toList();
  //     notifyListeners();
  //   } catch (e) {
  //     _otherPost = [];
  //     notifyListeners();
  //   }
  // }

  Future<void> getAllTitle() async {
    try {
      var result = await _dio.get("$baseUrl/post/getAllPost");
      List<dynamic> data = result.data as List<dynamic>;
      _postAll = [];
      _title = [];
      for (int i = 0; i < data.length; i++) {
        _postAll.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
        if (_postAll[i].postType == "fee") {
          _title.add(_postAll[i].title);
        }
      }
    } catch (e) {
      _postAll = [];
      notifyListeners();
    }
  }

  Future<void> getPostWithFilter(int minPrice, int maxPrice,
      String searchContent, List<String> postType) async {
    try {
      var result = await _dio.post("$baseUrl/post/getPostWithFilter", data: {
        "minPrice": minPrice,
        "maxPrice": maxPrice,
        "searchString": searchContent,
        "postType": postType,
      });
      List<dynamic> data = result.data as List<dynamic>;
      _postFilter = [];
      for (int i = 0; i < data.length; i++) {
        _postFilter.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
        print(_postFilter[i]);
      }
    } catch (e) {
      print(e);
    }
  }
}
