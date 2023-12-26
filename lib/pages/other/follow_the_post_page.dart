import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:group_button/group_button.dart';

class FollowPost extends StatefulWidget {
  const FollowPost({Key? key}) : super(key: key);

  @override
  State<FollowPost> createState() => _FollowPostState();
}

class _FollowPostState extends State<FollowPost> {
  @override
  Widget build(BuildContext context) {
    final List<String> choices = [
      'Tất cả',
      'Deal giá',
      'Chấp nhận giá',
    ];
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
      // systemOverlayStyle:
      //     SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      backgroundColor: Color(0xFFFAFAFD),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0))),
      elevation: 0.0,
      leading: Container(
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
        child: IconButton(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          onPressed: () {
            // print('Back to Search Filter Page');
            //Navigator.pop(context);
          },
          icon: const Image(
              color: Color(0xFF0D0D26),
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Theo dõi bài đăng',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF0D0D26)),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: Stack(
            children: <Widget>[
              const CircleAvatar(
                minRadius: 25,
                maxRadius: 25,
                backgroundImage: AssetImage('assets/images/avt_nltn.png'),
              ),
              Positioned(
                  top: 0,
                  right: 0,
                  width: 16,
                  height: 16,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFC1010),
                        border: Border.all(color: Color(0xFFFAFAFD), width: 4),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(167))),
                  ))
            ],
          ),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: !isLandscape ? 260 : double.infinity,
              margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
              child: const Text(
                "Đã có 35 freelancer apply vào vấn đề của bạn 👍",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color(0xFF0D0D26),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: GroupButton(
                options: GroupButtonOptions(
                  selectedTextStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  unselectedTextStyle: const TextStyle(
                    color: Color(0xFF95969D),
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                  selectedColor: const Color(0xFFEC1C24),
                  unselectedColor: Color(0xFFFAFAFD),
                  borderRadius: BorderRadius.circular(97),
                  unselectedBorderColor: const Color(0xFF95969D),
                  selectedBorderColor: const Color(0xFFEC1C24),
                  selectedShadow: const [
                    BoxShadow(
                      color: Color(0xFFFAFAFD),
                      blurRadius: 25.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                  unselectedShadow: const [
                    BoxShadow(
                      color: Color(0xFFFAFAFD),
                      blurRadius: 25.0,
                      spreadRadius: 1.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                  //direction: Axis.vertical,
                  groupingType: GroupingType.row,
                ),
                buttons: choices,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 25,
                  left: 25,
                  bottom: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 47,
                          width: 47,
                          child: Image.asset(
                            'assets/images/avt_nhuy.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Như Ý',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Xem chi tiết',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Chấp nhận giá',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0E9D57)),
                              ),
                              Text(
                                '1 giờ trước',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff0D0D26)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    //để làm 3 cái button
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Material(
                            color: Color(0xffEDF3FC),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 109,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Mời phỏng vấn',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff5386E4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          //
                          Material(
                            color: Color(0xffE8FDF2),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 76,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Chấp nhận',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0E9D57),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //
                          const SizedBox(width: 10),
                          Material(
                            color: Color(0xffFFEDED),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 65,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Từ chối',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffDC312D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            //Châu Hoàng
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 25,
                  left: 25,
                  bottom: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 47,
                          width: 47,
                          child: Image.asset(
                            'assets/images/avt_chau.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Châu Hoàng',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Xem chi tiết',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Giá: 100k/tuần',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFF0000)),
                              ),
                              Text(
                                '19 giây trước',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff0D0D26)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    //để làm 3 cái button
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Material(
                            color: Color(0xffEDF3FC),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 109,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Mời phỏng vấn',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff5386E4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          //
                          Material(
                            color: Color(0xffE8FDF2),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 76,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Chấp nhận',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0E9D57),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //
                          const SizedBox(width: 10),
                          Material(
                            color: Color(0xffFFEDED),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 65,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Từ chối',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffDC312D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 25,
                  left: 25,
                  bottom: 15,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 47,
                          width: 47,
                          child: Image.asset(
                            'assets/images/avt_yen.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Yến',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Xem chi tiết',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Giá 50k/giờ',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffFF0000)),
                              ),
                              Text(
                                '1 giờ trước',
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w300,
                                    color: Color(0xff0D0D26)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    //để làm 3 cái button
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Material(
                            color: Color(0xffEDF3FC),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 109,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Mời phỏng vấn',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff5386E4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          //
                          Material(
                            color: Color(0xffE8FDF2),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 76,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Chấp nhận',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xff0E9D57),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          //
                          const SizedBox(width: 10),
                          Material(
                            color: Color(0xffFFEDED),
                            borderRadius: BorderRadius.circular(52),
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(52),
                              child: Container(
                                width: 65,
                                height: 39,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Từ chối',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xffDC312D),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
