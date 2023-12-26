class SearchResponse {
  String? id;
  String? title;
  String? postType;
  String? postId;
  String? authorName;
  String? authorAvatarUrl;

  SearchResponse(
      {this.title,
      this.id,
      this.postType,
      this.postId,
      this.authorName,
      this.authorAvatarUrl});

  SearchResponse.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    postType = json['postType'];
    postId = json['postId'];
    authorName = json['author_name'];
    authorAvatarUrl = json['author_avatarUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['postType'] = postType;
    data['postId'] = postId;
    data['author_name'] = authorName;
    data['author_avatarUrl'] = authorAvatarUrl;
    return data;
  }
}
