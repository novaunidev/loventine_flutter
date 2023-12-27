import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../values/app_color.dart';

class Onboarding extends StatelessWidget {
  final Color kDarkBlueColor = const Color(0xFF053149);

  const Onboarding({super.key});
  Widget buildRow(
      String imageAsset, String title, String subtitle, Color color) {
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset(
              imageAsset,
              height: 35,
              color: color,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Bold",
                        color: Color(0xff020202)),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: Color(0xff020202)),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            width: 37,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(9),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
            child: Column(children: [
              const Text(
                "Welcome to Loventine",
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: "Loventine-Black",
                    color: Color(0xff020202)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              buildRow(
                  "assets/svgs/empty-wallet-time.svg",
                  "Tiêu đề 1 nè",
                  "Bạn đăng bài và chờ những người giàu kinh nghiệm",
                  AppColor.iconColor),
              buildRow(
                  "assets/svgs/empty-wallet-time.svg",
                  "Tiêu đề 2 nè",
                  "Bạn đăng bài và chờ những người giàu kinh nghiệm nè",
                  AppColor.iconColor),
              buildRow(
                  "assets/svgs/empty-wallet-time.svg",
                  "Tiêu đề 3 nè",
                  "Bạn đăng bài và chờ những người giàu kinh nghiệm nè",
                  AppColor.iconColor),
            ]),
          ),
          const Spacer(), //thêm đoạn này vào để TextButton nằm ở cuối trang
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              backgroundColor: AppColor.mainColor,
              minimumSize: const Size(327, 56),
            ),
            onPressed: () {},
            child: const Text(
              'Tiếp tục sử dụng',
              style: TextStyle(
                fontFamily: 'Loventine-Bold',
                fontSize: 16,
                color: Color(0xffffffff),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
