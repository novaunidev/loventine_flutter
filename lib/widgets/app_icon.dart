import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon extends StatelessWidget {
  final String path;
  final EdgeInsets? padding;
  final double? size;

  final VoidCallback? onTap;

  AppIcon({
    required this.path,
    this.padding = const EdgeInsets.only(left: 7, right: 7),
    this.onTap,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding!,
        child: SvgPicture.asset(path, height: size),
      ),
    );
  }
}
