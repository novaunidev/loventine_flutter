// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:loventine_flutter/models/hives/count_app.dart';
import 'package:loventine_flutter/modules/post/delete_post_page.dart';
import 'package:loventine_flutter/modules/profile/pages/my_profile_page.dart';
import 'package:loventine_flutter/providers/page/message_page/user_image_provider.dart';
import 'package:loventine_flutter/services/firebase_fcm.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/bottom_sheet_identity_verify.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';
import '../main.dart';
import '../models/hives/userid.dart';
import '../pages/home/bookmark/bookmark_page.dart';
import '../pages/setting/help_center.dart';
import '../pages/user_post_free_page.dart';
import '../providers/app_socket.dart';
import '../providers/page/message_page/message_page_provider.dart';
import '/values/app_color.dart';
import '../pages/setting/settings.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import 'cupertino_bottom_sheet/src/material_with_modal_page_route.dart';
import 'custom_snackbar.dart';
import 'user_information/avatar_widget.dart';

class NavigationDrawerProfile extends StatelessWidget {
  final User? user;
  final String userId;

  const NavigationDrawerProfile({
    super.key,
    required this.user,
    required this.userId,
  });

  final padding = const EdgeInsets.symmetric(horizontal: 10);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.transparent,
          ),
          child: Drawer(
            elevation: 0,
            width: width * 0.78,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: padding,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.0465,
                        ),
                        Row(
                          children: [
                            const AvatarWidget(
                              size: 35,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${user?.name}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 23,
                                    color: Colors.black,
                                    fontFamily: "Loventine-Bold",
                                  ),
                                ),
                                if (user?.verified == true) ...[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        "Đã xác minh",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontFamily: "Loventine-Regular",
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0102,
                                      ),
                                      Image.asset(
                                        "assets/images/verified.png",
                                        height: 20,
                                      )
                                    ],
                                  ),
                                ] else ...[
                                  InkWell(
                                    onTap: () {
                                      if (Platform.isWindows) {
                                        buildWindowsModalBottomSheet(context);
                                      } else {
                                        showBottomSheetIdentityVerify(context);
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Chưa xác minh",
                                            style: AppText.contentSemibold(
                                                fontSize: 14,
                                                color: AppColor
                                                    .describetextcolor)),
                                        Image.asset(
                                          "assets/images/verified.png",
                                          height: 20,
                                          color: AppColor.deleteBubble,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Container(
                            padding: const EdgeInsets.all(10),
                            width: width,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: buildMenuItem(
                                      context,
                                      getMenuData(context),
                                      18,
                                      "Loventine-Bold"),
                                ),
                                const Divider(color: Colors.grey),
                                const Text(
                                  "Bài đăng và công việc",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Loventine-Black",
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                buildMenuItem(context, getMenuPostData(context),
                                    18, "Loventine-Bold"),
                                const Divider(color: Colors.grey),
                                const Text(
                                  "Cài đặt và hỗ trợ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Loventine-Black",
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                buildMenuItem(context, getSettingData(context),
                                    15, "Loventine-Semibold"),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMenuItem(BuildContext context, List<Map<String, dynamic>> data,
      double fontSize, String fontFamily) {
    return ListView.builder(
      itemCount: data.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () async {
            if (data[index]['title'] == "Xác minh") {
              if (Platform.isWindows) {
                buildWindowsModalBottomSheet(context);
              } else {
                showBottomSheetIdentityVerify(context);
              }
            }
            if (data[index]['title'] == "Đăng xuất") {
              CustomSnackbar.show(context,
                  title: '  Đang đăng xuất...', indicator: true);
              // var uri = Uri.parse('$urlAuthLogout/$userId');
              // Response res = await patch(uri);
              // appSocket.close();
              await Hive.box<CountApp>('countBox').clear();
              await Hive.box<UserId>('userBox').clear();
              await Provider.of<MessagePageProvider>(context, listen: false)
                  .initialize();
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              final FlutterSecureStorage _secureStorage =
                  FlutterSecureStorage();

              await _secureStorage.deleteAll();
              await prefs.remove('userId');
              await prefs.remove('deviceId');
              // await Provider.of<UserImageProvider>(context, listen: false)
              //     .getAllUserImage(userId);
              List<String> fcmTokens =
                  await Provider.of<UserImageProvider>(context, listen: false)
                      .fcmTokens;
              // if (!Platform.isWindows && !Platform.isIOS) {
              //   await FirebaseFCM().removeToken(userId, fcmTokens);
              // }
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
            if (data[index]['title'] == "Đăng xuất") {
              Navigator.pushReplacement(
                context,
                MaterialWithModalsPageRoute(
                    builder: (context) => data[index]['page']),
              );
            } else if (data[index]['page'] != Null) {
              Navigator.push(
                context,
                MaterialWithModalsPageRoute(
                    builder: (context) => data[index]['page']),
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: <Widget>[
                data[index]['icon'],
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    data[index]['title'],
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: fontFamily,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> getMenuData(BuildContext context) {
    return [
      {
        'icon': SvgPicture.asset(
          "assets/svgs/profile.svg",
          height: 23,
          color: Colors.black,
        ),
        'title': "Hồ sơ",
        'page': MyProfilePage(
          isMe: true,
          userId: userId,
          avatar: "",
        ),
      },
      {
        'icon': SvgPicture.asset(
          "assets/svgs/verify.svg",
          height: 23,
          color: Colors.black,
        ),
        'title': "Xác minh",
        'page': Null,
      },
    ];
  }

  List<Map<String, dynamic>> getMenuPostData(BuildContext context) {
    return [
      {
        'icon': SvgPicture.asset(
          "assets/svgs/profile-2user.svg",
          height: 23,
          color: Colors.black,
        ),
        'title': "Post cộng đồng",
        'page': const UserPostFree(),
      },
      {
        'icon': SvgPicture.asset(
          "assets/svgs/archive-tick.svg",
          height: 23,
          color: Colors.black,
        ),
        'title': "Đã lưu",
        'page': BookmarkPage(
          userName: user!.name,
        ),
      },
      {
        'icon': SvgPicture.asset(
          "assets/svgs/trash.svg",
          height: 23,
          color: Colors.black,
        ),
        'title': "Đã xóa",
        'page': DeletePostPage(userId: userId),
      },
    ];
  }

  List<Map<String, dynamic>> getSettingData(BuildContext context) {
    return [
      {
        'icon': SvgPicture.asset(
          "assets/svgs/setting-2.svg",
          height: 20,
          color: Colors.black,
        ),
        'title': "Cài đặt",
        'page': const Settings(),
      },
      {
        'icon': SvgPicture.asset(
          "assets/svgs/message-question.svg",
          height: 20,
          color: Colors.black,
        ),
        'title': "Trung tâm trợ giúp",
        'page': const HelpCenter(),
      },
      {
        'icon': SvgPicture.asset(
          "assets/svgs/logout-1.svg",
          height: 25,
          color: Colors.red,
        ),
        'title': "Đăng xuất",
        'page': AppLifecycleObserver(
          child: const MainPage(currentIndex: 0),
        ),
      },
    ];
  }
}
