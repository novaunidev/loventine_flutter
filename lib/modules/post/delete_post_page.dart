import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/providers/post_all/post_delete_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_fee_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/format_time_diff.dart';
import 'package:loventine_flutter/widgets/shimmer_post/shimmer_post_delete.dart';
import 'package:provider/provider.dart';

class DeletePostPage extends StatefulWidget {
  final String userId;
  const DeletePostPage({super.key, required this.userId});

  @override
  State<DeletePostPage> createState() => _DeletePostPageState();
}

class _DeletePostPageState extends State<DeletePostPage> {
  String formatCurrency(int amount) {
    final formatter = NumberFormat("#,###");
    return formatter.format(amount).replaceAll(',', '.');
  }

  List<PostAll> _postsDelete = [];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<PostDeleteProvider>(context, listen: false)
          .getAllPostsDelete(widget.userId);
      _postsDelete =
          Provider.of<PostDeleteProvider>(context, listen: false).postsDelete;

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          physics: const BouncingScrollPhysics(),
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/images/searchResult_left.png",
                  height: 15,
                ),
              ),
              title: const Text(
                "Đã xóa",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Loventine-Black",
                    fontSize: 22),
              ),
              toolbarHeight: 60,
              titleSpacing: -10,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            )
          ],
          body: isLoading
              ? Column(
                  children: List.generate(
                  2,
                  (index) => Column(
                    children: [
                      Container(
                        height: 5,
                      ),
                      ShimmerPostDelete(width, height)
                    ],
                  ),
                ))
              : _postsDelete.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Không có bài đăng nào được xóa",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 19,
                              fontFamily: "Loventine-Bold",
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 5, bottom: 10, right: 15, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Gần đây nhất",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Loventine-Bold",
                                  fontSize: 18),
                            ),
                            Consumer<PostDeleteProvider>(
                              builder: (context, postsDelete, child) =>
                                  CustomScrollView(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                cacheExtent: 500.0,
                                slivers: [
                                  SliverList(
                                      delegate: SliverChildBuilderDelegate(
                                    childCount: postsDelete.postsDelete.length,
                                    (context, index) {
                                      final deletePost =
                                          postsDelete.postsDelete[index];
                                      String adviseTypeValue = deletePost
                                                  .adviseTypeValue
                                                  .toString() ==
                                              "0"
                                          ? ""
                                          : "${deletePost.adviseTypeValue}";
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: IntrinsicHeight(
                                            child: Row(
                                          children: [
                                            Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                deletePost.images.isEmpty
                                                    ? Lottie.asset(
                                                        "assets/lotties/no_photo.json",
                                                        width: 130,
                                                        height: 90,
                                                      )
                                                    : CachedNetworkImage(
                                                        imageUrl: deletePost
                                                            .images[0],
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          width: 130,
                                                          height: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            image:
                                                                DecorationImage(
                                                              image:
                                                                  imageProvider,
                                                              fit: BoxFit.cover,
                                                            ),
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xFFE0E0E0),
                                                              width: 2,
                                                            ),
                                                          ),
                                                        ),
                                                        placeholder:
                                                            (context, url) =>
                                                                Container(
                                                          width: 130,
                                                          height: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Container(
                                                          width: 130,
                                                          height: 90,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    width: 136,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      gradient: LinearGradient(
                                                        colors: [
                                                          Colors.transparent,
                                                          Colors.black
                                                              .withOpacity(0.1),
                                                          Colors.black
                                                              .withOpacity(0.3),
                                                          Colors.black
                                                              .withOpacity(0.5),
                                                          Colors.black
                                                              .withOpacity(0.7),
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    child: Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  bottom: 3),
                                                          child: Text(
                                                            "${formatTimeDifferenceDeleteRemaining(deletePost.deleteTime)} ngày",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Loventine-Regular",
                                                                color: formatTimeDifferenceDeleteRemaining(deletePost
                                                                            .deleteTime) >
                                                                        10
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .red),
                                                          ),
                                                        )))
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    deletePost.title,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "Loventine-Black",
                                                        color: AppColor
                                                            .blackColor),
                                                  ),
                                                  Text(
                                                    deletePost.content,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            "Loventine-Semibold",
                                                        color: AppColor
                                                            .blackColor),
                                                  ),
                                                  deletePost.postType == "free"
                                                      ? const Text(
                                                          "Miễn phí",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Loventine-Regular",
                                                              color: AppColor
                                                                  .deleteBubble),
                                                        )
                                                      : Text(
                                                          "Tìm freelancer\n${formatCurrency(int.parse(deletePost.price))}đ - $adviseTypeValue  ${deletePost.adviseType}",
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Loventine-Regular",
                                                              color: AppColor
                                                                  .deleteBubble),
                                                        ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        width: 5,
                                                        height: 5,
                                                        decoration:
                                                            const BoxDecoration(
                                                                color:
                                                                    Colors.blue,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          "Đã xóa ${formatTimeDifferenceDelete(deletePost.deleteTime)} ngày trước",
                                                          style: const TextStyle(
                                                              fontSize: 13,
                                                              fontFamily:
                                                                  "Loventine-Regular",
                                                              color: AppColor
                                                                  .deleteBubble),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            PopupMenuButton<int>(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                onSelected: (value) {
                                                  if (value == 1) {
                                                    Provider.of<PostDeleteProvider>(
                                                            context,
                                                            listen: false)
                                                        .restorePost(
                                                            deletePost.id,
                                                            widget.userId)
                                                        .whenComplete(() {
                                                      if (deletePost.postType ==
                                                          "fee") {
                                                        Provider.of<PostFeeProvider>(
                                                                context,
                                                                listen: false)
                                                            .getAllFeePost(
                                                                1,
                                                                true,
                                                                "",
                                                                widget.userId,
                                                                5);
                                                        ;
                                                      } else {
                                                        Provider.of<PostFreeProvider>(
                                                                context,
                                                                listen: false)
                                                            .getAllFreePostPage1(
                                                                widget.userId);
                                                      }
                                                    });
                                                  }
                                                },
                                                itemBuilder:
                                                    (BuildContext context) => [
                                                          PopupMenuItem<int>(
                                                            value: 1,
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    "assets/svgs/ArrowRotateLeft-Linear.svg"),
                                                                const Text(
                                                                  ' Khôi phục',
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        'Loventine-Bold',
                                                                    fontSize:
                                                                        15,
                                                                    color: Color(
                                                                        0xff3C3F42),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                child: const Icon(
                                                  Icons.more_horiz,
                                                  size: 20,
                                                ))
                                          ],
                                        )),
                                      );
                                    },
                                  ))
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Các bài đăng hiển thị số ngày còn lại trước khi bị xóa. Sau thời điểm đó các bài đăng sẽ bị xóa vĩnh viễn",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Color(0xFF8F8F8F),
                                fontFamily: 'Loventine-Regular',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
        ));
  }
}
