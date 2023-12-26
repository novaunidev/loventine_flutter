// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/modules/profile/services/otp.dart';
import 'package:loventine_flutter/pages/auth/verify_page.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';

class Forget_pass extends StatefulWidget {
  final String type;
  const Forget_pass({Key? key, required this.type}) : super(key: key);

  @override
  State<Forget_pass> createState() => _Forget_passState();
}

class _Forget_passState extends State<Forget_pass>
    with SingleTickerProviderStateMixin {
  TextEditingController emailInputField = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.sizeOf(context).height
        : MediaQuery.sizeOf(context).height * 2;

    // handle status bar
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      //color set to transperent or set your own color
      statusBarIconBrightness: Brightness.dark,
      //set brightness for icons, like dark background light icons
    ));

    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    Future<bool> checkEmail(String value) async {
      try {
        var response = await Dio().get("$baseUrl/auth/checkEmail/$value");
        if (response.statusCode == 200) {
          String message = response.data["message"];
          if (message == "Email already exists") {
            if (mounted) {
              return true;
            }
          } else {
            if (mounted) {
              return false;
            }
          }
        }
      } catch (e) {
        print(e);
        return false;
      }
      return false;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
                child: Column(
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
                          icon: const Icon(Icons.arrow_back_ios)),
                    ),
                    SvgPicture.asset(
                      'assets/svgs/logo.svg',
                      height: 100,
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    Text(
                      widget.type == 'user'
                          ? 'Quên mật khẩu'
                          : 'Quên mật khẩu Ví LoviserPay',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      child: const Text(
                        'Nhập email của bạn, chúng tôi sẽ gửi cho bạn mã xác minh',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: mediaHeight * 0.04),
                    Image.asset('assets/images/forget_icon.gif',
                        width: 150, height: 120),
                    SizedBox(height: mediaHeight * 0.04),
                    Form(
                      key: _formKey,
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: emailInputField,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          cursorColor: AppColor.mainColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff7f8f9),
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              fontFamily: 'Loventine-Regular',
                              color: Color(0xff616161),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          style: const TextStyle(
                            fontFamily: 'Loventine-Regular',
                            color: Colors.black,
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Điền email!";
                            } else {
                              RegExp regex = RegExp(r'^[^ ]+@gmail\.com$');

                              if (!regex.hasMatch(value)) {
                                return "Nhập định dạng @gmail.com";
                              } else {
                                return null;
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ActionButton(
                        isChange: true,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            final isExistEmail =
                                await checkEmail(emailInputField.text);
                            if (isExistEmail) {
                              OTPService()
                                  .sendOTPbyEmail(context, emailInputField.text)
                                  .then((value) {
                                value == 200
                                    ? widget.type == "wallet"
                                        ? Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerifyPage(
                                                      phoneNumber: "",
                                                      email:
                                                          emailInputField.text,
                                                      type: "wallet",
                                                    )),
                                          )
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    VerifyPage(
                                                      phoneNumber: "",
                                                      email:
                                                          emailInputField.text,
                                                      type: "forget",
                                                    )),
                                          )
                                    : value == 429
                                        ? {
                                            CustomSnackbar.show(context,
                                                type: SnackbarType.warning,
                                                title: "Cảnh báo",
                                                message:
                                                    "Bạn đã gửi quá 5 Otp. Vui lòng quay lại sau một giờ"),
                                            setState(() {
                                              isLoading = false;
                                            })
                                          }
                                        : {
                                            CustomSnackbar.show(context,
                                                type: SnackbarType.failure,
                                                title: "Lỗi",
                                                message:
                                                    "Lỗi gửi Otp. Vui lòng thử lại sau"),
                                            setState(() {
                                              isLoading = false;
                                            })
                                          };
                              });
                            } else {
                              CustomSnackbar.show(context,
                                  type: SnackbarType.warning,
                                  title: "Email không tồn tại!",
                                  message: "Vui lòng điền email khác");
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        text: "Gửi mã xác minh",
                        isLoading: isLoading)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
