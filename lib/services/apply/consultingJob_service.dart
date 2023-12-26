import 'dart:convert';
import 'package:http/http.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import '../../../config.dart';

class ConsultingJobService {
  static Future<dynamic> update(String id, String userId, String stateName,
      String state, String? time_suggest_start_job) async {
    try {
      var uri = Uri.parse("$urlConsultingJobUpdateAction/$id");

      Map<String, String> bodyValue = Map<String, String>();
      bodyValue["userId"] = userId;
      bodyValue["stateName"] = stateName;
      bodyValue["state"] = state;
      if (time_suggest_start_job != null) {
        bodyValue["time_suggest_start_job"] = time_suggest_start_job;
      }

      Response res = await patch(
        uri,
        body: bodyValue,
        headers: await appAuth.createHeaders(),
      );

      appAuth.checkResponse(res);

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('body :');
        print(bodyValue);
        print('response :');
        print(json.decode(res.body));
      }

      if (res.statusCode == 200) {
        return successMessageDefault;
      } else {
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<dynamic> paid(
    String id,
  ) async {
    try {
      var uri = Uri.parse("$urlConsultingJobPaid/$id");

      Response res = await patch(
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
        return successMessageDefault;
      } else {
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }
}
