import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loventine_flutter/models/profile/user_review.dart';
import '../../widgets/format_time_diff.dart';
import '../../widgets/user_information/avatar_widget.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class TextInPage {
  // ignore: non_constant_identifier_names
  static Widget Rating(String str,
      {double size = 18,
      String fontFamily = 'Loventine-Regular',
      double space = 0,
      Color color = Colors.grey}) {
    return Text(
      str,
      style: TextStyle(
        color: color,
        letterSpacing: space,
        fontSize: size,
        fontFamily: fontFamily,
      ),
    );
  }

  static Widget ReportTime(String str,
      {double size = 13,
      String fontFamily = 'Loventine-Regular',
      double space = 0,
      Color color = Colors.black}) {
    return Text(
      str,
      style: TextStyle(
        color: color,
        letterSpacing: space,
        fontSize: size,
        fontFamily: fontFamily,
      ),
    );
  }

  static Widget ReportTitle(
    String str, {
    FontWeight fontWeight = FontWeight.w600,
    double size = 20,
    // String fontFamily = 'OpenSans',
    double space = 0,
    Color color = const Color(0xff133240),
  }) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          // fontFamily: fontFamily,
          fontWeight: fontWeight),
    );
  }
}

class RatingReviewPage extends StatefulWidget {
  const RatingReviewPage({
    super.key,
    required this.reviews,
    required this.averageStar,
  });
  final List<UserReview> reviews;
  final double averageStar;
  @override
  State<RatingReviewPage> createState() => _RatingReviewPageState();
}

class _RatingReviewPageState extends State<RatingReviewPage> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    print(widget.reviews[0].time);
    final SliverAppBar appBar = SliverAppBar(
      backgroundColor: ColorInPage.backgroudColor,
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
            Navigator.pop(context);
          },
          icon: const Image(
              color: ColorInPage.blackColor,
              width: 8,
              height: 16,
              image: AssetImage('assets/images/searchResult_left.png')),
        ),
      ),
      centerTitle: true,
      title: const Text(
        'Đánh giá',
        style: TextStyle(
            fontFamily: 'Loventine-Bold',
            fontSize: 18,
            color: Color(0xFF0D0D26)),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: AvatarWidget(),
        )
      ],
    );

    final pageBody = SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: !isLandscape
                ? mediaQuery.size.height * 0.1
                : mediaQuery.size.height * 0.2,
            child: CustomCard(
              borderRadius: 20,
              borderWidth: 1,
              borderColor: const Color(0xFFF0F0F0),
              color: Colors.white,
              elevation: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IgnorePointer(
                    child: RatingBar.builder(
                      initialRating: widget.averageStar,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 22,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => SvgPicture.asset(
                        'assets/svgs/star.svg',
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  TextInPage.Rating('${widget.reviews.length} lượt đánh giá')
                ],
              ),
            ),
          ),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.reviews.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    CustomCard(
                      childPadding: 30,
                      elevation: 0.0,
                      color: Colors.white,
                      borderWidth: 1,
                      borderColor: const Color(0xFFE7EAEC),
                      borderRadius: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff7c94b6),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.reviews[index].avatarUser),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(7))),
                              ),
                              SizedBox(
                                width: (!isLandscape) ? 10 : 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  IgnorePointer(
                                    ignoring: true,
                                    child: RatingBar.builder(
                                      glowColor: Colors.green,
                                      initialRating:
                                          widget.reviews[index].star.toDouble(),
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 25,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      itemBuilder: (context, _) =>
                                          SvgPicture.asset(
                                        'assets/svgs/star.svg',
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        print(rating);
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: (!isLandscape)
                                        ? const EdgeInsets.fromLTRB(10, 0, 0, 0)
                                        : const EdgeInsets.fromLTRB(
                                            10, 0, 0, 0),
                                    child: TextInPage.ReportTime(
                                        formatTimeDiffStringComment(
                                            widget.reviews[index].time)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            '${widget.reviews[index].nameUser} - ${widget.reviews[index].title}',
                            style: const TextStyle(
                              fontFamily: 'Loventine-Semibold',
                              fontSize: 18,
                              color: Color(0xFF133240),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            widget.reviews[index].content,
                            style: const TextStyle(
                              fontFamily: 'Loventine-Regular',
                              fontSize: 15,
                              color: Color(0xFF133240),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    ));

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[appBar];
        },
        body: pageBody,
      ),
    );
  }
}
