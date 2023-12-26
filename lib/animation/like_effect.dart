import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LikeEffect extends StatefulWidget {
  final ValueChanged<bool> onCompleted;
  final double? height;
  final double top;
  final double left;

  LikeEffect({
    required this.onCompleted,
    required this.top,
    required this.left,
    this.height = 300,
  });
  @override
  _LikeEffectState createState() => _LikeEffectState();
}

class _LikeEffectState extends State<LikeEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top - 150,
      left: widget.left - 150,
      child: Lottie.asset(
        'assets/lotties/like.json',
        height: widget.height,
        controller: _controller,
        onLoaded: (composition) {
          _controller
            ..duration = composition.duration
            ..reset()
            ..forward().whenComplete(() => setState(() {
                  widget.onCompleted(false);
                }));
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
