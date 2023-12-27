// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/modules/post/post_detail_screen.dart';
import 'package:loventine_flutter/providers/page/message_page/user_image_provider.dart';
import 'package:loventine_flutter/providers/post_all/bookmark_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_fee_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/custom_page_route/custom_page_route.dart';
import 'package:loventine_flutter/widgets/custom_popup_menu_button.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:loventine_flutter/widgets/shimmer_post/shimmer_post_delete.dart';

import 'package:provider/provider.dart';

import '../../../providers/page/message_page/message_page_provider.dart';

class BookmarkPage extends StatefulWidget {
  final String userName;
  const BookmarkPage({super.key, required this.userName});

  @override
  State<BookmarkPage> createState() => _BookmarkPageState();
}

class _BookmarkPageState extends State<BookmarkPage> {
  String current_user_id = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      current_user_id =
          await Provider.of<MessagePageProvider>(context, listen: false)
              .current_user_id;
      
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String formatCurrency(int amount) {
      final formatter = NumberFormat("#,###");
      return formatter.format(amount).replaceAll(',', '.');
    }

    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final avatarUrl =
        Provider.of<UserImageProvider>(context, listen: false).avatar;
    final postAllData = Provider.of<PostFeeProvider>(context, listen: false);
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
              "Đã lưu",
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
            : Consumer<PostFreeProvider>(
                builder: (context, bookmarkData, child) => 
                 SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 10, left: 15),
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
                                CustomScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  cacheExtent: 500.0,
                                  slivers: [
                                    SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                      childCount: bookmarkData.postFree.length,
                                      (context, index) {
                                        final post =
                                            bookmarkData.postFree[index];
                                        String adviseTypeValue =
                                            post.adviseTypeValue.toString() ==
                                                    "0"
                                                ? ""
                                                : "${post.adviseTypeValue}";
                                        return post.isBookmark == false
                                        ?SizedBox()
                                        :InkWell(
                                          onTap: () => post.isDelete
                                              ? CustomSnackbar.show(context,
                                                  title: "Bài viết đã bị xóa!",
                                                  type: SnackbarType.warning)
                                              : appNavigate(
                                                  context,
                                                  PostDetailScreen(
                                                    post: post,
                                                    page: 1,
                                                    userId: current_user_id,
                                                    avatar: avatarUrl,
                                                    type: "free",
                                                    userName: widget.userName,
                                                    index: index,
                                                  )),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 10),
                                            child: IntrinsicHeight(
                                                child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                post.isDelete
                                                    ? Container(
                                                        width: 130,
                                                        height: 90,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          border: Border.all(
                                                            color: const Color(
                                                                0xFFE0E0E0),
                                                            width: 2,
                                                          ),
                                                        ),
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                          child: Image.asset(
                                                            "assets/images/image_error.jpg",
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      )
                                                    : post.images.isEmpty
                                                        ? Container(
                                                            width: 130,
                                                            height: 90,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8),
                                                              border:
                                                                  Border.all(
                                                                color: const Color(
                                                                    0xFFE0E0E0),
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Lottie.asset(
                                                              "assets/lotties/no_photo.json",
                                                            ),
                                                          )
                                                        : CachedNetworkImage(
                                                            imageUrl:
                                                                post.images[0],
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
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                                border:
                                                                    Border.all(
                                                                  color: const Color(
                                                                      0xFFE0E0E0),
                                                                  width: 2,
                                                                ),
                                                              ),
                                                            ),
                                                            placeholder:
                                                                (context,
                                                                        url) =>
                                                                    Container(
                                                              width: 130,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                            errorWidget:
                                                                (context, url,
                                                                        error) =>
                                                                    Container(
                                                              width: 130,
                                                              height: 90,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                post.isDelete
                                                    ? const Expanded(
                                                        child: Text(
                                                          "Mục này đã bị xóa!",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  "Loventine-Black",
                                                              color: AppColor
                                                                  .blackColor),
                                                        ),
                                                      )
                                                    : Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              post.title,
                                                              style: const TextStyle(
                                                                  fontSize: 16,
                                                                  fontFamily:
                                                                      "Loventine-Black",
                                                                  color: AppColor
                                                                      .blackColor),
                                                            ),
                                                            Text(
                                                              post.content,
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: const TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      "Loventine-Semibold",
                                                                  color: AppColor
                                                                      .blackColor),
                                                            ),
                                                            post.postType ==
                                                                    "free"
                                                                ? Text(
                                                                    "Miễn phí • ${post.name}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            "Loventine-Regular",
                                                                        color: AppColor
                                                                            .deleteBubble),
                                                                  )
                                                                : Text(
                                                                    "Tìm freelancer • ${post.name}\n${formatCurrency(int.parse(post.price))}đ - $adviseTypeValue  ${post.adviseType}",
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontFamily:
                                                                            "Loventine-Regular",
                                                                        color: AppColor
                                                                            .deleteBubble),
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                CustomPopupMenuButton(
                                                  nameMe: widget.userName,
                                                  userId: current_user_id,
                                                  postId: post.id,
                                                  authorId: post.userId,
                                                  index: index,
                                                  postType: "bookmark",
                                                  isPublic: post.isPublic,
                                                  isBookmark: post.isBookmark,
                                                  bookmarkId: "",
                                                  isDetail: false,
                                                  update: (p0, p1) {},
                                                )
                                              ],
                                            )),
                                          ),
                                        );
                                      },
                                    ))
                                  ],
                                ),
                              ]),
                        ),
                      ),
              ),
      ),
    );
  }
}
