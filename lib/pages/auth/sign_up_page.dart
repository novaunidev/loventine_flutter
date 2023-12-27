// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:loventine_flutter/main.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/providers/information_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:loventine_flutter/widgets/password_field/src/fancy_password_field.dart';
import 'package:loventine_flutter/widgets/password_field/src/validation_rule.dart';
import 'package:provider/provider.dart';

import '../../widgets/step_progress_indicator/src/step_progress_indicator.dart';

import '../../config.dart';

import 'verify_page.dart';
import '/modules/profile/services/otp.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirm = TextEditingController();
  bool isExistPhone = false;
  bool isExistEmail = false;
  bool isLoading = false;

  bool isPasswordVisibleOld = true;
  @override
  Widget build(BuildContext context) {
    Future<void> handleOnPressSignUp() async {
      try {
        final response = await Dio().post(urlUsers, data: {
          'email': email.text,
          'password': password.text,
          'passwordConfirm': passwordConfirm.text,
          'name': name.text,
          'avatarUrl': "https://www.pmc-kollum.nl/wp-content/uploads/2017/05/no_avatar.jpg"
        });
        Provider.of<InformationProvider>(context, listen: false).setIsSignUpTrue();
        // final extractedData = json.decode(response.body) as Map<String, dynamic>;
        // if (extractedData == null) {
        //   return;
        // }
        // print(response.statusCode);

        // if (response.statusCode == 200 || response.statusCode == 201) {
        //   await Future.delayed(const Duration(seconds: 1));
        //   if (!mounted) return;
        //   // Navigator.push(
        //   //   context,
        //   //   MaterialPageRoute(
        //   //     builder: (context) => const Login(),
        //   //   ),
        //   // );

        //   // appAuth.saveToken(response);
        // } else {
        //   print("Failed");
        // }
      } catch (e) {
        print(e);
      }
    }

    Future<void> handleOnPressLogin(String type) async {
      print("login");
      try {
        final response = await Dio().post("$urlUsers/loginWithEmail",
            data: {"email": email.text, "password": password.text});
        if (response.statusCode == 200) {
          var userInfo = response.data['user'];
          // await appSocket.init(extractedData["userid"], context);
          print(userInfo['_id']);
          await Provider.of<MessagePageProvider>(context, listen: false)
              .setCurrentUserId(userInfo['_id']);
          // String userId =
          //     await Provider.of<MessagePageProvider>(context, listen: false)
          //         .current_user_id;
          // //==>>>
          await Provider.of<MessagePageProvider>(context, listen: false)
              .initialize();
          // await Provider.of<UserImageProvider>(context, listen: false)
          //     .getAllUserImage(extractedData["userid"]);
          // String avatarUrl =
          //     await Provider.of<UserImageProvider>(context, listen: false).avatar;
          // //FCM
          // List<String> fcmTokens =
          //     await Provider.of<UserImageProvider>(context, listen: false)
          //         .fcmTokens;
          // if (!Platform.isWindows) {
          //   FirebaseFCM().addToken(userId, fcmTokens);
          // }
          // //
          // String avatarCloundinaryPublicId =
          //     await Provider.of<UserImageProvider>(context, listen: false)
          //         .avatar_cloudinary_public_id;
          // await Provider.of<MessagePageProvider>(context, listen: false)
          //     .setAvatarUrl(avatarUrl, avatarCloundinaryPublicId);
          // //==>
          // await Future.delayed(const Duration(seconds: 1));
          // // if (!mounted) return;

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainPage(
                currentIndex: 0,
              ),
            ),
          );
        } else {
          CustomSnackbar.show(context,
              type: SnackbarType.failure,
              title: "Vui lòng thử lại",
              message: "Sai số điện thoại & email hoặc mật khẩu");
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        print(e);
        CustomSnackbar.show(
          context,
          type: SnackbarType.failure,
          title: "Vui lòng thử lại",
        );
        setState(() {
          isLoading = false;
        });
      }
    }

    // checkPhone(String value) async {
    //   try {
    //     var response = await Dio().get("$baseUrl/auth/checkPhone/$value");
    //     if (response.statusCode == 200) {
    //       String message = response.data["message"];
    //       if (message == "Phone already exists") {
    //         if (mounted) {
    //           setState(() {
    //             isExistPhone = true;
    //           });
    //         }
    //       } else {
    //         if (mounted) {
    //           setState(() {
    //             isExistPhone = false;
    //           });
    //         }
    //       }
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // }

    // checkEmail(String value) async {
    //   String email = value;
    //   try {
    //     var response = await Dio().get("$baseUrl/auth/checkEmail/$email");
    //     if (response.statusCode == 200) {
    //       String message = response.data["message"];
    //       if (message == "Email already exists") {
    //         if (mounted) {
    //           setState(() {
    //             isExistEmail = true;
    //           });
    //         }
    //       } else {
    //         if (mounted) {
    //           setState(() {
    //             isExistEmail = false;
    //           });
    //         }
    //       }
    //     }
    //   } catch (e) {
    //     print(e);
    //   }
    // }

    final size = MediaQuery.sizeOf(context);
    //Thêm scaffoldKey để không gặp lỗi Floating SnackBar presented off screen
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: AppColor.textBlack,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                'assets/svgs/logo.svg',
                height: 100,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  'Đăng ký tài khoản',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 18,
                    fontFamily: 'Loventine-Bold',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                          cursorColor: AppColor.mainColor,
                          controller: name,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color(0xfff7f8f9),
                            hintText: 'Họ và tên',
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
                              return "Hãy điền họ và tên";
                            } else {
                              if (value.length > 40) {
                                return "Tối đa 40 kí tự!";
                              } else {
                                if (checkText(value)) {
                                  return "Văn bản chứa từ không phù hợp!";
                                } else {
                                  return null;
                                }
                              }
                            }
                          }),
                      const SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        controller: email,
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

                            if (value.isNotEmpty && !regex.hasMatch(value)) {
                              return "Nhập định dạng @gmail.com";
                            } else {
                              return null;
                            }
                          }
                        },
                      ),
                      //########### KHOAN LÀM DO CHƯA MUA SMS ##################
                      // SizedBox(
                      //   width: size.width * 0.9,
                      //   height: 60,
                      //   child: TextFormField(
                      //     controller: phone,
                      //     keyboardType: TextInputType.number,
                      //     textInputAction: TextInputAction.next,
                      //     decoration: const InputDecoration(
                      //       hintText: 'Số điện thoại',
                      //       prefixIcon: Icon(Icons.phone),
                      //       border: OutlineInputBorder(),
                      //     ),
                      //     validator: (value) {
                      //       if (email.text.isEmpty) {
                      //         if (value!.isEmpty) {
                      //           return "Điền số điện thoại!";
                      //         } else {
                      //           // Kiểm tra giá trị chỉ chứa các kí tự số
                      //           RegExp regex = RegExp(r'^[0-9]+$');
                      //           if (!regex.hasMatch(value)) {
                      //             return "Điền số điện thoại!";
                      //           } else {
                      //             return null;
                      //           }
                      //         }
                      //       } else {
                      //         RegExp regex = RegExp(r'^[0-9]+$');
                      //         if (!regex.hasMatch(value!) && value.isNotEmpty) {
                      //           return "Điền số điện thoại!";
                      //         } else {
                      //           return null;
                      //         }
                      //       }
                      //     },
                      //   ),
                      // ),
                      //###################################################################
                      //Start
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        // height: 150,
                        child: FancyPasswordField(
                          cursorColor: AppColor.mainColor,
                          controller: password,
                          obscureText: isPasswordVisibleOld,
                          style: const TextStyle(
                            fontFamily: 'Loventine-Regular',
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xfff7f8f9),
                            suffixIcon: IconButton(
                              icon: isPasswordVisibleOld
                                  ? SvgPicture.asset(
                                      "assets/svgs/eye-slash.svg",
                                      color: const Color(0xffc3cacf),
                                    )
                                  : SvgPicture.asset(
                                      "assets/svgs/eye.svg",
                                      color: const Color(0xffc3cacf),
                                    ),
                              onPressed: () => setState(() =>
                                  isPasswordVisibleOld = !isPasswordVisibleOld),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: 'Mật khẩu',
                            hintStyle: const TextStyle(
                              fontFamily: 'Loventine-Regular',
                              color: Color(0xff616161),
                            ),
                          ),
                          validationRules: {
                            MinCharactersValidationRule(8,
                                customText: "Có ít nhất 8 ký tự"),
                            UppercaseValidationRule(
                                customText: "Có chữ in hoa"),
                            LowercaseValidationRule(
                                customText: "Có chữ thường"),
                            DigitValidationRule(customText: "Có số"),
                            SpecialCharacterValidationRule(
                                customText: "Có ký tự đặt biệt"),
                          },
                          strengthIndicatorBuilder: (strength) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: StepProgressIndicator(
                                totalSteps: 8,
                                currentStep: getStep(strength),
                                selectedColor: getColor(strength)!,
                                unselectedColor: Colors.grey[300]!,
                              ),
                            );
                          },
                          validationRuleBuilder: (rules, value) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Wrap(
                                runSpacing: 8,
                                spacing: 4,
                                children: rules.map(
                                  (rule) {
                                    final ruleValidated = rule.validate(value);
                                    return Chip(
                                      label: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          if (ruleValidated) ...[
                                            const Icon(
                                              Icons.check,
                                              color: Color(0xFF0A9471),
                                            ),
                                            const SizedBox(width: 8),
                                          ],
                                          Text(
                                            rule.name,
                                            style: TextStyle(
                                              color: ruleValidated
                                                  ? const Color(0xFF0A9471)
                                                  : const Color(0xFF9A9FAF),
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: ruleValidated
                                          ? const Color(0xFFD0F7ED)
                                          : const Color(0xFFF4F5F6),
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                          },
                        ),
                      ),
                      //End
                      const SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 7, 15, 7),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: const TextStyle(
                              color: AppColor.blackColor,
                              fontSize: 11,
                              fontFamily: 'Loventine-Regular',
                            ),
                            children: <InlineSpan>[
                              const TextSpan(
                                text:
                                    'Bằng cách nhấp vào Đăng ký, bạn đồng ý với ',
                              ),
                              TextSpan(
                                text: 'Điều khoản',
                                style:
                                    const TextStyle(color: AppColor.mainColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Sự kiện khi bạn nhấp vào "Điều khoản"
                                  },
                              ),
                              const TextSpan(
                                text: ' và thừa nhận ',
                              ),
                              TextSpan(
                                text: 'Chính sách quyền riêng tư',
                                style:
                                    const TextStyle(color: AppColor.mainColor),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Sự kiện khi bạn nhấp vào "Chính sách quyền riêng tư"
                                  },
                              ),
                            ],
                          ),
                        ),
                      ),
                      ActionButton(
                        text: 'Đăng ký',
                        isChange: true,
                        width: size.width * 0.9,
                        isLoading: isLoading,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            handleOnPressSignUp().whenComplete(
                                () => handleOnPressLogin("email"));

                            // await checkEmail(email.text);
                            //===> await checkPhone(phone.text);
                            // if (email.text.isNotEmpty) {
                            //   if (isExistEmail && isExistPhone) {
                            //     CustomSnackbar.show(context,
                            //         type: SnackbarType.warning,
                            //         title: "Email và Số điện thoại đã tồn tại!",
                            //         message:
                            //             "Vui lòng điền email và số điện thoại khác");
                            //     setState(() {
                            //       isLoading = false;
                            //     });
                            //   } else if (isExistEmail) {
                            //     CustomSnackbar.show(context,
                            //         type: SnackbarType.warning,
                            //         title: "Email đã tồn tại!",
                            //         message: "Vui lòng điền email khác");
                            //     setState(() {
                            //       isLoading = false;
                            //     });
                            //   } else if (isExistPhone) {
                            //     CustomSnackbar.show(context,
                            //         type: SnackbarType.warning,
                            //         title: "Số điện thoại đã tồn tại!",
                            //         message:
                            //             "Vui lòng điền số điện thoại khác");
                            //     setState(() {
                            //       isLoading = false;
                            //     });
                            //   } else {
                            //     OTPService()
                            //         .sendOTPbyEmail(context, email.text)
                            //         .then((value) {
                            //       value == 200
                            //           ? Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) => VerifyPage(
                            //                         phoneNumber: phone.text,
                            //                         name: name.text,
                            //                         email: email.text,
                            //                         password: password.text,
                            //                         passwordConfirm:
                            //                             password.text,
                            //                         type: "signup",
                            //                       )),
                            //             )
                            //           : value == 429
                            //               ? {
                            //                   CustomSnackbar.show(context,
                            //                       type: SnackbarType.warning,
                            //                       title: "Cảnh báo",
                            //                       message:
                            //                           "Bạn đã gửi quá 5 Otp. Vui lòng quay lại sau một giờ"),
                            //                   setState(() {
                            //                     isLoading = false;
                            //                   })
                            //                 }
                            //               : {
                            //                   CustomSnackbar.show(context,
                            //                       type: SnackbarType.failure,
                            //                       title: "Lỗi",
                            //                       message:
                            //                           "Lỗi gửi Otp. Vui lòng thử lại sau"),
                            //                   setState(() {
                            //                     isLoading = false;
                            //                   })
                            //                 };
                            //     });
                            //   }
                            // } else {
                            //   if (isExistEmail && isExistPhone) {
                            //     CustomSnackbar.show(context,
                            //         type: SnackbarType.warning,
                            //         title: "Email và Số điện thoại đã tồn tại!",
                            //         message:
                            //             "Vui lòng điền email và số điện thoại khác");
                            //     setState(() {
                            //       isLoading = false;
                            //       isExistEmail = false;
                            //       isExistPhone = false;
                            //     });
                            //   } else if (isExistEmail) {
                            //     CustomSnackbar.show(context,
                            //         type: SnackbarType.warning,
                            //         title: "Email đã tồn tại!",
                            //         message: "Vui lòng điền email khác");
                            //     setState(() {
                            //       isLoading = false;
                            //       isExistEmail = false;
                            //       isExistPhone = false;
                            //     });
                            //   } else if (isExistPhone) {
                            //     CustomSnackbar.show(context,
                            //         type: SnackbarType.warning,
                            //         title: "Số điện thoại đã tồn tại!",
                            //         message:
                            //             "Vui lòng điền số điện thoại khác");
                            //     setState(() {
                            //       isLoading = false;
                            //       isExistEmail = false;
                            //       isExistPhone = false;
                            //     });
                            //   } else {
                            //     OTPService()
                            //         .sendOTPbyPhone(context, phone.text)
                            //         .then((value) {
                            //       value == 200
                            //           ? Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                   builder: (context) => VerifyPage(
                            //                         phoneNumber: phone.text,
                            //                         name: name.text,
                            //                         email: email.text,
                            //                         password: password.text,
                            //                         passwordConfirm:
                            //                             password.text,
                            //                         type: "signup",
                            //                       )),
                            //             )
                            //           : value == 429
                            //               ? {
                            //                   CustomSnackbar.show(context,
                            //                       type: SnackbarType.warning,
                            //                       title: "Cảnh báo",
                            //                       message:
                            //                           "Bạn đã gửi quá 5 Otp. Vui lòng quay lại sau một giờ"),
                            //                   setState(() {
                            //                     isLoading = false;
                            //                   }),
                            //                 }
                            //               : {
                            //                   CustomSnackbar.show(context,
                            //                       type: SnackbarType.failure,
                            //                       title: "Lỗi",
                            //                       message:
                            //                           "Lỗi gửi Otp. Vui lòng thử lại sau"),
                            //                   setState(() {
                            //                     isLoading = false;
                            //                   }),
                            //                 };
                            //     });
                            //   }
                            // }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () => Navigator.pop(context),
        child: const Text(
          'Bạn đã có tài khoản?',
          style: TextStyle(
            color: AppColor.mainColor,
            fontSize: 14,
            fontFamily: 'Loventine-Semibold',
          ),
        ),
      ),
    );
  }

  int getStep(double strength) {
    if (strength == 0) {
      return 0;
    } else if (strength < .1) {
      return 1;
    } else if (strength < .2) {
      return 2;
    } else if (strength < .3) {
      return 3;
    } else if (strength < .4) {
      return 4;
    } else if (strength < .5) {
      return 5;
    } else if (strength < .6) {
      return 6;
    } else if (strength < .7) {
      return 7;
    }
    return 8;
  }

  Color? getColor(double strength) {
    if (strength == 0) {
      return Colors.grey[300];
    } else if (strength < .1) {
      return Colors.red;
    } else if (strength < .2) {
      return Colors.red;
    } else if (strength < .3) {
      return Colors.yellow;
    } else if (strength < .4) {
      return Colors.yellow;
    } else if (strength < .5) {
      return Colors.yellow;
    } else if (strength < .6) {
      return Colors.green;
    } else if (strength < .7) {
      return Colors.green;
    }
    return Colors.green;
  }
}
