import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:loventine_flutter/widgets/cupertino_bottom_sheet/src/material_with_modal_page_route.dart';
import 'ios_page_route.dart';

//==== Example
//  appNavigate(
//           context,
//           MyProfilePage(
//             isMe: isMe,
//             userId: userId,
//             avatar: avatar,
//           )),

void appNavigate(BuildContext context, Widget page) {
  if (Platform.isIOS) {
    Navigator.push(
      context,
      MaterialWithModalsPageRoute(builder: (context) => page),
    );
  } else {
    Navigator.push(
      context,
      IosPageRoute(builder: (context) => page),
    );
  }
}
