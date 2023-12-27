import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class FreePost {
  final String author;
  final String userId;
  final String title;
  final String content;
  final String postingTime;
  final List<String> images;
  final String postType;
  final String userAddress;
  final bool isPublic;

  FreePost({
    required this.userId,
    required this.title,
    required this.content,
    required this.postingTime,
    required this.images,
    this.postType = 'free',
    required this.userAddress,
    required this.isPublic,
    required this.author
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'title': title,
      'content': content,
      'postingTime': postingTime,
      'images': images,
      "postType": postType,
      "userAddress": userAddress,
      "isPublic": isPublic,
      "author": author

    };
  }

  factory FreePost.fromMap(Map<String, dynamic> map) {
    return FreePost(
      userId: map['userId'] as String,
      title: map['title'] as String,
      content: map['description'] as String,
      postingTime: map['postingTime'] as String,
      images: List<String>.from(map['images']),
      userAddress: map["userAddress"] as String,
      isPublic: map['isPublic'] as bool,
      author: map['author'] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory FreePost.fromJson(String source) =>
      FreePost.fromMap(json.decode(source) as Map<String, dynamic>);
}
