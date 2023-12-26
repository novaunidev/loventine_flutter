import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/widgets/list_images.dart';
import 'package:provider/provider.dart';

class TimeBasedLottieWidget extends StatefulWidget {
  @override
  State<TimeBasedLottieWidget> createState() => _TimeBasedLottieWidgetState();
}

class _TimeBasedLottieWidgetState extends State<TimeBasedLottieWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<MessagePageProvider>(context, listen: false)
          .getBannerUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessagePageProvider>(builder: (context, value, child) {
      final now = DateTime.now();
      String bannerUrl = '';
      // Lấy thời gian hiện tại
      final currentTime = TimeOfDay.fromDateTime(now);
      // Kiểm tra xem thời gian hiện tại là buổi sáng, trưa hay tối
      if (currentTime.hour >= 6 && currentTime.hour < 12) {
        bannerUrl = value.bannerMorning;
      } else if (currentTime.hour >= 12 && currentTime.hour < 18) {
        bannerUrl = value.bannerAfternoon;
      } else {
        bannerUrl = value.bannerEvening;
      }
      return GestureDetector(
        onTap: () {
          Navigator.push(context, PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return FadeTransition(
                opacity: animation,
                child: ImageDetail(
                  images: [bannerUrl],
                  tag: "banner",
                  initialIndex: 0,
                ),
              );
            },
          ));
        },
        child: Hero(
          tag: "banner",
          child: CachedNetworkImage(
            imageUrl: bannerUrl,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 145,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      );
    });
  }
}
