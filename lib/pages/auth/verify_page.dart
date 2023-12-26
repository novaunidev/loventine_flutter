// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unnecessary_null_comparison
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'package:loventine_flutter/providers/app_socket.dart';
import 'package:loventine_flutter/providers/information_provider.dart';
import 'package:loventine_flutter/services/firebase_fcm.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../providers/page/message_page/message_page_provider.dart';
import '../../providers/page/message_page/user_image_provider.dart';
import '../../widgets/shimmer_simple.dart';
import './reset_pass_page.dart';

import '../../config.dart';
import '/modules/profile/services/otp.dart';
import '../../modules/auth/app_auth.dart';

class VerifyPage extends StatefulWidget {
  String? phoneNumber;
  String? name;
  final String email;
  String? password;
  String? passwordConfirm;
  final String type;
  VerifyPage(
      {Key? key,
      this.phoneNumber,
      required this.email,
      this.name,
      this.password,
      this.passwordConfirm,
      required this.type})
      : super(key: key);

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  int _remainingTime = 60;
  Timer? _timer;
  bool verifyOTP = true;
  bool isComplete = false;
  bool isLoading = false;
  final pinController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 60,
    height: 64,
    textStyle: const TextStyle(
      fontSize: 20,
      color: Color.fromRGBO(70, 69, 66, 1),
    ),
    decoration: BoxDecoration(
      color: const Color.fromRGBO(232, 235, 241, 0.37),
      borderRadius: BorderRadius.circular(24),
    ),
  );
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  Future<void> _validate(String value) async {
    bool success;
    if (widget.email.isNotEmpty) {
      success = await OTPService().verifyOTPbyEmail(widget.email, value);
    } else {
      success = await OTPService().verifyOTPbyPhone(widget.phoneNumber!, value);
    }

    final type = widget.phoneNumber!.isNotEmpty ? "phone" : "email";
    if (success) {
      if (widget.type == "signup") {
        await handleOnPressSignUp();
        handleOnPressLogin(type);
        // ignore: use_build_context_synchronously
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const Login()),
        // );
      } else if (widget.type == "update") {
        Navigator.pop(context, success);
      } else if (widget.type == "wallet") {
        // ignore: use_build_context_synchronously
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ResetPass(
                    email: widget.email,
                  )),
        );
      }
    } else {
      setState(() {
        verifyOTP = success;
        isComplete = true;
      });
    }
  }

  Future<void> handleOnPressSignUp() async {
    try {
      Response response = await post(Uri.parse(urlSignUp), body: {
        'email': widget.email.isEmpty ? "" : "${widget.email}",
        'phone': widget.phoneNumber!.isEmpty ? "" : widget.phoneNumber,
        'password': widget.password,
        'passwordConfirm': widget.passwordConfirm,
        'name': widget.name
      });
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }

      if (response.statusCode == 200) {
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => const Login(),
        //   ),
        // );

        appAuth.saveToken(response);
      } else {
        print("Failed");
      }
    } catch (e) {
      print(e);
    }
  }

  void handleOnPressLogin(String type) async {
    try {
      // if (_isLoading) return;
      setState(() {
        isLoading = true;
      });
      Response response = type == "phone"
          ? await post(
              Uri.parse(urlLoginwithPhone),
              body: {'phone': widget.phoneNumber, 'password': widget.password},
            )
          : await post(
              Uri.parse(urlLoginwithEmail),
              body: {'email': '${widget.email}', 'password': widget.password},
            );

      if (response.statusCode == 200) {
        final extractedData =
            json.decode(response.body) as Map<String, dynamic>;
        if (extractedData == null) {
          return;
        }

        await appSocket.init(extractedData["userid"], context);
        await Provider.of<MessagePageProvider>(context, listen: false)
            .setCurrentUserId(extractedData["userid"]);
        await Provider.of<MessagePageProvider>(context, listen: false)
            .initialize();
        //==>>>
        await Provider.of<UserImageProvider>(context, listen: false)
            .getAllUserImage(extractedData["userid"]);
        String avatarUrl =
            await Provider.of<UserImageProvider>(context, listen: false).avatar;
        String avatarCloundinaryPublicId =
            await Provider.of<UserImageProvider>(context, listen: false)
                .avatar_cloudinary_public_id;
        await Provider.of<MessagePageProvider>(context, listen: false)
            .setAvatarUrl(avatarUrl, avatarCloundinaryPublicId);
        await Provider.of<InformationProvider>(context, listen: false)
            .setIsSignUpTrue();
        String userId =
            await Provider.of<MessagePageProvider>(context, listen: false)
                .current_user_id;
        List<String> fcmTokens =
            await Provider.of<UserImageProvider>(context, listen: false)
                .fcmTokens;
        if (!Platform.isWindows) {
          FirebaseFCM().addToken(userId, fcmTokens);
        }
        //==>
        await Future.delayed(const Duration(seconds: 1));
        if (!mounted) return;

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
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    //
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.sizeOf(context).height
        : MediaQuery.sizeOf(context).height * 1.2;
    return Scaffold(
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
      body: isLoading
          ? ShimmerSimple()
          : SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(children: <Widget>[
                        Column(
                          children: <Widget>[
                            SizedBox(height: mediaHeight * 0.04),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: Text(
                                widget.email.isNotEmpty
                                    ? 'Nhập mã xác minh từ email của bạn'
                                    : 'Nhập mã xác minh từ số điện thoại của bạn',
                                style: const TextStyle(
                                  color: AppColor.blackColor,
                                  fontSize: 26,
                                  fontFamily: 'Loventine-Black',
                                ),
                              ),
                            ),
                            SizedBox(height: mediaHeight * 0.02),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Pinput(
                                // enabled: verifyOTP && isComplete ? false : true,
                                controller: pinController,
                                length: 5,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                defaultPinTheme: defaultPinTheme,
                                // separatorBuilder: (index) => const SizedBox(width: 16),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(
                                            0, 0, 0, 0.05999999865889549),
                                        offset: Offset(0, 3),
                                        blurRadius: 16,
                                      )
                                    ],
                                  ),
                                ),
                                forceErrorState:
                                    verifyOTP == false && isComplete,
                                onChanged: (value) {
                                  setState(() {
                                    isComplete = false;
                                  });
                                },
                                onCompleted: _validate,
                                errorPinTheme: defaultPinTheme.copyBorderWith(
                                  border: Border.all(color: Colors.redAccent),
                                ),
                                cursor: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: 21,
                                    height: 1,
                                    margin: const EdgeInsets.only(bottom: 12),
                                    decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          137, 146, 160, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            verifyOTP == false && isComplete
                                ? const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      "Mã xác nhận không đúng",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 15,
                                        fontFamily: 'Loventine-Semibold',
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: mediaHeight * 0.05,
                            ),
                            _remainingTime == 0
                                ? TextButton(
                                    onPressed: () {
                                      _timer?.cancel();
                                      setState(() {
                                        _remainingTime = 60;
                                      });
                                      _startTimer();
                                      if (widget.email.isNotEmpty) {
                                        OTPService()
                                            .sendOTPbyEmail(
                                                context, widget.email)
                                            .then((value) {
                                          value == 200
                                              ? {}
                                              : value == 429
                                                  ? {
                                                      Navigator.pop(context),
                                                      CustomSnackbar.show(
                                                          context,
                                                          type: SnackbarType
                                                              .warning,
                                                          title: "Cảnh báo",
                                                          message:
                                                              "Bạn đã gửi quá 5 Otp. Vui lòng quay lại sau một giờ"),
                                                    }
                                                  : {
                                                      Navigator.pop(context),
                                                      CustomSnackbar.show(
                                                          context,
                                                          type: SnackbarType
                                                              .failure,
                                                          title: "Lỗi",
                                                          message:
                                                              "Lỗi gửi Otp. Vui lòng thử lại sau"),
                                                    };
                                        });
                                      } else {
                                        OTPService()
                                            .sendOTPbyPhone(
                                                context, widget.phoneNumber!)
                                            .then((value) {
                                          value == 200
                                              ? {}
                                              : value == 429
                                                  ? {
                                                      Navigator.pop(context),
                                                      CustomSnackbar.show(
                                                          context,
                                                          type: SnackbarType
                                                              .warning,
                                                          title: "Cảnh báo",
                                                          message:
                                                              "Bạn đã gửi quá 5 Otp. Vui lòng quay lại sau một giờ"),
                                                    }
                                                  : {
                                                      Navigator.pop(context),
                                                      CustomSnackbar.show(
                                                          context,
                                                          type: SnackbarType
                                                              .failure,
                                                          title: "Lỗi",
                                                          message:
                                                              "Lỗi gửi Otp. Vui lòng thử lại sau"),
                                                    };
                                        });
                                      }
                                    },
                                    child: const Text(
                                      "Gửi lại",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: AppColor.mainColor,
                                        fontSize: 15,
                                        fontFamily: 'Loventine-Bold',
                                      ),
                                    ))
                                : Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Bạn không nhận đã mã xác minh?\nGửi lại sau $_remainingTime giây",
                                          style: const TextStyle(
                                            color: AppColor.blackColor,
                                            fontSize: 15,
                                            fontFamily: 'Loventine-Semibold',
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                          ],
                        ),
                      ])
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
