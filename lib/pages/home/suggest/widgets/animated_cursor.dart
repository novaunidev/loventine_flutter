import 'package:flutter/material.dart';
import 'package:loventine_flutter/values/app_color.dart';
import '../utils/utils.dart';

class AnimatedCursor extends StatefulWidget {
  final double height;
  const AnimatedCursor({Key? key, required this.height}) : super(key: key);

  @override
  AnimatedCursorState createState() => AnimatedCursorState();
}

class AnimatedCursorState extends State<AnimatedCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: 600.ms);
    animation =
        CurvedAnimation(curve: Curves.easeInOut, parent: animationController);
    animationController.repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (_, child) {
        return Opacity(
          opacity: animation.value,
          child: child,
        );
      },
      child: Container(
        width: 1.5,
        height: widget.height,
        decoration: BoxDecoration(
          color: AppColor.borderButton,
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
