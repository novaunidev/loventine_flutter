import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import './delete_account.dart';
import './set_language.dart';
import './terms_of_service.dart';
import 'update_password.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF150B3D);
}

class RowContent {
  String iconLeadingURL;
  String content;
  Function itemFunction;

  RowContent(
      {required this.iconLeadingURL,
      required this.content,
      required this.itemFunction});
}

final allRowContent = [
  RowContent(
      iconLeadingURL: 'assets/images/notification.png',
      content: 'Thông báo',
      itemFunction: () {}),
  RowContent(
      iconLeadingURL: 'assets/images/Subtract.png',
      content: 'Chế độ ban đêm',
      itemFunction: () {}),
  RowContent(
      iconLeadingURL: 'assets/images/changepassword.png',
      content: 'Đổi mật khẩu',
      itemFunction: (ctxRoot) {
        print('Navigate to change password');
        Navigator.of(ctxRoot).push(
            MaterialPageRoute(builder: (context) => const UpdatePassword()));
      }),
  RowContent(
      iconLeadingURL: 'assets/images/language.png',
      content: 'Ngôn ngữ',
      itemFunction: (ctxRoot) {
        print('Navigate to change language');
        Navigator.of(ctxRoot)
            .push(MaterialPageRoute(builder: (context) => const SetLanguage()));
      }),
  RowContent(
      iconLeadingURL: 'assets/images/service.png',
      content: 'Điều khoản dịch vụ',
      itemFunction: (ctxRoot) {
        print('Navigate to rule services');
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            context: ctxRoot,
            builder: (ctx) => SizedBox(
                  height: (MediaQuery.of(ctxRoot).size.height -
                      MediaQuery.of(ctxRoot).padding.top),
                  child: const TermsOfService(),
                ));
      }),
  RowContent(
      iconLeadingURL: 'assets/images/centerhelp.png',
      content: 'Trung tâm trợ giúp',
      itemFunction: () {
        print('Navigate to help center');
      }),
  RowContent(
      iconLeadingURL: 'assets/images/contactsupport.png',
      content: 'Liên hệ support',
      itemFunction: () {
        print('Navigate to contact support');
      }),
  RowContent(
      iconLeadingURL: 'assets/images/introduce.png',
      content: 'Giới thiệu',
      itemFunction: () {
        print('Navigate to get introduce');
      }),
  RowContent(
      iconLeadingURL: 'assets/images/signout.png',
      content: 'Đăng xuất',
      itemFunction: () {
        print('Navigate to sign out');
      }),
  RowContent(
      iconLeadingURL: 'assets/images/delete_account.png',
      content: 'Xóa tài khoản',
      itemFunction: (ctxRoot) {
        print('Navigate to delete account');
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            barrierColor: const Color(0xFF2C373B).withOpacity(0.6),
            isScrollControlled: true,
            context: ctxRoot,
            builder: (ctx) => SizedBox(
                  height: !(MediaQuery.of(ctxRoot).orientation ==
                          Orientation.landscape)
                      ? (MediaQuery.of(ctxRoot).size.height -
                              MediaQuery.of(ctxRoot).padding.top) /
                          2
                      : (MediaQuery.of(ctxRoot).size.height -
                              MediaQuery.of(ctxRoot).padding.top) *
                          0.85,
                  child: const DeleteAccount(),
                ));

        // test reason for refusal in poster
        // showModalBottomSheet(
        //     backgroundColor: Colors.transparent,
        //     barrierColor: const Color(0xFF2C373B).withOpacity(0.6),
        //     isScrollControlled: true,
        //     context: ctxRoot,
        //     builder: (ctx) => SizedBox(
        //           height: !(MediaQuery.of(ctxRoot).orientation ==
        //                   Orientation.landscape)
        //               ? (MediaQuery.of(ctxRoot).size.height -
        //                       MediaQuery.of(ctxRoot).padding.top) *
        //                   0.7
        //               : (MediaQuery.of(ctxRoot).size.height -
        //                       MediaQuery.of(ctxRoot).padding.top) *
        //                   1,
        //           child: const ReasonForRefusalInPoster(),
        //         ));
      }),
];

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isNotification = true;

  bool isDarkMode = true;

  void changeNotification() {
    setState(() {
      isNotification = !isNotification;
    });
  }

  void changeDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  Widget itemSwitch(RowContent item, Widget flutterSwitch) {
    return ListTile(
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      leading: Image(image: AssetImage(item.iconLeadingURL)),
      title: Text(
        item.content,
        style: const TextStyle(
            color: ColorInPage.textColor,
            fontFamily: 'DMSans',
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
      trailing: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          height: 30,
          width: 30,
          child: FittedBox(child: flutterSwitch)),
    );
  }

  @override
  Widget build(BuildContext context) {
    //final mediaQuery = MediaQuery.of(context);
    //final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
      elevation: 0.0,
      backgroundColor: ColorInPage.backgroudColor,
      leading: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Image(
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Cài đặt',
        style: TextStyle(
            fontFamily: 'Poppins',
            color: ColorInPage.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
    );

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(children: [
          // row 1
          itemSwitch(
            allRowContent[0],
            FlutterSwitch(
                activeColor: const Color(0xFF56CD54),
                inactiveColor: const Color(0xFFE5E5E5),
                activeToggleColor: Colors.white,
                inactiveToggleColor: const Color(0xFF3D4859),
                value: isNotification,
                onToggle: ((value) => {changeNotification()})),
          ),
          const SizedBox(
            height: 8,
          ),
          // row 2
          itemSwitch(
            allRowContent[1],
            FlutterSwitch(
                activeColor: const Color(0xFF56CD54),
                inactiveColor: const Color(0xFFE5E5E5),
                activeToggleColor: Colors.white,
                inactiveToggleColor: const Color(0xFF3D4859),
                value: isDarkMode,
                onToggle: ((value) => {changeDarkMode()})),
          ),
          const SizedBox(
            height: 8,
          ),
          for (int i = 2; i < allRowContent.length; i++) ...[
            Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  leading:
                      Image(image: AssetImage(allRowContent[i].iconLeadingURL)),
                  title: Text(
                    allRowContent[i].content,
                    style: const TextStyle(
                        color: ColorInPage.textColor,
                        fontFamily: 'DMSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w400),
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                    child: IconButton(
                      onPressed: () {
                        allRowContent[i].itemFunction(context);
                      },
                      icon: const Image(
                          width: 8,
                          height: 16,
                          image: AssetImage('assets/images/Select.png')),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                )
              ],
            )
          ]
        ]),
      )),
    );
  }
}
