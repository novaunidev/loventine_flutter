import 'dart:convert';
import 'package:http/http.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import '../../config.dart';
import '../models/review.dart';

class ReviewService {
  static Future<dynamic> getOne(String id) async {
    try {
      var uri = Uri.parse("$urlReview/$id");
      Response res = await get(
        uri,
        headers: await appAuth.createHeaders(),
      );
      appAuth.checkResponse(res);
      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('response :');
        print(json.decode(res.body));
      }

      if (res.statusCode == 200) {
        var jsonData = res.body;
        final data = json.decode(jsonData) as Map<String, dynamic>;
        return Review.fromJson(data['data']);
      } else {
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }
}
