import 'package:flutter/foundation.dart';
import 'package:loventine_flutter/providers/post_filter.dart';
import '../../config.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class PostFilterProvider with ChangeNotifier {
  List<PostFilter> _postFilter = [];
  List<PostFilter> get postFilter => _postFilter;

  Future<void> getAllPostFilter(String current_user_id) async {
    try {
      var result = await Dio()
          .get("$baseUrl/filter/getAllFilterOfUser/$current_user_id");
      List<dynamic> data = result.data as List<dynamic>;
      List<PostFilter> postFilter = [];
      for (int i = 0; i < data.length; i++) {
        postFilter
            .add(PostFilter.toPostFilter(data[i] as Map<String, dynamic>));
        _postFilter = postFilter.reversed.toList();
      }

      notifyListeners();
    } catch (e) {
      _postFilter = [];
      print(e);
      notifyListeners();
    }
  }

  Future<void> deleteItem(PostFilter temp) async {
    postFilter.remove(temp);
    notifyListeners();
    try {
      var response =
          await Dio().delete("$baseUrl/filter/deleteFilter/${temp.id}");
      if (response.statusCode == 200) {
        print('Xóa thành công');
      }
    } catch (e) {
      print(e);
    }
  }
}
