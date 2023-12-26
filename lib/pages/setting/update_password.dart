import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../config.dart';

import '../../main.dart';
import '../../providers/chat/socket_provider.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFF9F9F9);
  // static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF150B3D);
}

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({Key? key}) : super(key: key);

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  late bool isPasswordVisibleOld;
  TextEditingController controllerOld = TextEditingController();

  bool isPasswordVisibleNew = false;
  TextEditingController controllerNew = TextEditingController();

  bool isPasswordVisibleRepeat = false;
  TextEditingController controllerRepeat = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Đổi mật khẩu thành công'),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (_) => MainPage(
                      currentIndex: 0,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showFailDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Đổi mật khẩu không thành công'),
            content: const Text('Mật khẩu cũ không đúng'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Đồng ý'),
              ),
            ],
          );
        });
  }

  Future<void> updatePassword(String oldPassword, String newPassword) async {
    try {
      Response response = await Dio().put(
        "$baseUrl/user/updatePassword/${SocketProvider.current_user_id}",
        data: {
          "oldPassword": oldPassword,
          "newPassword": newPassword,
        },
      );
      if (response.statusCode == 200) {
        showSuccessDialog();
      }
    } catch (error) {
      print(error);
      showFailDialog();
    }
  }

  @override
  void initState() {
    super.initState();

    isPasswordVisibleOld = true;
    isPasswordVisibleNew = true;
    isPasswordVisibleRepeat = true;

    print('Init Update Password Page');
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
        elevation: 0.0,
        backgroundColor: ColorInPage.backgroudColor,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            alignment: Alignment.centerLeft,
            onPressed: () {
              print('Exit update password page');
              Navigator.pop(context);
            },
            icon: const Image(image: AssetImage('assets/images/arrow.png')),
          ),
        ));

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      // backgroundColor: Colors.green,
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Đổi mật khẩu',
              style: TextStyle(
                  color: Color(0xFF150A33),
                  fontSize: 20,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Mật khẩu cũ',
              style: TextStyle(
                  color: Color(0xFF150A33),
                  fontSize: 15,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
              cursorColor: ColorInPage.textColor,
              controller: controllerOld,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (text.length < 4) {
                  return 'Mật khẩu phải có ít nhất 4 kí tự';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: isPasswordVisibleOld
                      ? const Image(
                          color: Color(0xFF60778C),
                          width: 24,
                          height: 24,
                          image: AssetImage('assets/images/eyeOff.png'))
                      : const Image(
                          color: Color(0xFF60778C),
                          width: 24,
                          height: 24,
                          image: AssetImage('assets/images/eyeOn.png')),
                  onPressed: () => setState(
                      () => isPasswordVisibleOld = !isPasswordVisibleOld),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: isPasswordVisibleOld,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Mật khẩu mới',
              style: TextStyle(
                  color: Color(0xFF150A33),
                  fontSize: 15,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
              cursorColor: ColorInPage.textColor,
              controller: controllerNew,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (text.length < 4) {
                  return 'Mật khẩu phải có ít nhất 4 kí tự';
                }
                if (text != controllerRepeat.text) {
                  return 'Mật khẩu không khớp';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: isPasswordVisibleNew
                      ? const Image(
                          color: Color(0xFF60778C),
                          width: 24,
                          height: 24,
                          image: AssetImage('assets/images/eyeOff.png'))
                      : const Image(
                          color: Color(0xFF60778C),
                          width: 24,
                          height: 24,
                          image: AssetImage('assets/images/eyeOn.png')),
                  onPressed: () => setState(
                      () => isPasswordVisibleNew = !isPasswordVisibleNew),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: isPasswordVisibleNew,
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'Xác nhận mật khẩu',
              style: TextStyle(
                  color: Color(0xFF150A33),
                  fontSize: 15,
                  fontFamily: 'DMSans',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              style: const TextStyle(color: Color(0xFF524B6B), wordSpacing: 2),
              cursorColor: ColorInPage.textColor,
              controller: controllerRepeat,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (text) {
                if (text == null || text.isEmpty) {
                  return 'Vui lòng nhập mật khẩu';
                }
                if (text.length < 4) {
                  return 'Mật khẩu phải có ít nhất 4 kí tự';
                }
                return null;
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                suffixIcon: IconButton(
                  icon: isPasswordVisibleRepeat
                      ? const Image(
                          color: Color(0xFF60778C),
                          width: 24,
                          height: 24,
                          image: AssetImage('assets/images/eyeOff.png'))
                      : const Image(
                          color: Color(0xFF60778C),
                          width: 24,
                          height: 24,
                          image: AssetImage('assets/images/eyeOn.png')),
                  onPressed: () => setState(
                      () => isPasswordVisibleRepeat = !isPasswordVisibleRepeat),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              obscureText: isPasswordVisibleRepeat,
            ),
            !isLandscape
                ? const SizedBox(height: 200)
                : const SizedBox(height: 100),
            Center(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xFFEC1C24),
                      borderRadius: BorderRadius.circular(25)),
                  height: MediaQuery.sizeOf(context).height * 0.06,
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: const Center(
                    child: Text(
                      'THAY ĐỔI',
                      style: TextStyle(
                        //height: 26,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  print('${SocketProvider.current_user_id}');
                  if (_formKey.currentState!.validate()) {
                    updatePassword(controllerOld.text, controllerNew.text);
                  }
                },
              ),
            ),
          ]),
        ),
      )),
    );
  }
}
