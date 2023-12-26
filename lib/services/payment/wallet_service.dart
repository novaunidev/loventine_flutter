import 'dart:convert';

import 'package:http/http.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/payment/bank_account.dart';
import 'package:loventine_flutter/models/payment/transaction.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';

class WalletService {
  static String walletEmail = '';
  static double walletForVerify = 0;

  static Future<double> getWallet() async {
    try {
      var uri = Uri.parse(urlGetWallet);
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
        walletEmail = data['email'];
        walletForVerify = double.parse(data['walletForVerify'].toString());
        return double.parse(data['wallet'].toString());
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  static Future<List<Transaction>> getTransactions(
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

      var uri = Uri.parse(urlTransaction).replace(queryParameters: paramsValue);
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
        List<Transaction> lists =
            data.map((dynamic item) => Transaction.fromJson(item)).toList();
        return lists;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<List<BankAccount>> getBackAccounts(
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

      var uri = Uri.parse(urlBankAccount).replace(queryParameters: paramsValue);
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
        List<BankAccount> lists =
            data.map((dynamic item) => BankAccount.fromJson(item)).toList();
        return lists;
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<String> requestWithDrawMoney(
      String name, String accountNumber, String ownerName, double money) async {
    try {
      Map<String, String> bodyValue = Map<String, String>();
      bodyValue["name"] = name;
      bodyValue["accountNumber"] = accountNumber;
      bodyValue["ownerName"] = ownerName;
      bodyValue["money"] = money.toString();

      var uri = Uri.parse(urlWithdrawMoney);
      Response res = await post(
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
        var body = jsonDecode(res.body);
        return body['message'];
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }
}
