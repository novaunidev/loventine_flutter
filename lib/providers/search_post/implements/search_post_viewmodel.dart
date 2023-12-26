import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loventine_flutter/models/search_post/search_response.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';

import '../../../config.dart';
import '../../../models/post_all.dart';
import '../../../models/search_post/filter.dart';
import '../interfaces/isearch_post_viewmodel.dart';

class SearchPostViewModel with ChangeNotifier implements ISearchPostViewModel {
  final List<PostAll> _postAll = [];
  final List<PostAll> _postFilter = [];
  List<PostAll> _relatePost = [];
  List<SearchResponse> _searchResponses = [];
  String _searchContent = '';
  List<SearchResponse> _historySearch = [];
  bool _isLoading = false;
  bool _isEmpty = false;
  int skipNum = 4;
  Filter? _filter;
  @override
  Filter? get filter => _filter;

  set filter(Filter? newFilter) {
    _filter = newFilter;
  }

  @override
  String get searchContent => _searchContent;

  @override
  List<PostAll> get postAll => _postAll;

  @override
  bool get isLoading => _isLoading;

  @override
  bool get isEmpty => _isEmpty;

  @override
  List<PostAll> get postFilter => _postFilter;

  @override
  List<PostAll> get relatePost => _relatePost;

  @override
  List<SearchResponse> get searchResponses => _searchResponses;

  @override
  List<SearchResponse> get historySearch => _historySearch;

  @override
  void clearSearchResponses() {
    _searchResponses = [];
    notifyListeners();
  }

  @override
  void initData() {
    _searchContent = '';
    clearSearchResponses();
    notifyListeners();
  }

  @override
  Future<void> getHistorySearch() async {
    _historySearch = [];
    try {
      http.Response result = await http.get(
        Uri.parse('$baseUrl/history-search'),
        headers: await appAuth.createHeaders(),
      );
      appAuth.checkResponse(result);
      var jsonData = result.body;
      final data = json.decode(jsonData) as Map<String, dynamic>;
      List<dynamic> rawData = data['data'];
      List<SearchResponse> history =
          rawData.map((item) => SearchResponse.fromJson(item)).toList();
      _historySearch.addAll(history);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> saveHistorySearch({SearchResponse? searchResponse}) async {
    try {
      var uri = Uri.parse("$baseUrl/history-search");
      http.Response res = await http.post(
        uri,
        body: searchResponse!.toJson(),
        headers: await appAuth.createHeaders(),
      );
      appAuth.checkResponse(res);
      if (res.statusCode == 200) {
        await getHistorySearch();
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> onSearch({
    String? keyWord,
    int? minPrice,
    int? maxPrice,
    String? adviseType,
    String? postType,
  }) async {
    _searchResponses = [];
    initData();
    _searchContent = keyWord ?? "";
    _filter = Filter(
        maxPrice: maxPrice?.toDouble(),
        minPrice: minPrice?.toDouble(),
        adviseType: adviseType,
        postType: postType,
        keyWord: keyWord);
    try {
      var response =
          await Dio().get("$baseUrl/post/suggestText", queryParameters: {
        'keyword': keyWord,
        'page': 1,
        'pageSize': 5,
        'minPrice': minPrice ?? 0,
        'maxPrice': maxPrice ?? 10000000,
        'adviseType': adviseType,
        'postType': 'fee'
      });
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data['data'];
        List<SearchResponse> searchResponses =
            responseData.map((item) => SearchResponse.fromJson(item)).toList();
        _searchResponses.addAll(searchResponses);
      }
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<PostAll> navigateJobDetail(String postId) async {
    try {
      var response = await Dio().get('$baseUrl/post/getPostById/$postId');
      if (response.statusCode == 200) {
        PostAll postAll =
            PostAll.toPostAll(response.data as Map<String, dynamic>);
        return postAll;
      } else {
        throw Exception('Failed to fetch post');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch post');
    }
  }

  @override
  Future<void> getAllFeePost(
    int page,
    String userId,
    int limit,
  ) async {
    _relatePost = [];
    try {
      var result = await Dio()
          .get("$baseUrl/post/getAllFeePost/$userId", queryParameters: {
        'page': page,
        'limit': limit,
      });

      List<dynamic> data = result.data as List<dynamic>;
      if (data.isEmpty) {
        _isLoading = false;
      } else {
        _isLoading = true;
      }
      for (int i = 0; i < data.length; i++) {
        _relatePost.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
      }

      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> initSearchResult() async {
    _postFilter.clear();
    _isLoading = false;
    _isEmpty = false;
    _searchContent = _filter?.keyWord ?? "";
    skipNum = 0;
    try {
      var response = await Dio().patch("$baseUrl/post", data: {
        "minPrice": _filter?.minPrice,
        "maxPrice": _filter?.maxPrice,
        "searchTitle": _filter?.keyWord,
        "postType": 'fee',
        "adviseType": _filter?.adviseType,
        "skipNum": skipNum,
        "limitNum": 5
      });
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'] as List<dynamic>;
        for (int i = 0; i < data.length; i++) {
          _postFilter.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
        }
        notifyListeners();
      } else {
        throw Exception('Failed to fetch post');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch post');
    }
  }

  @override
  Future<void> onSearchPostFilter() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(
      const Duration(milliseconds: 800),
      () {},
    );
    try {
      var response = await Dio().patch("$baseUrl/post", data: {
        "minPrice": _filter?.minPrice,
        "maxPrice": _filter?.maxPrice,
        "searchTitle": _filter?.keyWord,
        "postType": 'fee',
        "adviseType": _filter?.adviseType,
        "skipNum": skipNum,
        "limitNum": 5,
      });
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'] as List<dynamic>;
        if (data.isEmpty) {
          _isLoading = false;
          notifyListeners();
          await Future.delayed(
            const Duration(milliseconds: 1000),
            () {},
          );
          _isEmpty = true;
          notifyListeners();
        } else {
          for (int i = 0; i < data.length; i++) {
            _postFilter.add(PostAll.toPostAll(data[i] as Map<String, dynamic>));
          }
          _isLoading = false;
          skipNum += 5;
          notifyListeners();
        }

        notifyListeners();
      } else {
        throw Exception('Failed to fetch post');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to fetch post');
    }
  }

  @override
  Future<void> deleteHistory(String postId) async {
    http.Response res = await http.delete(
        Uri.parse(
          "$baseUrl/history-search/$postId/",
        ),
        headers: await appAuth.createHeaders());
    if (res.statusCode == 200) {
      getHistorySearch();
    }
    notifyListeners();
  }
}
