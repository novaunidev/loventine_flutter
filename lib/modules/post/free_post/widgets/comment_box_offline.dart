import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommentBoxOffline extends StatelessWidget {
  const CommentBoxOffline({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset("assets/lotties/offline.json", width: 300)),
    );
  }
}
