import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import 'package:loventine_flutter/models/profile/user_review.dart';
import 'package:loventine_flutter/modules/profile/pages/edit_profile_page.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/cupertino_bottom_sheet/src/material_with_modal_page_route.dart';
import 'package:loventine_flutter/widgets/custom_page_route/custom_page_route.dart';
import 'package:loventine_flutter/widgets/user_information/name_verified.dart';

import '../../../providers/page/message_page/card_profile_provider.dart';
import '../../../pages/review/rating_reviews_page.dart';

class CardProfileWidget extends StatelessWidget {
  final bool isMe;
  //final List<UserImage> image_uploads;
  final User? user;
  final List<UserReview> reviews;
  final String avatar;
  CardProfileWidget(
      {super.key,
      this.isMe = false,
      required this.reviews,
      //required this.image_uploads,
      required this.user,
      required this.avatar});

//Data Image Upload

  @override
  Widget build(BuildContext context) {
    double averageStar = 0.0;
    if (reviews.isNotEmpty) {
      averageStar =
          reviews.map((review) => review.star).reduce((a, b) => a + b) /
              reviews.length;
    }

    final size = MediaQuery.sizeOf(context);
    print(size.height);
    return SizedBox(
      height: 440,
      width: size.width,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 7, 20, 30),
        padding: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: const [
            BoxShadow(
              blurRadius: 30,
              spreadRadius: 0,
              offset: Offset(0, 10),
              color: Color.fromRGBO(123, 87, 182, 0.18),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 60,
            ),
            const SizedBox(height: 5),
            // name
            NameVerified(
              name: user!.name,
              isVerified: user!.verified,
              nameSize: 20,
            ),
            const SizedBox(height: 20),
            // tel
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                '${user?.about}',
                style: const TextStyle(
                  fontFamily: 'Loventine-Regular',
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            // rating and number
            Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(horizontal: 25),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F9FC),
                borderRadius: BorderRadius.circular(21),
              ),
              child: Row(
                children: [
                  Column(
                    children: [
                      const Text(
                        '0',
                        style: TextStyle(
                          fontFamily: 'Loventine-Extrabold',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Lượt tư vấn',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Loventine-Regular',
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    color: const Color.fromRGBO(151, 151, 151, 0.7),
                    width: 1,
                    height: 80,
                    child: const SizedBox(),
                  ),
                  const Spacer(),
                  if (reviews.isNotEmpty) ...[
                    InkWell(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RatingReviewPage(
                            reviews: reviews,
                            averageStar: averageStar,
                          ),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Đánh giá: ',
                                style: TextStyle(
                                  fontFamily: 'Loventine-Regular',
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                averageStar.toStringAsFixed(2).toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Loventine-Extrabold',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 5),
                          RatingBar.builder(
                            initialRating: averageStar,
                            ignoreGestures: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: size.width * 0.05,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => SvgPicture.asset(
                              'assets/svgs/star.svg',
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                reviews.length.toString() + ' ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Loventine-Bold',
                                  fontSize: 16,
                                  color: Color.fromRGBO(63, 19, 228, 1),
                                ),
                              ),
                              const Text(
                                'đánh giá',
                                style: TextStyle(
                                  fontFamily: 'Loventine-Regular',
                                  fontSize: 16,
                                  color: Color.fromRGBO(63, 19, 228, 1),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ] else ...[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: SizedBox(
                        width: size.width * 0.35,
                        child: const Text(
                          "Bạn chưa có bất kỳ đánh giá nào!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Loventine-Bold',
                            fontSize: 16,
                            color: AppColor.mainColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            isMe
                ? InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialWithModalsPageRoute(
                        builder: (_) => EditProfilePage(
                          user: user,
                          isMe: isMe,
                          avatar: avatar,
                        ),
                      ),
                    ),
                    child: IntrinsicWidth(
                      // Thêm IntrinsicWidth sẽ wrap với chiều ngang của nội dung
                      child: Container(
                        padding: const EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                          color: AppColor.mainColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            Text('Chỉnh sửa thông tin cá nhân',
                                style: AppText.contentSemibold()),
                          ],
                        ),
                      ),
                    ),
                  )
                : InkWell(
                    onTap: () => appNavigate(
                        context,
                        EditProfilePage(
                          user: user,
                          isMe: isMe,
                          avatar: avatar,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/svgs/more.svg",
                          height: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "Xem thông tin cá nhân",
                          style: AppText.contentSemibold(),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ))
          ],
        ),
      ),
    );
  }
}
