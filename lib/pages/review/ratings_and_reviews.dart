import 'package:flutter/material.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class RatingsAndReviews extends StatefulWidget {
  const RatingsAndReviews({Key? key}) : super(key: key);

  @override
  State<RatingsAndReviews> createState() => _RatingsAndReviewsState();
}

class _RatingsAndReviewsState extends State<RatingsAndReviews> {
  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
      // systemOverlayStyle:
      //     SystemUiOverlayStyle(statusBarColor: Colors.transparent),
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
            //Navigator.pop(context);
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
        'Đơn xin việc',
        style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: Color(0xFF0D0D26)),
      ),
      actions: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: Stack(
            children: <Widget>[
              CircleAvatar(
                minRadius: 30,
                maxRadius: 30,
                backgroundImage: AssetImage('assets/images/huy_avatar.jpg'),
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
                        color: Color(0xFFFC1010),
                        border: Border.all(
                            color: ColorInPage.backgroudColor, width: 4),
                        borderRadius: BorderRadius.all(Radius.circular(167))),
                  ))
            ],
          ),
        )
      ],
    );

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
        color: Colors.white,
        margin: EdgeInsets.fromLTRB(24, 8, 24, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[],
        ),
      )),
    );
  }
}
