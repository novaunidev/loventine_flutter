import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostFeeValue extends StatelessWidget {
  final String price;
  final String adviseType;
  final int adviseTypeValue;

  PostFeeValue(
      {required this.price,
      required this.adviseType,
      required this.adviseTypeValue});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          "assets/svgs/empty-wallet-time.svg",
          height: 19,
        ),
        Text(
          " $price ₫",
          style: const TextStyle(
            fontFamily: 'Loventine-Extrabold',
            fontSize: 15,
          ),
        ),
        const Text(
          "   -   ",
          style: TextStyle(
            fontFamily: 'Loventine-Regular',
            fontSize: 15,
          ),
        ),
        SvgPicture.asset(
          "assets/svgs/timer-1.svg",
          height: 19,
        ),
        if (adviseTypeValue != 0) ...[
          Text(
            " $adviseTypeValue",
            style: const TextStyle(
              fontFamily: 'Loventine-Extrabold',
              fontSize: 15,
            ),
          )
        ],
        Text(
          " $adviseType",
          style: const TextStyle(
            fontFamily: 'Loventine-Extrabold',
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
