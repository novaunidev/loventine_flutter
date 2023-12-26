import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:provider/provider.dart';
import '/modules/profile/services/controller.dart';

class BottomSheetWidget extends StatefulWidget {
  final Function(String) snack;
  const BottomSheetWidget({super.key, required this.snack});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  final ProfileController profilerController = Get.put(ProfileController());
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  Widget build(BuildContext context) {
    String idAvatar = Provider.of<MessagePageProvider>(context, listen: false)
        .avatar_cloundinary_public_id;
    String userID = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
    final MessagePageProvider messagePageProvider =
        Provider.of<MessagePageProvider>(context, listen: false);
    return GetMaterialApp(
      scaffoldMessengerKey: _scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            ListTile(
              leading: SvgPicture.asset("assets/svgs/camera_bl.svg"),
              title: Text(
                'Chụp ảnh từ camera',
                style: AppText.contentRegular(),
              ),
              onTap: () async {
                Navigator.pop(context);
                await profilerController
                    .uploadImage(ImageSource.camera, idAvatar, context, userID,
                        messagePageProvider)
                    .then((value) => {widget.snack(value)});
              },
            ),
            ListTile(
              leading: SvgPicture.asset("assets/svgs/gallery-import_bl.svg"),
              title: Text(
                'Chọn ảnh từ thư viện',
                style: AppText.contentRegular(),
              ),
              onTap: () async {
                Navigator.pop(context);
                await profilerController
                    .uploadImage(ImageSource.gallery, idAvatar, context, userID,
                        messagePageProvider)
                    .then((value) => {widget.snack(value)});
              },
            )
          ],
        ),
      ),
    );
  }
}
