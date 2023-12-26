import 'dart:convert';

import 'package:http/http.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';

import '../../../config.dart';
import '../../../models/post_all.dart';

class PostService {
  static Future<PostAll> getOne(String postId) async {
    print("$baseUrl/post/getPostById/$postId");
    try {
      var uri = Uri.parse('$baseUrl/post/getPostById/$postId');
      Response res = await get(uri);

      if (res.statusCode == 200) {
        var jsonData = res.body;

        // final new_t = json.encode(jsonData);
        // print(jsonData);
        // print(new_t);
        final data = json.decode(jsonData) as Map<String, dynamic>;

        print(data);
        return PostAll.toPostAll(data);
      } else {
        // "Failed to load cases list";
        print("here");
        throw "error";
      }
    } catch (e) {
      print(e);
      throw "error";
    }
  }

  static Future<String> verifyPayment(String postId) async {
    try {
      var uri = Uri.parse('$urlPostPaymentVerified/$postId');
      Response res = await patch(
        uri,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('response :');
        print(json.decode(res.body));
      }

      appAuth.checkResponse(res);

      if (res.statusCode == 200) {
        return successMessageDefault;
      } else {
        var body = jsonDecode(res.body);
        return body['message'];
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<String> cancelVerifyPayment(String postId) async {
    try {
      var uri = Uri.parse('$urlPostCancelPaymentVerified/$postId');
      Response res = await patch(
        uri,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('response :');
        print(json.decode(res.body));
      }

      appAuth.checkResponse(res);

      if (res.statusCode == 200) {
        return successMessageDefault;
      } else {
        var body = jsonDecode(res.body);
        return body['message'];
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<bool> checkVerifyPayment() async {
    try {
      var uri = Uri.parse(urlPostCheckPaymentVerified);
      Response res = await get(
        uri,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('response :');
        print(json.decode(res.body));
      }

      appAuth.checkResponse(res);

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        return body['data']['isCanVerifyPayment'];
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<String> autoVerifyPayment() async {
    try {
      var uri = Uri.parse(urlPostAutoPaymentVerified);
      Response res = await patch(
        uri,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('response :');
        print(json.decode(res.body));
      }

      appAuth.checkResponse(res);

      if (res.statusCode == 200) {
        return successMessageDefault;
      } else {
        var body = jsonDecode(res.body);
        return body['message'];
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }
}
