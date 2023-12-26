import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../constant.dart';
import '../../../../../../models/chat/get.dart';
import '../../../../../../providers/chat/chat_page_provider.dart';
import '../../../../../../providers/chat/socket_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../../../../values/app_color.dart';
import '../../../../../../widgets/list_images.dart';

class MessageItem extends StatelessWidget {
  MessageItem(this.message, this.parnerAvatar, this.indexColumn, this.isSeen,
      this.isLast, this.isLocation);
  final Message message;
  final bool isLast;
  final String parnerAvatar;
  final String indexColumn;
  final bool isSeen;
  final String isLocation;

  @override
  Widget build(BuildContext context) {
    final chatPageProvider =
        Provider.of<ChatPageProvider>(context, listen: false);
    final callProvider = Provider.of<CallProvider>(context, listen: false);
    Future<void> waitForDuration() async {
      await Future.delayed(const Duration(seconds: 5));
    }

    List<String> images = [];
    String urlImages = message.message.trim();
    if (message.type == MESSAGE_TYPE.IMAGE) {
      images = urlImages.split(' ');
    }

    double paddingBottom = 2;
    if (isLast) {
      paddingBottom = 12;
    }
    Widget cacheImage(String imageUrl, double border, String location) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) => Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border),
            color: AppColor.iconColor,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(border),
            color: AppColor.iconColor,
          ),
        ),
        imageBuilder: (context, image) => Container(
          width: 150,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: location == "left"
                  ? BorderRadius.only(
                      topRight: Radius.circular(border),
                      bottomRight: Radius.circular(border),
                      bottomLeft: isLocation == 'alone'
                          ? Radius.circular(border)
                          : isLocation == 'top'
                              ? const Radius.circular(2)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : Radius.circular(border),
                      topLeft: isLocation == 'alone'
                          ? Radius.circular(border)
                          : isLocation == 'top'
                              ? Radius.circular(border)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(2))
                  : BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: isLocation == 'alone'
                          ? const Radius.circular(16)
                          : isLocation == 'top'
                              ? const Radius.circular(2)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(16),
                      topRight: isLocation == 'alone'
                          ? const Radius.circular(16)
                          : isLocation == 'top'
                              ? const Radius.circular(16)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(2)),
              image: DecorationImage(
                image: image,
                fit: BoxFit.cover,
              )),
        ),
      );
    }

    Widget textRight = GestureDetector(
      onLongPress: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                ListTile(
                  onTap: () async {
                    Provider.of<ChatPageProvider>(context, listen: false)
                        .deleteMessage(message);
                    Navigator.of(context).pop();
                  },
                  leading: const Icon(Icons.delete),
                  title: const Text('Xóa tin nhắn'),
                ),
              ],
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 250),
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(bottom: isLast ? 5 : 2),
                decoration: BoxDecoration(
                  color: AppColor.chatBubble,
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: isLocation == 'alone'
                          ? const Radius.circular(16)
                          : isLocation == 'top'
                              ? const Radius.circular(2)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(16),
                      topRight: isLocation == 'alone'
                          ? const Radius.circular(16)
                          : isLocation == 'top'
                              ? const Radius.circular(16)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(2)),
                ),
                child: Text(
                  message.message,
                  style: const TextStyle(
                    fontFamily: 'Loventine-Regular',
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
              if (message.isSent == false)
                FutureBuilder(
                  future: waitForDuration(),
                  builder:
                      (BuildContext context, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return const Text(
                        'Chưa gửi',
                        style: TextStyle(
                          fontFamily: 'Loventine-Regular',
                          fontSize: 11,
                          color: AppColor.iconColor,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              if (!isSeen &&
                  message.isSent == true &&
                  int.parse(indexColumn) == 0)
                const Text(
                  'Đã gửi',
                  style: TextStyle(
                    fontFamily: 'Loventine-Regular',
                    fontSize: 11,
                    color: AppColor.iconColor,
                  ),
                ),
              if (isSeen && int.parse(indexColumn) == 0)
                CachedNetworkImage(
                  imageUrl: parnerAvatar,
                  placeholder: (context, url) => CircleAvatar(
                    radius: 7,
                    backgroundImage: NetworkImage(
                      parnerAvatar,
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 7,
                    backgroundImage: NetworkImage(
                      defaultAvatar,
                    ),
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 7,
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    Widget textLeft = Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBottom),
      child: Row(
        children: [
          isLast
              ? CachedNetworkImage(
                  imageUrl: parnerAvatar,
                  placeholder: (context, url) => CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      parnerAvatar,
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      defaultAvatar,
                    ),
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 14,
                  ),
                )
              : const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                ),
          const SizedBox(width: 10),
          Container(
            constraints: const BoxConstraints(maxWidth: 250),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xffefefef),
              borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                  bottomLeft: isLocation == 'alone'
                      ? const Radius.circular(16)
                      : isLocation == 'top'
                          ? const Radius.circular(2)
                          : isLocation == 'center'
                              ? const Radius.circular(2)
                              : const Radius.circular(16),
                  topLeft: isLocation == 'alone'
                      ? const Radius.circular(16)
                      : isLocation == 'top'
                          ? const Radius.circular(16)
                          : isLocation == 'center'
                              ? const Radius.circular(2)
                              : const Radius.circular(2)),
            ),
            child: Text(
              message.message,
              style: const TextStyle(
                fontFamily: 'Loventine-Regular',
                fontSize: 15,
                color: AppColor.blackColor,
              ),
            ),
          ),
        ],
      ),
    );

    Widget deletedMessageRight = Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 250),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                bottomLeft: const Radius.circular(16),
                bottomRight: isLocation == 'alone'
                    ? const Radius.circular(16)
                    : isLocation == 'top'
                        ? const Radius.circular(2)
                        : isLocation == 'center'
                            ? const Radius.circular(2)
                            : const Radius.circular(16),
                topRight: isLocation == 'alone'
                    ? const Radius.circular(16)
                    : isLocation == 'top'
                        ? const Radius.circular(16)
                        : isLocation == 'center'
                            ? const Radius.circular(2)
                            : const Radius.circular(2)),
            border: Border.all(
              color: const Color(0xfff5f5f5),
              width: 1,
            ),
          ),
          child: const Text(
            'Tin nhắn đã được thu hồi',
            style: TextStyle(
              fontFamily: 'Loventine-Regular',
              fontSize: 15,
              color: AppColor.deleteBubble,
            ),
          ),
        ),
      ),
    );

    Widget deletedMessageLeft = Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBottom),
      child: Row(
        children: [
          isLast
              ? CachedNetworkImage(
                  imageUrl: parnerAvatar,
                  placeholder: (context, url) => CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      parnerAvatar,
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      defaultAvatar,
                    ),
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 14,
                  ),
                )
              : const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                ),
          const SizedBox(width: 10),
          Container(
            constraints: const BoxConstraints(maxWidth: 250),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                  bottomLeft: isLocation == 'alone'
                      ? const Radius.circular(16)
                      : isLocation == 'top'
                          ? const Radius.circular(2)
                          : isLocation == 'center'
                              ? const Radius.circular(2)
                              : const Radius.circular(16),
                  topLeft: isLocation == 'alone'
                      ? const Radius.circular(16)
                      : isLocation == 'top'
                          ? const Radius.circular(16)
                          : isLocation == 'center'
                              ? const Radius.circular(2)
                              : const Radius.circular(2)),
              border: Border.all(
                color: const Color(0xfff5f5f5),
                width: 1,
              ),
            ),
            child: const Text(
              'Tin nhắn đã được thu hồi',
              style: TextStyle(
                fontFamily: 'Loventine-Regular',
                fontSize: 15,
                color: AppColor.deleteBubble,
              ),
            ),
          ),
        ],
      ),
    );
    Widget imageRight = GestureDetector(
        onLongPress: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Wrap(
                children: [
                  ListTile(
                    onTap: () async {
                      Provider.of<ChatPageProvider>(context, listen: false)
                          .deleteMessage(message);
                      Navigator.of(context).pop();
                    },
                    leading: const Icon(Icons.delete),
                    title: const Text('Xóa tin nhắn'),
                  ),
                ],
              );
            },
          );
        },
        child: images.length == 1
            ? message.message == "error"
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(20),
                            bottomLeft: const Radius.circular(20),
                            bottomRight: isLocation == 'alone'
                                ? const Radius.circular(20)
                                : isLocation == 'top'
                                    ? const Radius.circular(2)
                                    : isLocation == 'center'
                                        ? const Radius.circular(2)
                                        : const Radius.circular(20),
                            topRight: isLocation == 'alone'
                                ? const Radius.circular(20)
                                : isLocation == 'top'
                                    ? const Radius.circular(20)
                                    : isLocation == 'center'
                                        ? const Radius.circular(2)
                                        : const Radius.circular(2)),
                        child: Image.asset("assets/images/image_error.jpg",
                            width: 150, height: 150, fit: BoxFit.cover),
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return FadeTransition(
                              opacity: animation,
                              child: ImageDetail(
                                images: images,
                                tag: "image$indexColumn",
                                initialIndex: 0,
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Hero(
                            tag: "image$indexColumn",
                            child: cacheImage(images[0], 20, 'right')),
                      ),
                    ),
                  )
            : Padding(
                padding: const EdgeInsets.only(left: 80, bottom: 5),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 8,
                    ),
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(right: 12),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: images.length == 2 ? 3 : images.length,
                    itemBuilder: (context, index) {
                      return images.length == 2
                          ? index == 0
                              ? const SizedBox()
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation,
                                            secondaryAnimation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: ImageDetail(
                                              images: images,
                                              tag:
                                                  "image2${index - 1}$indexColumn",
                                              initialIndex: index - 1,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Hero(
                                      tag: "image2${index - 1}$indexColumn",
                                      child: cacheImage(
                                          images[index - 1], 3, 'right')),
                                )
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: ImageDetail(
                                          images: images,
                                          tag: "images$index$indexColumn",
                                          initialIndex: index,
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                              child: Hero(
                                  tag: "images$index$indexColumn",
                                  child: cacheImage(images[index], 3, 'right')),
                            );
                    }),
              ));

    Widget imageLeft = images.length == 1
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLast
                    ? CachedNetworkImage(
                        imageUrl: parnerAvatar,
                        placeholder: (context, url) => CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            parnerAvatar,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            defaultAvatar,
                          ),
                        ),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 14,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                      ),
                const SizedBox(width: 10),
                message.message == "error"
                    ? ClipRRect(
                        borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(20),
                            bottomRight: const Radius.circular(20),
                            bottomLeft: isLocation == 'alone'
                                ? const Radius.circular(20)
                                : isLocation == 'top'
                                    ? const Radius.circular(2)
                                    : isLocation == 'center'
                                        ? const Radius.circular(2)
                                        : const Radius.circular(20),
                            topLeft: isLocation == 'alone'
                                ? const Radius.circular(20)
                                : isLocation == 'top'
                                    ? const Radius.circular(20)
                                    : isLocation == 'center'
                                        ? const Radius.circular(2)
                                        : const Radius.circular(2)),
                        child: Image.asset(
                          "assets/images/image_error.jpg",
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: ImageDetail(
                                    images: images,
                                    tag: "image$indexColumn",
                                    initialIndex: 0,
                                  ),
                                );
                              },
                            ),
                          );
                        },
                        child: Hero(
                            tag: "image$indexColumn",
                            child: cacheImage(images[0], 20, 'left')),
                      ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isLast
                    ? CachedNetworkImage(
                        imageUrl: parnerAvatar,
                        placeholder: (context, url) => CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            parnerAvatar,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(
                          radius: 14,
                          backgroundImage: NetworkImage(
                            defaultAvatar,
                          ),
                        ),
                        imageBuilder: (context, image) => CircleAvatar(
                          backgroundImage: image,
                          radius: 14,
                        ),
                      )
                    : const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white,
                      ),
                const SizedBox(width: 10),
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 3,
                              mainAxisSpacing: 3),
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(right: 60),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: ImageDetail(
                                      images: images,
                                      tag: "images$index$indexColumn",
                                      initialIndex: index,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: Hero(
                            tag: "images$index$indexColumn",
                            child: cacheImage(images[index], 3, 'left'),
                          ),
                        );
                      }),
                ),
              ],
            ),
          );

    String messageType = message.type;
    Widget dateWidget = Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 24),
        child: Center(
            child: Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            message.message,
            style: const TextStyle(
              fontFamily: 'Loventine-Regular',
              fontSize: 11,
              color: AppColor.iconColor,
            ),
          ),
        )));
    var _call_text = message.message.split('#');

    Widget callSuccessLeft = Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBottom),
      child: Row(
        children: [
          isLast
              ? CachedNetworkImage(
                  imageUrl: parnerAvatar,
                  placeholder: (context, url) => CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      parnerAvatar,
                    ),
                  ),
                  errorWidget: (context, url, error) => const CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(
                      defaultAvatar,
                    ),
                  ),
                  imageBuilder: (context, image) => CircleAvatar(
                    backgroundImage: image,
                    radius: 14,
                  ),
                )
              : const CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                ),
          const SizedBox(width: 10),
          Container(
            constraints: const BoxConstraints(maxWidth: 190),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xfff1f1f1),
              borderRadius: BorderRadius.only(
                  topRight: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
                  bottomLeft: isLocation == 'alone'
                      ? const Radius.circular(16)
                      : isLocation == 'top'
                          ? const Radius.circular(2)
                          : isLocation == 'center'
                              ? const Radius.circular(2)
                              : const Radius.circular(16),
                  topLeft: isLocation == 'alone'
                      ? const Radius.circular(16)
                      : isLocation == 'top'
                          ? const Radius.circular(16)
                          : isLocation == 'center'
                              ? const Radius.circular(2)
                              : const Radius.circular(2)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 34,
                  height: 34,
                  child: MaterialButton(
                      shape: const CircleBorder(),
                      elevation: 0,
                      color: AppColor.iconColor,
                      padding: const EdgeInsets.all(0),
                      onPressed: () {},
                      child: _call_text[0] == 'gọi thường'
                          ? SvgPicture.asset(
                              "assets/svgs/call_b.svg",
                              color: Colors.white,
                            )
                          : SvgPicture.asset(
                              "assets/svgs/video_b.svg",
                              color: Colors.white,
                            )),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Cuộc ${_call_text[0]}',
                      style: const TextStyle(
                        fontFamily: 'Loventine-Bold',
                        fontSize: 15,
                        color: AppColor.blackColor,
                      ),
                    ),
                    Text(
                      _call_text.length > 1 ? _call_text[1] : '',
                      style: const TextStyle(
                        fontFamily: 'Loventine-Regular',
                        fontSize: 12,
                        color: AppColor.iconColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
    Widget callSuccessRight = Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 190),
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: isLast ? 5 : 2),
              decoration: BoxDecoration(
                color: const Color(0xfff1f1f1),
                borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(16),
                    bottomLeft: const Radius.circular(16),
                    bottomRight: isLocation == 'alone'
                        ? const Radius.circular(16)
                        : isLocation == 'top'
                            ? const Radius.circular(2)
                            : isLocation == 'center'
                                ? const Radius.circular(2)
                                : const Radius.circular(16),
                    topRight: isLocation == 'alone'
                        ? const Radius.circular(16)
                        : isLocation == 'top'
                            ? const Radius.circular(16)
                            : isLocation == 'center'
                                ? const Radius.circular(2)
                                : const Radius.circular(2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 34,
                    height: 34,
                    child: MaterialButton(
                        shape: const CircleBorder(),
                        elevation: 0,
                        color: AppColor.iconColor,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        child: _call_text[0] == 'gọi thường'
                            ? SvgPicture.asset(
                                "assets/svgs/call_b.svg",
                                color: Colors.white,
                              )
                            : SvgPicture.asset(
                                "assets/svgs/video_b.svg",
                                color: Colors.white,
                              )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cuộc ${_call_text[0]}',
                        style: const TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 15,
                          color: AppColor.blackColor,
                        ),
                      ),
                      Text(
                        _call_text.length > 1 ? _call_text[1] : '',
                        style: const TextStyle(
                          fontFamily: 'Loventine-Regular',
                          fontSize: 12,
                          color: AppColor.iconColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    Widget callFailedLeft = InkWell(
      onTap: () {
        callProvider.make_call(
          chatPageProvider.chatRoom.partner.sId,
          (_call_text[0] == 'gọi thường') ? CALL_TYPE.AUDIO : CALL_TYPE.VIDEO,
          chatPageProvider.chatRoom.sId,
        );
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, paddingBottom),
        child: Row(
          children: [
            isLast
                ? CachedNetworkImage(
                    imageUrl: parnerAvatar,
                    placeholder: (context, url) => CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(
                        parnerAvatar,
                      ),
                    ),
                    errorWidget: (context, url, error) => const CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(
                        defaultAvatar,
                      ),
                    ),
                    imageBuilder: (context, image) => CircleAvatar(
                      backgroundImage: image,
                      radius: 14,
                    ),
                  )
                : const CircleAvatar(
                    radius: 14,
                    backgroundColor: Colors.white,
                  ),
            const SizedBox(width: 10),
            Container(
              constraints: const BoxConstraints(maxWidth: 260),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xfff1f1f1),
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(16),
                    bottomRight: const Radius.circular(16),
                    bottomLeft: isLocation == 'alone'
                        ? const Radius.circular(16)
                        : isLocation == 'top'
                            ? const Radius.circular(2)
                            : isLocation == 'center'
                                ? const Radius.circular(2)
                                : const Radius.circular(16),
                    topLeft: isLocation == 'alone'
                        ? const Radius.circular(16)
                        : isLocation == 'top'
                            ? const Radius.circular(16)
                            : isLocation == 'center'
                                ? const Radius.circular(2)
                                : const Radius.circular(2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 34,
                    height: 34,
                    child: MaterialButton(
                        elevation: 0,
                        shape: const CircleBorder(),
                        color: AppColor.redColor,
                        padding: const EdgeInsets.all(0),
                        onPressed: () {},
                        child: _call_text[0] == 'gọi thường'
                            ? SvgPicture.asset(
                                "assets/svgs/call-remove.svg",
                                color: Colors.white,
                              )
                            : SvgPicture.asset(
                                "assets/svgs/video-slash.svg",
                                color: Colors.white,
                              )),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Đã bỏ lỡ cuộc ${_call_text[0]}',
                        style: const TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 15,
                          color: AppColor.blackColor,
                        ),
                      ),
                      const Text(
                        'Nhấn vào để gọi lại',
                        style: TextStyle(
                          fontFamily: 'Loventine-Regular',
                          fontSize: 12,
                          color: AppColor.iconColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    Widget callFailedRight = InkWell(
      onTap: () {
        callProvider.make_call(
          chatPageProvider.chatRoom.partner.sId,
          (_call_text[0] == 'gọi thường') ? CALL_TYPE.AUDIO : CALL_TYPE.VIDEO,
          chatPageProvider.chatRoom.sId,
        );
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Align(
          alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                constraints: const BoxConstraints(maxWidth: 190),
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: isLast ? 5 : 2),
                decoration: BoxDecoration(
                  color: const Color(0xfff1f1f1),
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      bottomLeft: const Radius.circular(16),
                      bottomRight: isLocation == 'alone'
                          ? const Radius.circular(16)
                          : isLocation == 'top'
                              ? const Radius.circular(2)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(16),
                      topRight: isLocation == 'alone'
                          ? const Radius.circular(16)
                          : isLocation == 'top'
                              ? const Radius.circular(16)
                              : isLocation == 'center'
                                  ? const Radius.circular(2)
                                  : const Radius.circular(2)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 34,
                      height: 34,
                      child: MaterialButton(
                          shape: const CircleBorder(),
                          color: AppColor.redColor,
                          padding: const EdgeInsets.all(0),
                          elevation: 0,
                          onPressed: () {},
                          child: _call_text[0] == 'gọi thường'
                              ? SvgPicture.asset(
                                  "assets/svgs/call-remove.svg",
                                  color: Colors.white,
                                )
                              : SvgPicture.asset(
                                  "assets/svgs/video-slash.svg",
                                  color: Colors.white,
                                )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Cuộc ${_call_text[0]}',
                          style: const TextStyle(
                            fontFamily: 'Loventine-Bold',
                            fontSize: 15,
                            color: AppColor.blackColor,
                          ),
                        ),
                        const Text(
                          'Nhấn vào để gọi lại',
                          style: TextStyle(
                            fontFamily: 'Loventine-Regular',
                            fontSize: 12,
                            color: AppColor.iconColor,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    late Widget finalWidget;
    switch (messageType) {
      case "isDate":
        {
          finalWidget = dateWidget;
        }
        break;

      case MESSAGE_TYPE.STATUS:
        {
          finalWidget = dateWidget;
        }
        break;
      case MESSAGE_TYPE.TEXT:
        {
          finalWidget = message.userId == SocketProvider.current_user_id
              ? textRight
              : textLeft;
        }
        break;
      case MESSAGE_TYPE.IMAGE:
        {
          finalWidget = message.userId == SocketProvider.current_user_id
              ? imageRight
              : imageLeft;
        }
        break;
      case MESSAGE_TYPE.CALL_FAILED:
        {
          finalWidget = message.userId == SocketProvider.current_user_id
              ? callFailedRight
              : callFailedLeft;
        }
        break;
      case MESSAGE_TYPE.CALL_SUCCESS:
        {
          finalWidget = message.userId == SocketProvider.current_user_id
              ? callSuccessRight
              : callSuccessLeft;
        }
        break;
      default:
        {
          //statements;
        }
        break;
    }

    if (message.isDeleted == true) {
      finalWidget = message.userId == SocketProvider.current_user_id
          ? deletedMessageRight
          : deletedMessageLeft;
    }
    return finalWidget;
  }
}
