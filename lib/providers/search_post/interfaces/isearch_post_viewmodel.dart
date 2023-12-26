import 'package:flutter/material.dart';

import '../../../models/post_all.dart';
import '../../../models/search_post/filter.dart';
import '../../../models/search_post/search_response.dart';

abstract class ISearchPostViewModel implements ChangeNotifier {
  String get searchContent;
  List<SearchResponse> get historySearch;
  List<PostAll> get postAll;
  List<PostAll> get postFilter;
  List<PostAll> get relatePost;
  List<SearchResponse> get searchResponses;
  Filter? get filter;
  bool get isEmpty;
  void initData();
  Future<void> onSearch({
    String? keyWord,
    int? minPrice,
    int? maxPrice,
    String? adviseType,
    String? postType,
  });
  Future<void> getHistorySearch();
  Future<void> saveHistorySearch({SearchResponse? searchResponse});
  Future<PostAll> navigateJobDetail(String postId);
  void clearSearchResponses();
  Future<void> initSearchResult();
  bool get isLoading;
  Future<void> onSearchPostFilter();
  Future<void> getAllFeePost(
    int page,
    String userId,
    int limit,
  );
  Future<void> deleteHistory(String postId);
}
