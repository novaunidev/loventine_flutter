// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostAll {
  final String id;
  final String userId;
  final String postingTime;
  final String title;
  final String name;
  final bool verified;
  final String content;
  final String price;
  final String adviseType;
  final String emoji;
  final List<String> images;
  final String postType;
  final String avatar;
  final int view;
  final int applyCount;
  final int likeCounts;
  final bool isLike;
  final int adviseTypeValue;
  final bool isDelete;
  final String deleteTime;
  final String userAddress;
  final String userAge;
  final bool isPublic;
  final bool isBookmark;
  final bool online;
  int countPaymentVerified;

  PostAll(
      {required this.id,
      required this.userId,
      required this.verified,
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
      required this.likeCounts,
      required this.isLike,
      required this.adviseTypeValue,
      required this.isDelete,
      required this.deleteTime,
      required this.userAddress,
      required this.userAge,
      required this.isPublic,
      required this.isBookmark,
      required this.online,
      required this.countPaymentVerified});

  static PostAll toPostAll(Map<String, dynamic> data) {
    var adviseType = adviseTypeLabels[data["adviseType"]] ?? "";
    var adviseTypeValue = 0;

    if (data["adviseType"] == "daily") {
      adviseTypeValue = data["dailyDuration"] ?? 0;
    } else if (data["adviseType"] == "hourly") {
      adviseTypeValue = data["hourlyDuration"] ?? 0;
    } else if (data["adviseType"] == "monthly") {
      adviseTypeValue = data["monthlyDuration"] ?? 0;
    } else if (data["adviseType"] == "yearly") {
      adviseTypeValue = data["yearlyDuration"] ?? 0;
    }
    return PostAll(
        id: data["_id"] ?? "",
        verified: data["author"]["verified"] ?? false,
        userId: data["author"]["_id"] ?? "",
        postingTime: data["postingTime"] ?? "",
        title: data["title"] ?? "",
        name: data["author"]["name"] ?? "",
        content: data["content"] ?? "",
        price: data["price"].toString(),
        adviseType: adviseType,
        postType: data["postType"] ?? "",
        avatar: data["author"]["avatarUrl"] ?? "",
        emoji: data["emoji"].toString(),
        images: List<String>.from(data["images"]),
        view: data["view"] ?? 0,
        applyCount: data["applyCount"] ?? 0,
        likeCounts: data["likeCounts"] ?? 0,
        isLike: data["isLike"] ?? false,
        adviseTypeValue: adviseTypeValue,
        isDelete: data["isDelete"] ?? false,
        deleteTime: data["deleteTime"] ?? "",
        userAddress: data["userAddress"] ?? "",
        userAge: data["author"]["birthday"] ?? "",
        isPublic: data["isPublic"] ?? true,
        isBookmark: data["isBookmark"] ?? false,
        online: data["author"]["online"] ?? false,
        countPaymentVerified: data["countPaymentVerified"] ?? 0);
  }

  static Map<String, String> adviseTypeLabels = {
    "package": "Trọn gói",
    "daily": "ngày",
    "hourly": "giờ",
    "monthly": "tháng",
    "yearly": "năm"
  };
}

//Trong lớp PostAll, trường price có kiểu dữ liệu là String nên cần chuyển đổi từ kiểu dữ liệu số sang chuỗi bằng cách sử dụng phương thức toString().