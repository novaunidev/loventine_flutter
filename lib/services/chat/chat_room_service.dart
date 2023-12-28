import 'dart:convert';
import 'package:http/http.dart';
import 'package:loventine_flutter/constant.dart';
import '../../config.dart';

import '../../models/chat/get.dart' as GetApi;
import '../../providers/chat/socket_provider.dart';

class ChatRoomService {
  static int num_message_unwatch = 0;
  static Future<List<GetApi.ChatRoom>> gets(
    int? skipNum,
    int? limitNum,
    bool? isExprired,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? searchString,
    int? type,
    String? fromCreatedAt,
    String? toCreatedAt,
  ) async {
    Map<String, String> paramsValue = Map<String, String>();
    paramsValue["userId"] = SocketProvider.current_user_id;
    if (skipNum != null) {
      paramsValue["skipNum"] = skipNum.toString();
    }
    if (limitNum != null) {
      paramsValue["limitNum"] = limitNum.toString();
    }
    if (isExprired != null) {
      paramsValue["isExprired"] = isExprired.toString();
    }
    if (sortCreatedAt != null) {
      paramsValue["sortCreatedAt"] = sortCreatedAt.toString();
    }
    if (sortUpdatedAt != null) {
      paramsValue["sortUpdatedAt"] = sortUpdatedAt.toString();
    }
    if (searchString != null) {
      paramsValue["searchString"] = searchString.toString();
    }
    if (type != null) {
      paramsValue["type"] = type.toString();
    }
    if (fromCreatedAt != null) {
      paramsValue["fromCreatedAt"] = fromCreatedAt.toString();
    }
    if (toCreatedAt != null) {
      paramsValue["toCreatedAt"] = toCreatedAt.toString();
    }
    var uri = Uri.parse(urlChatRoom).replace(queryParameters: paramsValue);
    print(uri.toString());
    Response res = await get(
      uri,
    );

    if (res.statusCode == 200) {
      var body = jsonDecode(res.body);
      List<dynamic> data = body['data'];
      num_message_unwatch = body['num_message_unwatch'];
      print(body);
      List<GetApi.ChatRoom> chatrooms =
          data.map((dynamic item) => GetApi.ChatRoom.fromJson(item)).toList();
      return chatrooms;
    } else {
      throw "Failed to load chatrooms";
    }
  }

  static Future<void> update(String chatRoomId, bool? isAllow) async {
    try {
      Map<String, String> paramsValue = Map<String, String>();
      paramsValue["userId"] = SocketProvider.current_user_id;
      if (isAllow != null) {
        paramsValue["isAllowNotifiCation"] = isAllow.toString();
      }

      var uri = Uri.parse('$urlChatRoom/$chatRoomId')
          .replace(queryParameters: paramsValue);

      Response res = await patch(
        uri,
      );

      switch (res.statusCode) {
        case 200:
          {
            var data = json.decode(res.body);
            return data["success"];
          }
        // break;

        case 400:
          {
            var data = json.decode(res.body);
            throw (data["errors"]);
          }
        // break;
        case 500:
          {
            var data = json.decode(res.body);
            throw (data["errors"]);
          }
        // break;
        default:
          {
            //statements;
          }
          break;
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<GetApi.ChatRoom> getOne(String chatId) async {
    try {
      var uri = Uri.parse('$urlChatRoom/$chatId').replace(queryParameters: {
        'userId': SocketProvider.current_user_id,
      });

      Response res = await get(
        uri,
      );

      if (res.statusCode == 200) {
        var jsonData = res.body;
        final data = json.decode(jsonData) as Map<String, dynamic>;
        return GetApi.ChatRoom.fromJson(data['data']);
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

  static Future<dynamic> create(
      String userId_1, String userId_2, String type) async {
    try {
      var uri = Uri.parse(urlChatRoom);
      Response res = await post(
        uri,
        body: {
          "user1": userId_1,
          "user2": userId_2,
          'type': type,
        },
      );

      if (res.statusCode == 200) {
        print(res.body);

        return successMessageDefault;
      } else {
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<dynamic> getOneWith(
      String user1, String user2, String type, String userId) async {
    try {
      var uri = Uri.parse(urlChatRoomGetOneWith).replace(queryParameters: {
        'userId': userId,
        'user1': user1,
        'user2': user2,
        'type': type,
      });

      Response res = await get(
        uri,
      );

      print(res.statusCode);

      if (res.statusCode == 200) {
        var jsonData = res.body;
        final data = json.decode(jsonData) as Map<String, dynamic>;
        print(jsonData);
        return GetApi.ChatRoom.fromJson(data['data']);
      } else {
        print("Lỗi❤️❤️❤️❤️ ");
        return errorMessageDefault;
      }
    } catch (e) {
      print("Lỗi2❤️❤️❤️❤️:$e");
      return errorMessageDefault;
    }
  }
}
