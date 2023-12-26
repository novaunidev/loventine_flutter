import 'dart:convert';

import 'package:http/http.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/payment/bill.dart';
import 'package:loventine_flutter/models/payment/bill_paid_suggest.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';

class BillService {
  static Future<String> paid(String id) async {
    try {
      var uri = Uri.parse('$urlBillPaid/$id');
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
      var body = jsonDecode(res.body);

      if (res.statusCode == 200) {
        return successMessageDefault;
      } else {
        return body['message'];
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<BillPaySuggest> paidSuggest(String id) async {
    try {
      var uri = Uri.parse('$urlBillPaidSuggest/$id');
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
        return BillPaySuggest.fromJson(body['data']);
      } else {
        return BillPaySuggest(isPayAccecpt: false, suggestText: 'Trống');
      }
    } catch (e) {
      return BillPaySuggest(isPayAccecpt: false, suggestText: 'Trống');
    }
  }

  static Future<List<Bill>> getBills(
    int? page,
    int? pageSize,
    int? sortCreatedAt,
    int? sortUpdatedAt,
  ) async {
    try {
      Map<String, String> paramsValue = Map<String, String>();
      if (page != null) {
        paramsValue["page"] = page.toString();
      }
      if (pageSize != null) {
        paramsValue["pageSize"] = pageSize.toString();
      }

      if (sortCreatedAt != null) {
        paramsValue["sortCreatedAt"] = sortCreatedAt.toString();
      }
      if (sortUpdatedAt != null) {
        paramsValue["sortUpdatedAt"] = sortUpdatedAt.toString();
      }

      var uri = Uri.parse(urlBill).replace(queryParameters: paramsValue);
      Response res = await get(
        uri,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('params :');
        print(paramsValue);
        print('response :');
        print(json.decode(res.body));
      }

      appAuth.checkResponse(res);

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        List<dynamic> data = body['data'];
        List<Bill> lists =
            data.map((dynamic item) => Bill.fromJson(item)).toList();
        return lists;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
