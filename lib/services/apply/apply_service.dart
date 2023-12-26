import 'dart:convert';
import 'package:http/http.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import '../../../config.dart';
import '../../models/apply/get.dart';

/*
  create/delete/update return errorMessageDefault/successMessageDefault/body['message']

  gets return []

  getOne return Models/errorMessageDefault
*/
class ApplyService {
  static Future<dynamic> create(
    String _post,
    String? resume,
    int? negotiatePrice,
    String? letter,
    String creator,
    String poster,
  ) async {
    try {
      var uri = Uri.parse(urlApply);
      Map<String, String> bodyValue = Map<String, String>();
      bodyValue["post"] = _post;
      bodyValue["creator"] = creator;
      bodyValue["poster"] = poster;
      if (resume != null) {
        bodyValue["resume"] = resume;
      }
      if (negotiatePrice != null) {
        bodyValue["negotiatePrice"] = negotiatePrice.toString();
      }
      if (letter != null) {
        bodyValue["letter"] = letter;
      }

      Response res = await post(
        uri,
        body: bodyValue,
        headers: await appAuth.createHeaders(),
      );
      dynamic body = jsonDecode(res.body);

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('body :');
        print(bodyValue);
        print('response :');
        print(json.decode(res.body));
      }

      appAuth.checkResponse(res);

      if (res.statusCode == 200) {
        return successMessageDefault;
      } else if (res.statusCode == 400) {
        if (body['message'] == null) {
          return errorMessageDefault;
        } else {
          return body['message'];
        }
      } else {
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<dynamic> getOne(String id) async {
    try {
      var uri = Uri.parse("$urlApply/$id");
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
        var jsonData = res.body;
        final data = json.decode(jsonData) as Map<String, dynamic>;
        return Apply.fromJson(data['data']);
      } else {
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }

  static Future<List<Apply>> gets(
    String? creator,
    String? poster,
    String? searchCreatorName,
    String? searchPosterName,
    String? searchPostTitle,
    String? state,
    String? post,
    String? deleteState,
    int? skipNum,
    int? limitNum,
    int? sortCreatedAt,
    int? sortUpdatedAt,
    String? fromCreatedAt,
    String? toCreatedAt,
    String userId,
    String? negotiatePrice,
  ) async {
    try {
      Map<String, String> paramsValue = Map<String, String>();
      paramsValue["userId"] = userId;
      if (skipNum != null) {
        paramsValue["skipNum"] = skipNum.toString();
      }
      if (limitNum != null) {
        paramsValue["limitNum"] = limitNum.toString();
      }

      if (negotiatePrice != null) {
        paramsValue["negotiatePrice"] = negotiatePrice.toString();
      }

      if (sortCreatedAt != null) {
        paramsValue["sortCreatedAt"] = sortCreatedAt.toString();
      }
      if (sortUpdatedAt != null) {
        paramsValue["sortUpdatedAt"] = sortUpdatedAt.toString();
      }

      if (fromCreatedAt != null) {
        paramsValue["fromCreatedAt"] = fromCreatedAt.toString();
      }
      if (toCreatedAt != null) {
        paramsValue["toCreatedAt"] = toCreatedAt.toString();
      }

      if (creator != null) {
        paramsValue["creator"] = creator.toString();
      }

      if (poster != null) {
        paramsValue["poster"] = poster.toString();
      }

      if (searchCreatorName != null) {
        paramsValue["searchCreatorName"] = searchCreatorName.toString();
      }

      if (searchPosterName != null) {
        paramsValue["searchPosterName"] = searchPosterName.toString();
      }

      if (toCreatedAt != null) {
        paramsValue["searchPostTitle"] = searchPostTitle.toString();
      }

      if (state != null) {
        paramsValue["state"] = state.toString();
      }

      if (post != null) {
        paramsValue["post"] = post.toString();
      }

      if (deleteState != null) {
        paramsValue["deleteState"] = deleteState.toString();
      }

      var uri = Uri.parse(urlApply).replace(queryParameters: paramsValue);
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
        List<Apply> applys =
            data.map((dynamic item) => Apply.fromJson(item)).toList();
        applys.forEach((element) {
          print(element.toJson().toString());
        });
        return applys;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }

  static Future<dynamic> update(
    String id,
    String? resume,
    int? negotiatePrice,
    String? letter,
    String? timelineType,
  ) async {
    try {
      var uri = Uri.parse('$urlApply/$id');

      Map<String, String> bodyValue = Map<String, String>();

      if (resume != null) {
        bodyValue["resume"] = resume;
      }

      if (negotiatePrice != null) {
        bodyValue["negotiatePrice"] = negotiatePrice.toString();
      }

      if (letter != null) {
        bodyValue["letter"] = letter;
      }

      if (timelineType != null) {
        bodyValue["timelineType"] = timelineType;
      }

      Response res = await patch(
        uri,
        body: bodyValue,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('body :');
        print(bodyValue);
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

  static Future<dynamic> updateState(
      String id, String state, String? reasonDeclined) async {
    try {
      var uri = Uri.parse('$urlApplyUpdateState/$id');

      Map<String, String> bodyValue = Map<String, String>();
      bodyValue["state"] = state;
      if (reasonDeclined != null) {
        bodyValue["reasonDeclined"] = reasonDeclined;
      }

      Response res = await patch(
        uri,
        body: bodyValue,
        headers: await appAuth.createHeaders(),
      );

      if (testServiceMode == true) {
        print('url :');
        print(uri.toString());
        print('body :');
        print(bodyValue);
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

  static Future<dynamic> deleteOne(
    String id,
  ) async {
    try {
      var uri = Uri.parse('$urlApply/$id');
      Response res = await delete(
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
        return errorMessageDefault;
      }
    } catch (e) {
      return errorMessageDefault;
    }
  }
}
