import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackIcon extends StatelessWidget {
  final Color color;
  final VoidCallback? onPressed;
  final double size;
  BackIcon({this.color = Colors.black, this.onPressed, this.size = 35});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      iconSize: size,
      icon: SvgPicture.asset(
        'assets/svgs/back.svg',
        color: color,
        height: size,
      ),
      onPressed: onPressed ?? () => Navigator.pop(context),
    );
  }
}
