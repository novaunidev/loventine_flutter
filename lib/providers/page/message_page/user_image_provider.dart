import 'package:flutter/foundation.dart';
import '../../../config.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loventine_flutter/models/profile/user_image.dart';

class UserImageProvider with ChangeNotifier {
  final _dio = Dio();
  List<UserImage> _image_uploads = [];

  List<UserImage> get image_uploads => _image_uploads;

  String _avatar =
      'https://res.cloudinary.com/dc8kxjddi/image/upload/v1676186304/avatar_man_oicegg.gif';
  String get avatar => _avatar;

  List<String> _fcmTokens = [];
  List<String> get fcmTokens => _fcmTokens;

  String _avatar_cloudinary_public_id = '';
  String get avatar_cloudinary_public_id => _avatar_cloudinary_public_id;

  Future<void> getAllUserImage(String userId) async {
    try {
      var result = await _dio.get("$baseUrl/auth/getUser/$userId");

      Map<String, dynamic> data = result.data as Map<String, dynamic>;
      var image_uploadsServer = data["message"]["image_uploads"];
      _image_uploads = [];
      for (int i = 0; i < image_uploadsServer.length; i++) {
        _image_uploads.add(UserImage.toUserImage(
            image_uploadsServer[i] as Map<String, dynamic>));
      }
      _avatar = data["message"]["avatarUrl"];
      _avatar_cloudinary_public_id =
          data["message"]["avatar_cloudinary_public_id"];
      //FCM
      List<dynamic> fcmTokensDynamic = data["message"]["fcm_tokens"];
      _fcmTokens = fcmTokensDynamic
          .cast<String>(); // Chuyển đổi danh sách động thành danh sách chữ

      notifyListeners();
    } catch (e) {
      //_image_uploads = [];
      notifyListeners();
    }
    notifyListeners();
  }

  // String getAvatar() {
  //   return image_uploads.isNotEmpty
  //       ? image_uploads[0].avatar
  //       : 'https://res.cloudinary.com/dc8kxjddi/image/upload/v1676186304/avatar_man_oicegg.gif';
  // }

  // // String getId() {
  // //   return image_uploads.isNotEmpty ? image_uploads[0].id : '';
  // // }
}
