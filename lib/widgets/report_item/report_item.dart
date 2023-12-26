import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../providers/posts.dart';
import '../../providers/users.dart';
import '../../models/rating_review.dart';

class TextInPage {
  static Widget ReportTime(String str,
      {FontWeight fontWeight = FontWeight.w400,
      double size = 14,
      String fontFamily = 'Roboto',
      double space = 0,
      Color color = Colors.black}) {
    return Text(
      str,
      style: TextStyle(
          color: color,
          letterSpacing: space,
          fontSize: size,
          fontFamily: fontFamily,
          fontWeight: fontWeight),
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

  static Widget Review(String str,
      {FontWeight fontWeight = FontWeight.w400,
      double size = 20,
      // String fontFamily = 'OpenSans',
      double space = 0,
      Color color = Colors.black}) {
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

class ReportItem extends StatelessWidget {
  final RatingReview ratingReview;
  ReportItem(this.ratingReview);
  @override
  Widget build(BuildContext context) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    String ratingTime = format.format(ratingReview.rateTime);
    final post = Provider.of<Posts>(context, listen: false)
        .findById(ratingReview.postId);
    final user = Provider.of<Users>(context, listen: false)
        .findById(ratingReview.userId);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Column(
      children: [
        Container(
            height: !isLandscape
                ? MediaQuery.sizeOf(context).height * 0.25
                : MediaQuery.sizeOf(context).height * 0.5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Container(
              margin: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.sizeOf(context).height * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        CircleAvatar(
                          minRadius: 20,
                          maxRadius: 20,
                          backgroundImage:
                              //NetworkImage('https://picsum.photos/id/237/200/300'),
                              NetworkImage(user.avatarURL),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.6,
                              child: RatingBar.builder(
                                initialRating: ratingReview.rating,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 32,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      MediaQuery.sizeOf(context).width * 0.02),
                              child: Container(
                                child: TextInPage.ReportTime('${ratingTime}'),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextInPage.ReportTitle('${user.name} | ${post.emotion[0]}'),
                  TextInPage.Review(ratingReview.review),
                ],
              ),
            )),
      ],
    );
  }
}
