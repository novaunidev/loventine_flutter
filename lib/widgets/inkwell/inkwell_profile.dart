import 'package:flutter/material.dart';
import 'package:loventine_flutter/modules/profile/pages/my_profile_page.dart';
import 'package:loventine_flutter/widgets/custom_page_route/custom_page_route.dart';

class InkWellProfile extends StatelessWidget {
  final Widget child;
  final bool isMe;
  final String userId;
  final String avatar;
  const InkWellProfile(
      {super.key,
      required this.child,
      required this.isMe,
      required this.userId,
      required this.avatar});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => appNavigate(
          context,
          MyProfilePage(
            isMe: isMe,
            userId: userId,
            avatar: avatar,
          )),
      child: child,
    );
  }
}
