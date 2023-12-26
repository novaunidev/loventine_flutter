import 'dart:convert';

import 'package:http/http.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/payment/bank_account_personal.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';

class BankAccoutPersonalService {
  static Future<BankAccountPersonal> getOne() async {
    try {
      var uri = Uri.parse(urlBankAccountPersonal);
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
        dynamic data = body['data'];
        return BankAccountPersonal.fromJson(data);
      } else {
        return BankAccountPersonal();
      }
    } catch (e) {
      return BankAccountPersonal();
    }
  }

  static Future<String> updateOne(
      String name, String accountNumber, String ownerName) async {
    try {
      Map<String, String> bodyValue = Map<String, String>();
      bodyValue["name"] = name;
      bodyValue["accountNumber"] = accountNumber;
      bodyValue["ownerName"] = ownerName;

      var uri = Uri.parse(urlBankAccountPersonal);
      Response res = await patch(
        uri,
        body: bodyValue,
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
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }
}
