import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/values/app_color.dart';

import '../../../widgets/app_text.dart';

class InfoProfile extends StatelessWidget {
  final String text;
  final String svgPath;
  const InfoProfile({super.key, required this.text, required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColor.borderButton,
          radius: 18,
          child: SvgPicture.asset(
            svgPath,
            height: 20,
            color: AppColor.blackColor,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Flexible(
          child: Text(
            text,
            style: AppText.contentRegular(),
          ),
        ),
      ],
    );
  }
}
