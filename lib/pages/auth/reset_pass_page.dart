import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import '../../config.dart';
import './reset_pass_confirm_page.dart';

class ResetPass extends StatefulWidget {
  final String email;
  const ResetPass({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {
  bool isPasswordVisibleOld = false;
  TextEditingController newPassword = TextEditingController();
  TextEditingController newPasswordConfirm = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  Future<void> resetPass() async {
    try {
      final resetPass = await Dio().put('$baseUrl/user/resetpassword',
          data: {'email': widget.email, 'password': newPassword.text});
      if (resetPass.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResetPassConfirm()),
        );
      } else {
        print('Failed to reset pass');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.sizeOf(context).height
        : MediaQuery.sizeOf(context).height * 1.2;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back_ios)),
                      ),
                      Center(
                        child: Column(
                          children: <Widget>[
                            SvgPicture.asset(
                              "assets/svgs/logo_name.svg",
                              height: 30,
                            ),
                            SizedBox(height: mediaHeight * 0.04),
                            Text('Đặt lại mật khẩu',
                                style: AppText.contentSemibold(fontSize: 24)),
                            SizedBox(height: mediaHeight * 0.01),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              child: const Text(
                                'Nhập mật khẩu mới của bạn và xác nhận mật khẩu mới để đặt lại mật khẩu',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Form(
                              key: _formKey,
                              child: SizedBox(
                                height: mediaHeight * 0.25,
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      height: mediaHeight * 0.1,
                                      child: TextFormField(
                                        controller: newPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return "Hãy điền mật khẩu";
                                          } else if (value !=
                                              newPasswordConfirm.text) {
                                            return 'Mật khẩu không khớp';
                                          } else {
                                            return null;
                                          }
                                        },
                                        obscureText: isPasswordVisibleOld,
                                        textInputAction: TextInputAction.next,
                                        decoration: InputDecoration(
                                            hintText: 'Mật khẩu mới',
                                            prefixIcon: Icon(Icons.key),
                                            suffixIcon: IconButton(
                                              icon: isPasswordVisibleOld
                                                  ? const Image(
                                                      color: Color(0xFF60778C),
                                                      width: 24,
                                                      height: 24,
                                                      image: AssetImage(
                                                          'assets/images/eyeOff.png'))
                                                  : const Image(
                                                      color: Color(0xFF60778C),
                                                      width: 24,
                                                      height: 24,
                                                      image: AssetImage(
                                                          'assets/images/eyeOn.png')),
                                              onPressed: () => setState(() =>
                                                  isPasswordVisibleOld =
                                                      !isPasswordVisibleOld),
                                            ),
                                            border: OutlineInputBorder()),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        height: mediaHeight * 0.1,
                                        child: TextFormField(
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return "Hãy điền mật khẩu";
                                            } else if (value !=
                                                newPasswordConfirm.text) {
                                              return 'Mật khẩu không khớp';
                                            } else {
                                              return null;
                                            }
                                          },
                                          controller: newPasswordConfirm,
                                          obscureText: isPasswordVisibleOld,
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                              hintText: 'Xác nhận mật khẩu mới',
                                              prefixIcon: Icon(Icons.key),
                                              suffixIcon: IconButton(
                                                icon: isPasswordVisibleOld
                                                    ? const Image(
                                                        color:
                                                            Color(0xFF60778C),
                                                        width: 24,
                                                        height: 24,
                                                        image: AssetImage(
                                                            'assets/images/eyeOff.png'))
                                                    : const Image(
                                                        color:
                                                            Color(0xFF60778C),
                                                        width: 24,
                                                        height: 24,
                                                        image: AssetImage(
                                                            'assets/images/eyeOn.png')),
                                                onPressed: () => setState(() =>
                                                    isPasswordVisibleOld =
                                                        !isPasswordVisibleOld),
                                              ),
                                              border: OutlineInputBorder()),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            ActionButton(
                                isChange: true,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    resetPass();
                                  }
                                },
                                text: 'Đặt lại mật khẩu',
                                isLoading: isLoading)
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
