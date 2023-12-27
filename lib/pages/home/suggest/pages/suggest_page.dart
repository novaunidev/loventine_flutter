import 'package:flutter/material.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import '../models/user.dart';
import '../utils/utils.dart';
import '../widgets/app_tile.dart';
import '../widgets/revolving_user_widget.dart';
import '../widgets/user_avatar.dart';
import '../widgets/user_info_card.dart';

class SuggestPage extends StatelessWidget {
  const SuggestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      //bottom: Platform.isAndroid ? true : false,
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            verticalSpace(60),
            Text(
              "Gợi ý kết bạn",
              style: AppText.titleHeader(fontSize: 30),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: 20.0, vertical: 20.0),
            //   child: UserInfoCard(size: size),
            // ),

            verticalSpace(16),
            Align(
              alignment: Alignment.bottomCenter,
              child: Transform(
                origin: Offset(0, size.width + 50),
                transform: Matrix4.skew(0.2, 0.3),
                alignment: FractionalOffset.bottomRight,
                child: const RevolvingUserWidget(),
              ),
            ),
            Text(
              "Hiện có 30 user tương hợp với bạn",
              style: AppText.contentRegular(color: AppColor.describetextcolor),
            ),
            verticalSpace(8),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AppTile(
                  label: "Nhắn tin",
                  message: "chat",
                  lottieAssetPath: "assets/lotties/chat_su.json",
                ),
                AppTile(
                  label: "Trang cá nhân",
                  message: "Request from ",
                  lottieAssetPath: "assets/lotties/profile.json",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
