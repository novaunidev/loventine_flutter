// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import 'package:loventine_flutter/pages/auth/forget_password_page.dart';
import 'package:loventine_flutter/providers/app_socket.dart';
import 'package:loventine_flutter/providers/page/message_page/card_profile_provider.dart';
import 'package:loventine_flutter/services/firebase_fcm.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../animation/type_writer_effect.dart';
import '../main.dart';
import '../pages/auth/sign_up_page.dart';
import '../providers/page/message_page/message_page_provider.dart';
import '../providers/page/message_page/user_image_provider.dart';
import '../values/app_color.dart';
import 'custom_snackbar.dart';

void showBottomSheetLogin(BuildContext context, int page) {
  const double _pagePadding = 20;
  final pageIndexNotifier = page == 1 ? ValueNotifier(0) : ValueNotifier(1);

  Size padding = MediaQuery.sizeOf(context);

  Widget buildRow(
      String imageAsset, String title, String subtitle, Color color) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              imageAsset,
              height: 35,
              color: color,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Bold",
                        color: Color(0xff020202)),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: Color(0xff020202)),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(_pagePadding),
        child: ActionButton(
          text: 'Đăng nhập',
          isChange: true,
          width: padding.width * 0.9,
          isLoading: false,
          onTap: () {
            pageIndexNotifier.value = pageIndexNotifier.value + 1;
          },
        ),
      ),
      pageTitle: Column(
        children: [
          const TypeWriterTextEffect(
            text: "Chào mừng đến với",
          ),
          SvgPicture.asset(
            'assets/svgs/logo_name.svg',
            height: 35,
          ),
        ],
      ),
      isTopBarVisibleWhenScrolled: false,
      forceMaxHeight: true,
      heroImage: const SizedBox(),
      heroImageHeight: 5,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(_pagePadding, 0, _pagePadding, 0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/onboarding2.png',
                height: 190,
              ),
              buildRow(
                  "assets/svgs/sad_ob.svg",
                  "Gặp vấn đề chuyện tình cảm",
                  "Bạn đăng bài và chờ những người giàu kinh nghiệm đến tư vấn cho bạn",
                  AppColor.iconColor),
              buildRow(
                  "assets/svgs/couple_ob.svg",
                  "Có nhiều kinh nghiệm",
                  "Chúng tôi sẽ kết nối với những người đang cần bạn tư vấn",
                  AppColor.mainColor),
              buildRow(
                  "assets/svgs/messages.svg",
                  "Hẹn hò kết bạn",
                  "Thỏa sức hẹn hò tìm đối tượng để kết bạn hoàn toàn miễn phí",
                  AppColor.chatBubble),
            ],
          )),
    );
  }

  WoltModalSheetPage page2(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      heroImage: SizedBox(),
      heroImageHeight: 20,
      isTopBarVisibleWhenScrolled: false,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(_pagePadding, 0, _pagePadding, 0),
          child: Column(
            children: [
              Image.asset(
                'assets/images/logo_sign.png',
                height: 110,
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Rất vui khi bạn đã trở lại🥰',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColor.blackColor,
                    fontSize: 17,
                    fontFamily: 'Loventine-Bold',
                  ),
                ),
              ),
              TextFieldAndLoginInBottomSheetLogin(),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Forget_pass(
                              type: 'user',
                            )),
                  );
                },
                child: const Text(
                  'Quên mật khẩu?',
                  style: TextStyle(
                    fontFamily: 'Loventine-Semibold',
                    color: AppColor.mainColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ActionButton(
                text: 'Đăng ký',
                isChange: true,
                width: padding.width * 0.9,
                colorButtontl: AppColor.blackColor,
                colorButtonbr: AppColor.blackColor,
                isLoading: false,
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Công Ty TNHH Phần Mềm NOVA UNIVERSE',
                style: TextStyle(
                  fontFamily: 'Loventine-Regular',
                  color: AppColor.deleteBubble,
                  fontSize: 11,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  WoltModalSheet.show<void>(
    pageIndexNotifier: pageIndexNotifier,
    context: context,
    pageListBuilder: (modalSheetContext) {
      final textTheme = Theme.of(context).textTheme;
      return [
        page1(modalSheetContext, textTheme),
        page2(modalSheetContext, textTheme),
      ];
    },
    onModalDismissedWithBarrierTap: () {
      Navigator.of(context).pop();
    },
    minPageHeight: 0.4,
    maxPageHeight: 0.95,
  );
}

class TextFieldAndLoginInBottomSheetLogin extends StatefulWidget {
  const TextFieldAndLoginInBottomSheetLogin({super.key});

  @override
  State<TextFieldAndLoginInBottomSheetLogin> createState() =>
      _TextFieldAndLoginInBottomSheetLoginState();
}

class _TextFieldAndLoginInBottomSheetLoginState
    extends State<TextFieldAndLoginInBottomSheetLogin> {
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool isPasswordVisibleOld = true;
  late bool isLoading = false;

  void handleOnPressLogin(String type) async {
    try {
      if (isLoading) return;
      setState(() {
        isLoading = true;
      });
      print("$urlUsers/loginWithEmail");
      print(phone.text);
      print(password.text);
      final response = await Dio().post("$urlUsers/loginWithEmail", data: {
        "email": phone.text,
        "password": password.text
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        var userInfo = response.data['user'];   
        // await appSocket.init(extractedData["userid"], context);
        print(userInfo['_id']);
        await Provider.of<MessagePageProvider>(context, listen: false)
            .setCurrentUserId(userInfo['_id']);
        await Provider.of<CardProfileProvider>(context, listen: false)
          .fetchCurrentUser(userInfo['_id']);    
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

  @override
  Widget build(BuildContext context) {
    Size padding = MediaQuery.sizeOf(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final mediaHeight = !isLandscape
        ? MediaQuery.sizeOf(context).height
        : MediaQuery.sizeOf(context).height * 2;
    return Column(
      children: [
        Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: mediaHeight * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: TextFormField(
            controller: phone,
            cursorColor: AppColor.mainColor,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xfff7f8f9),
              hintText: 'Email',
              hintStyle: TextStyle(
                fontFamily: 'Loventine-Regular',
                color: Color(0xff616161),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20), //<-- ADD THIS
              ),
            ),
            style: const TextStyle(
              fontFamily: 'Loventine-Regular',
              color: Colors.black,
            ),
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return "Điền số điện thoại hoặc email vào!";
            //   } else {
            //     const phonePattern = r'^[0-9]+$';
            //     const emailPattern = r'^.+@gmail\.com$';
            //     if (RegExp(phonePattern).hasMatch(phone.text)) {
            //       return null;
            //     } else if (RegExp(emailPattern).hasMatch(phone.text)) {
            //       return null;
            //     } else {
            //       return "Điền số điện thoại hoặc email vào!";
            //     }
            //   }
            // },
            // onTapOutside: (event) {},
          ),
        ),
        Container(
          height: 10,
        ),
        Container(
          width: MediaQuery.sizeOf(context).width * 0.9,
          height: mediaHeight * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            shape: BoxShape.rectangle,
          ),
          child: TextFormField(
            controller: password,
            obscureText: isPasswordVisibleOld,
            textInputAction: TextInputAction.done,
            cursorColor: AppColor.mainColor,
            style: const TextStyle(
              fontFamily: 'Loventine-Regular',
              color: Colors.black,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xfff7f8f9),
              hintText: 'Mật khẩu',
              hintStyle: const TextStyle(
                fontFamily: 'Loventine-Regular',
                color: Color(0xff616161),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20), //<-- ADD THIS
              ),
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
                onPressed: () => setState(
                    () => isPasswordVisibleOld = !isPasswordVisibleOld),
              ),
            ),
            // validator: (value) {
            //   if (value!.isEmpty) {
            //     return "Điền mật khẩu!";
            //   } else {
            //     return null;
            //   }
            // },
          ),
        ),
        Container(
          height: 20,
        ),
        ActionButton(
          text: 'Đăng nhập',
          isChange: true,
          width: padding.width * 0.9,
          isLoading: isLoading,
          onTap: () async {
            // const phonePattern = r'^[0-9]+$';
            // const emailPattern = r'^.+@gmail\.com$';
            // if (RegExp(phonePattern).hasMatch(phone.text)) {
            //   handleOnPressLogin("phone");
            //   print("phone");
            // } else if (RegExp(emailPattern).hasMatch(phone.text)) {
            //   handleOnPressLogin("email");
            //   print("email");
            // } else {
            //   CustomSnackbar.show(context,
            //       type: SnackbarType.failure,
            //       title: "Vui lòng thử lại",
            //       message: "Sai số điện thoại & email hoặc mật khẩu");
            //   isLoading = false;
            // }
            handleOnPressLogin('email');
          },
        ),
      ],
    );
  }
}
