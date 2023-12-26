import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../models/review.dart';
import '../../values/app_color.dart';

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class WatchReview extends StatefulWidget {
  final Review review;
  const WatchReview({Key? key, required this.review});

  @override
  State<WatchReview> createState() => _WatchReviewState();
}

class _WatchReviewState extends State<WatchReview> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    _contentController.text = widget.review.content;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height * 0.5,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xfffafafa),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              offset: const Offset(0, 30),
              blurRadius: 60,
            ),
            const BoxShadow(
              color: Colors.black45,
              offset: Offset(0, 30),
              blurRadius: 60,
            ),
          ],
        ),
        child: Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/rating_page.gif"),
                const Text(
                  "Đánh giá và phản hồi",
                  style: TextStyle(fontFamily: "Loventine-Bold", fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromRGBO(100, 100, 111, 0.3),
                        offset: Offset(0, 5),
                        blurRadius: 29,
                      ),
                    ],
                  ),
                  width: 60,
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(widget.review.avatarUser),
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  widget.review.nameUser,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: "Loventine-Bold",
                      fontSize: 15,
                      color: Color(0xff5B555C)),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: const Color(0xffe2e3eb),
                      width: 2.0,
                    ),
                    color: const Color(0xfff9f9fb),
                  ),
                  child: Text(widget.review.content,
                      style: const TextStyle(
                        fontFamily: 'Loventine-Semibold',
                        fontSize: 15,
                        color: AppColor.textBlack,
                      )),
                ),
                const SizedBox(
                  height: 5,
                ),
                RatingBar.builder(
                  initialRating: widget.review.star.toDouble(),
                  ignoreGestures: true,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => SvgPicture.asset(
                    'assets/svgs/star.svg',
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
