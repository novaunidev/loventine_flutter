// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bookmark {
  final String id;
  final String userId;
  final String postingTime;
  final String title;
  final String name;
  final String content;
  final String price;
  final String adviseType;
  final String emoji;
  final List<String> images;
  final String postType;
  final String avatar;
  final int view;
  final int applyCount;

  Bookmark({
    required this.id,
    required this.userId,
    required this.postingTime,
    required this.title,
    required this.name,
    required this.content,
    required this.price,
    required this.adviseType,
    required this.emoji,
    required this.images,
    required this.postType,
    required this.avatar,
    required this.view,
    required this.applyCount,
  });

  static Bookmark toBookmark(Map<String, dynamic> data) {
    return Bookmark(
      id: data["_id"] ?? "",
      userId: data["author"]["_id"] ?? "",
      postingTime: data["postingTime"] ?? "",
      title: data["title"] ?? "",
      name: data["author"]["name"] ?? "",
      content: data["content"] ?? "",
      price: data["price"].toString(),
      adviseType: data["adviseType"] ?? "",
      postType: data["postType"] ?? "",
      avatar: data["author"]["avatarUrl"] ?? "",
      emoji: data["emoji"].toString(),
      images: List<String>.from(
        data["images"],
      ),
      view: data["view"] ?? 0,
      applyCount: data["applyCount"] ?? 0,
    );
  }
}
