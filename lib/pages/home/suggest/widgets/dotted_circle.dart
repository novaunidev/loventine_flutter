import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/values/app_color.dart';

class DottedCircle extends StatelessWidget {
  final double height;

  const DottedCircle({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: AppColor.blackColor,
      borderType: BorderType.Circle,
      strokeWidth: 1,
      dashPattern: const [3, 3],
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: height,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
