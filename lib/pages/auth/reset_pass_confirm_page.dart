import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loventine_flutter/widgets/bottom_sheet_login.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';

class ResetPassConfirm extends StatefulWidget {
  const ResetPassConfirm({Key? key}) : super(key: key);

  @override
  State<ResetPassConfirm> createState() => _ResetPassConfirmState();
}

class _ResetPassConfirmState extends State<ResetPassConfirm> {
  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(0, statusBarHeight, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                      alignment: Alignment.centerLeft,
                      onPressed: () {
                        showBottomSheetLogin(context, 2);
                      },
                      icon: Icon(Icons.close)),
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/svgs/logo_name.svg",
                          height: 30,
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.1),
                        Container(
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            child: const Image(
                                image: AssetImage(
                                    'assets/images/reset_pass_confirm.gif'))),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: const Text(
                            'Xác nhận',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: const Text(
                            'Mật khẩu của bạn đã được thay đổi. Vui lòng đăng nhập bằng mật khẩu mới của bạn.',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.2,
                        ),
                        ActionButton(
                            isChange: true,
                            onTap: () {
                              showBottomSheetLogin(context, 2);
                            },
                            text: 'Đăng nhập',
                            isLoading: false)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
