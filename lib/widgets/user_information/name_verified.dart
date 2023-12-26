import 'package:flutter/material.dart';
import 'package:loventine_flutter/values/app_color.dart';

class NameVerified extends StatelessWidget {
  final String name;
  final bool isVerified;
  final double? nameSize;
  final double? verifyHeight;
  final Color? colorText;

  NameVerified(
      {required this.name,
      this.isVerified = false,
      this.nameSize = 15,
      this.verifyHeight = 18,
      this.colorText = AppColor.blackColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Loventine-Bold',
            fontSize: nameSize,
            color: colorText,
          ),
        ),
        if (isVerified)
          Image.asset(
            "assets/images/verified.png",
            height: verifyHeight,
          ),
      ],
    );
  }
}
