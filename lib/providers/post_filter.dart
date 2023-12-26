// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

class PostFilter with ChangeNotifier {
  String? id;
  String userId;
  String searchContent;
  int minPrice;
  int maxPrice;
  List<String> postType;

  PostFilter({
    this.id,
    required this.userId,
    required this.searchContent,
    required this.minPrice,
    required this.maxPrice,
    required this.postType,
  });

  static PostFilter toPostFilter(Map<String, dynamic> data) {
    return PostFilter(
      id: data["_id"],
      postType: List<String>.from(data["postType"]),
      searchContent: data["searchContent"],
      userId: data["userId"],
      minPrice: data["minPrice"],
      maxPrice: data["maxPrice"],
    );
  }
}
