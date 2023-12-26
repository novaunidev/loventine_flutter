import 'package:http/http.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/main.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppAuth {
  bool _isNeedLogout = false;
  bool get isNeedLogout => _isNeedLogout;

  void setNeedLogout(bool value) {
    _isNeedLogout = value;
  }

  bool _isErrorJwt = false;
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  saveToken(Response response) async {
    try {
      await _secureStorage.write(
          key: 'access_token', value: response.headers[access_token] as String);
      await _secureStorage.write(
          key: 'refresh_token',
          value: response.headers[refresh_token] as String);
    } catch (e) {
      print(e);
    }
  }

  checkResponse(Response response) async {
    if (response.headers[access_token] != null) {
      await _secureStorage.write(
          key: 'access_token', value: response.headers[access_token] as String);
    }

    if (response.statusCode == 200) {
      _isErrorJwt = false;
    }

    if (_isErrorJwt == true) return;

    if (response.statusCode == 401) {
      _isErrorJwt = true;
      _isNeedLogout = true;
      print('Open login');
      navigatorKey.currentState?.pushNamed('/login');
    }
  }

  createHeaders() async {
    final String? _access_token =
        await _secureStorage.read(key: 'access_token');
    final String? _refresh_token =
        await _secureStorage.read(key: 'refresh_token');
    print('access_token : $_access_token');
    print('refresh_token : $_refresh_token');
    Map<String, String> myHeaders = Map<String, String>();
    myHeaders[access_token] = _access_token as String;
    myHeaders[refresh_token] = _refresh_token as String;
    return myHeaders;
  }

  handleAuth() async {
    Response response = await post(
      Uri.parse(urlAuthCheckToken),
      headers: await createHeaders(),
    );
    checkResponse(response);
  }
}

final appAuth = AppAuth();
