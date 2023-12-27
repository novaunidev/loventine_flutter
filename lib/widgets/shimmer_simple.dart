import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/values/app_color.dart';

class ShimmerSimple extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/lotties/shimmer.json'),
          const Text(
            "Bạn đợi Loventine xíu, sẽ nhanh thôi...",
            style: TextStyle(
              fontFamily: 'Loventine-Regular',
              fontSize: 15,
              color: AppColor.titletextcolor,
            ),
          ),
        ],
      ),
    );
  }
}
