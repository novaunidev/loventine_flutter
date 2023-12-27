// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/animation/like_effect.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/models/comment.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/modules/post/free_post/widgets/comment_box.dart';
import 'package:loventine_flutter/modules/post/post_detail_screen.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/user_image_provider.dart';
import 'package:loventine_flutter/providers/post_all/bookmark_provider.dart';
import 'package:loventine_flutter/providers/post_all/like_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_of_user_provider.dart';
import 'package:loventine_flutter/services/notification/notification_service.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_icon.dart';
import 'package:loventine_flutter/widgets/bottom_sheet_information.dart';
import 'package:loventine_flutter/widgets/bottom_sheet_login.dart';
import 'package:loventine_flutter/widgets/custom_popup_menu_button.dart';
import 'package:loventine_flutter/widgets/custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:loventine_flutter/widgets/inkwell/inkwell_profile.dart';
import 'package:loventine_flutter/widgets/list_images.dart';
import 'package:loventine_flutter/widgets/shimmer_post/shimmer_post_free.dart';
import 'package:loventine_flutter/widgets/user_information/name_user_current.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';
import '../../models/hives/count_app.dart';
import '../../providers/information_provider.dart';
import '../../providers/network_info.dart';
import '../../providers/notification/notification_provider.dart';
import '../../providers/page/message_page/card_profile_provider.dart';
import '../../providers/post_all/post_free_provider.dart';
import '../../widgets/cupertino_bottom_sheet/src/bottom_sheets/cupertino_bottom_sheet.dart';
import '../../widgets/ios_custom_scroll_bounc_clamp.dart';
import '../../widgets/navigation_drawer_profile.dart';
import '../../widgets/user_information/avatar_widget.dart';
import '../../widgets/user_information/name_verified.dart';
import '../../widgets/user_name_shortener.dart';
import 'free_post/widgets/avatar_cmt.dart';
import 'free_post/widgets/comment_box_offline.dart';
import '/providers/page/home_page_provider.dart';

class FreePostAllPage extends StatefulWidget {
  const FreePostAllPage({
    super.key,
  });

  @override
  State<FreePostAllPage> createState() => _FreePostAllPageState();
}

class _FreePostAllPageState extends State<FreePostAllPage> {
  ScrollController controllerPagination = ScrollController();
  bool hasMore = true;
  int page = 2;
  bool isLoading = true;
  List<PostAll> postFree = [];
  bool _showAppbar = true;
  late final HomePageProvider _homePageProvider;
  bool isScrollingDown = false;
  final _offsetToArmed = 120.0;
  bool isSignUp = false;
  bool _showLike = false;
  late Offset _tapPosition;
  int indexDoubleTap = 0;
  String avatar_cloundinary_public_id = "";
  bool isLogin = false;
  ValueNotifier<bool> isLoadNotifier = ValueNotifier(false);
  String avatarUrl = "https://res.cloudinary.com/dc8kxjddi/image/upload/v1676186304/avatar_man_oicegg.gif";
  late String current_user_id = '';
  getOnboarding() async {
    final box = Hive.box<CountApp>('countBox');
    // box.clear();
    CountApp? count = box.get('countOnboarding');
    bool countOnboarding;

    if (count == null) {
      countOnboarding = false;
    } else {
      countOnboarding = count.countOnboarding!;
    }

    if (countOnboarding == false) {
      box.put('countOnboarding', CountApp(countOnboarding: true));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 390), () {
          showBottomSheetLogin(context, 1);
        });
      });
    }
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _homePageProvider = Provider.of<HomePageProvider>(context, listen: false);
    _homePageProvider.controllerPagination = controllerPagination;
    _homePageProvider.myScroll();
    nameUserCurrent(context);
    isLogin = Provider.of<MessagePageProvider>(context, listen: false).isLogin;
    getOnboarding();
    final countBox = Hive.box<CountApp>('countBox');
    CountApp? count = countBox.get('countOnboarding');
    if (count == null) {
      showBottomSheetLogin(context, 1);
    }

    isSignUp =
        Provider.of<InformationProvider>(context, listen: false).isSignUp;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (isSignUp) {
        showBottomSheetInformations(context);
        Provider.of<InformationProvider>(context, listen: false)
            .setIsSignUpFalse();
      }
      current_user_id =
          await Provider.of<MessagePageProvider>(context, listen: false)
              .current_user_id;
      await Provider.of<PostFreeProvider>(context, listen: false)
          .getAllFreePost(1, true, current_user_id);
      avatarUrl = Provider.of<UserImageProvider>(context, listen: false).avatar;

      postFree = Provider.of<PostFreeProvider>(context, listen: false).postFree;
      if (postFree.isNotEmpty) {
        setState(() {
          isLoading = false;
        });
      }
      isLogin =
          Provider.of<MessagePageProvider>(context, listen: false).isLogin;
      current_user_id =
          await Provider.of<MessagePageProvider>(context, listen: false)
              .current_user_id;
      await Provider.of<CardProfileProvider>(context, listen: false)
          .fetchCurrentUser(current_user_id);
      Provider.of<LikeProvider>(context, listen: false).getAllLike();
      Provider.of<BookmarkProvider>(context, listen: false).getAllIdBookmark(current_user_id);    
      // await Provider.of<UserImageProvider>(context, listen: false)
      //     .getAllUserImage(current_user_id);
      avatarUrl = Provider.of<CardProfileProvider>(context, listen: false).user.avatarUrl ?? "";
      avatar_cloundinary_public_id =
          Provider.of<UserImageProvider>(context, listen: false)
              .avatar_cloudinary_public_id;
      await Provider.of<MessagePageProvider>(context, listen: false)
          .setAvatarUrl(avatarUrl, avatar_cloundinary_public_id);
      // Provider.of<NotificationProvider>(context, listen: false).init();
      setState(() {
        
      });
    });

    controllerPagination.addListener(() {
      // Kiểm tra nếu người dùng kéo xuống cuối trang
      if (controllerPagination.position.pixels ==
          controllerPagination.position.maxScrollExtent) {
        // fetch();
      }
      final direction = controllerPagination.position.userScrollDirection;
      if (direction == ScrollDirection.reverse) {
        if (!isScrollingDown) {
          setState(() {
            isScrollingDown = true;
            _showAppbar = false;
          });
        }
      }
      if (direction == ScrollDirection.forward) {
        if (isScrollingDown) {
          setState(() {
            isScrollingDown = false;
            _showAppbar = true;
          });
        }
      }
    });
  }

  //Get phân trang
  fetch() async {
    isLoadNotifier.value = true;
    var provider = Provider.of<PostFreeProvider>(context, listen: false);
    await provider.getAllFreePost(page, false, current_user_id);
    if (!provider.isGet) {
      setState(() {
        hasMore = false;
      });
    } else {
      page++;
      isLoadNotifier.value = false;
    }
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final userCurrent =
        Provider.of<CardProfileProvider>(context, listen: false).user;
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    final postFreeProvider =
        Provider.of<PostFreeProvider>(context, listen: false);
    final postFreeUserProvider =
        Provider.of<PostFreeOfUserProvider>(context, listen: false);
    final bookMarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    Future<void> onLikeDoubleTapped(PostAll post) async {
      if (isLogin) {
        final result = await Connectivity().checkConnectivity();
        if (result != ConnectivityResult.none) {
          print(post.isLike);
          if (post.isLike == false) {
            likeProvider.addLike(post.id, current_user_id);
            postFreeProvider.updateLikeInFreePost(post.id, true);
            postFreeProvider.updateLikeInFreePost1(post.id, true);
            postFreeUserProvider.updateLikeInFreePostofUser(post.id, true);
            bookMarkProvider.updateLikeInBookmarkPost(post.id, true);
          }
        }
      } else {
        showBottomSheetLogin(context, 2);
      }
    }

    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: ValueListenableBuilder<bool>(
            valueListenable: _homePageProvider.showAppbar,
            builder: (context, showAppbarValue, child) {
              return AnimatedContainer(
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.decelerate,
                  height: showAppbarValue
                      ? Platform.isIOS
                          ? 100
                          : Platform.isAndroid
                              ? 80
                              : 55
                      : 0,
                  child: AppBar(
                    backgroundColor: Colors.white.withAlpha(200),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(5),
                      child: Container(
                          color: Colors.white.withAlpha(100), height: 1),
                    ),
                    elevation: 0,
                    // flexibleSpace: ClipRect(
                    //   child: BackdropFilter(
                    //     filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    //     child: Container(
                    //       color: Colors.transparent,
                    //     ),
                    //   ),
                    // ),
                    automaticallyImplyLeading: false,
                    title: isLogin
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () =>
                                          _key.currentState!.openDrawer(),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            "assets/svgs/logo_name.svg",
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // NavigationDrawerProfile(
                                      //   user: userCurrent,
                                      //   userId: current_user_id,
                                      // );
                                      // Provider.of<NotificationProvider>(context,
                                      //         listen: false)
                                      //     .init();
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             NavigationDrawerProfile(
                                      //               user: userCurrent,
                                      //               userId: current_user_id,
                                      //             )));
                                    },
                                    child: Stack(
                                      children: [
                                        CircleAvatar(
                                          radius: 21,
                                          backgroundColor: Color(0xffe4e6eb),
                                          child: SvgPicture.asset(
                                            'assets/svgs/notification.svg',
                                            height: 25,
                                            color: const Color(0xff050505),
                                          ),
                                        ),
                                        Visibility(
                                          visible: NotificationService
                                                  .num_notification_unwatch >
                                              0,
                                          child: Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 2),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColor.redColor,
                                              ),
                                              constraints: const BoxConstraints(
                                                minWidth: 15,
                                                minHeight: 15,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  NotificationService
                                                              .num_notification_unwatch <=
                                                          99
                                                      ? NotificationService
                                                          .num_notification_unwatch
                                                          .toString()
                                                      : '99+',
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        "Loventine-Semibold",
                                                    fontSize: 10,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color:
                                            AppColor.mainColor.withOpacity(0.2),
                                        width: 2.5,
                                      ),
                                    ),
                                    child: InkWell(
                                      onTap: () =>
                                          _key.currentState!.openDrawer(),
                                      child: const AvatarWidget(
                                        size: 39,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              SvgPicture.asset(
                                "assets/svgs/logo_name.svg",
                                height: 30,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () => showBottomSheetLogin(context, 2),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: AppColor.mainColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: const Text(
                                    "Đăng nhập",
                                    style: TextStyle(
                                      fontFamily: 'Loventine-Semibold',
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ));
            }),
      ),
      drawer: NavigationDrawerProfile(
        user: userCurrent,
        userId: current_user_id,
      ),
      drawerScrimColor: Colors.transparent,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [],
        body: CustomRefreshIndicator(
          onRefresh: () => Future.delayed(
            // Sử dụng Duration để thực hiện việc refresh sau một khoảng thời gian nhất định
            const Duration(microseconds: 500),
            () async {
              await Provider.of<PostFreeProvider>(context, listen: false)
                  .getAllFreePost(1, true, current_user_id);
              // Các xử lý khác sau khi đã refresh lại API
              setState(() {
                page = 2;
                hasMore = true;
              });
            },
          ),
          offsetToArmed: _offsetToArmed,
          builder: (context, child, controller) => AnimatedBuilder(
            animation: controller,
            child: child,
            builder: (context, index) {
              // Kiểm tra xem người dùng có đang kéo để refresh hay không
              bool isPullingDown = controller.value > 0.01;
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  if (isPullingDown) // Chỉ hiển thị khi đang kéo xuống
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: SizedBox(
                        width: double.infinity > 330 ? 330 : double.infinity,
                        height: _offsetToArmed * controller.value,
                        child: const RiveAnimation.asset(
                          "assets/rives/load.riv",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  Transform.translate(
                    offset: Offset(0.0, _offsetToArmed * controller.value),
                    child: child,
                  ),
                ],
              );
            },
          ),
          child: CustomScrollView(
            physics: const IOSCustomScrollBouncClamp(),
            controller: controllerPagination,
            cacheExtent: 100,
            slivers: <Widget>[
              // Hiển thị loading animation khi isLoading là true
              if (isLoading)
                SliverToBoxAdapter(
                    child: Column(
                  children: List.generate(
                    3,
                    (index) => Column(
                      children: [
                        Container(height: 5),
                        ShimmerFreeLoading(width, height),
                      ],
                    ),
                  ),
                ))
              else
                Consumer<PostFreeProvider>(
                  builder: (context, postAllData, _) => SliverList(
                    delegate: SliverChildBuilderDelegate(
                        childCount: postAllData.postFree.length,
                        (context, index) {
                      PostAll post = postAllData.postFree[index];
                      return post.isDelete == true
                      ?SizedBox()
                      :GestureDetector(
                          onDoubleTapDown: (details) {
                            setState(() {
                              _tapPosition = details.localPosition;
                              _showLike = true;
                              indexDoubleTap = index;
                            });
                            onLikeDoubleTapped(post);
                          },
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostDetailScreen(
                                        post: postAllData.postFree[index],
                                        userId: current_user_id,
                                        avatar: avatarUrl,
                                        page: page - 1,
                                        type: "free",
                                        userName: userCurrent.name,
                                        index: index,
                                      )),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.white,
                                child: FreePostItem(
                                  post: post,
                                  userId: current_user_id,
                                  userName: userCurrent.name,
                                  avatar: avatarUrl,
                                  index: index,
                                  type: "free",
                                ),
                              ),
                              if (_showLike && indexDoubleTap == index)
                                LikeEffect(
                                  onCompleted: (value) => setState(() {
                                    _showLike = value;
                                  }),
                                  top: _tapPosition.dy,
                                  left: _tapPosition.dx,
                                ),
                            ],
                          ));
                    }),
                  ),
                ),
              // Hiển thị thông báo hoặc loading animation khi cuộn đến cuối danh sách
              SliverToBoxAdapter(
                child: isLoading
                    ? const SizedBox()
                    : hasMore
                        ? ValueListenableBuilder<bool>(
                            valueListenable: isLoadNotifier,
                            builder: (context, isLoad, child) {
                              return isLoad
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 70),
                                      child: Lottie.asset(
                                        'assets/lotties/load_post.json',
                                        height: 60,
                                      ),
                                    )
                                  : const SizedBox();
                            },
                          )
                        : Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 50),
                            child: Text(
                              "${userCurrent.name} ơi! Bạn đã xem hết bài viết rồi🤗",
                              style: TextStyle(
                                fontFamily: 'Loventine-Regular',
                                fontSize: 15,
                                color: const Color.fromARGB(255, 0, 0, 0)
                                    .withOpacity(0.5),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FreePostItem extends StatefulWidget {
  final PostAll post;
  final String userId;
  final String avatar;
  final String userName;
  final int index;
  final String type;
  const FreePostItem(
      {super.key,
      required this.post,
      required this.userId,
      required this.avatar,
      required this.userName,
      required this.index,
      required this.type});

  @override
  State<FreePostItem> createState() => _FreePostItemState();
}

class _FreePostItemState extends State<FreePostItem> {
  final _dio = Dio();
  List<String> userComment = [];
  List<Comment> commentAll = [];
  Future<void> getAllCommentsOfAPost(String postId) async {
    try {
      var result =
          await _dio.get("$urlComments/post/$postId");
      List<dynamic> data = result.data as List<dynamic>;
      commentAll = [];
      for (int i = 0; i < data.length; i++) {
        final userCommentId = data[i]["userCommentId"];
        final response = await Dio().get('$urlUsers/$userCommentId');
        commentAll.add(Comment.toComment(data[i] as Map<String, dynamic>, response.data));
      }
      userComment = [];
      Set<String> _userComment = Set<String>.from(
          commentAll.map((comment) => comment.avatarUserCommentId));
      if (_userComment.length < 4) {
        userComment = _userComment.toList();
      } else {
        userComment = _userComment.take(3).toList();
      }
      userComment = userComment.reversed.toList();
    } catch (e) {
      userComment = [];
      print(e);
    }
  }

  Future<void> initializeComments() async {
    await getAllCommentsOfAPost(widget.post.id);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeComments();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IntrinsicHeight(
          child: Stack(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 10, top: 9),
                  child: AvatarCmt(
                    userId: widget.post.userId,
                    isMe: widget.post.userId == widget.userId,
                    postId: widget.post.id,
                    avatar: widget.post.avatar,
                    isPuclic: widget.post.isPublic,
                    userComment: userComment,
                    online: widget.post.online,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameAndtimeFree(widget.post, widget.userName, widget.userId,
                      widget.index, widget.type, context),
                  titleFree(widget.post),
                  descriptionFree(widget.post),
                  ListImages(post: widget.post, indexColumn: widget.index),
                  ReplyAndLike(
                    post: widget.post,
                    userId: widget.userId,
                    avatar: widget.avatar,
                    type: widget.type,
                    countComment: commentAll.length,
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(color: AppColor.borderButton),
      ],
    );
  }
}

String agePost(PostAll post) {
  String age = "";
  if (post.userAge != "") {
    final birthDay = post.userAge;
    DateTime birthDay0 = DateFormat("dd/MM/yyyy").parse(birthDay);
    Duration age0 = DateTime.now().difference(birthDay0);
    age = (age0.inDays / 365.25).floor().toString();
  }
  return age;
}

Widget nameAndtimeFree(PostAll post, String nameMe, String userId, int index,
    String postType, BuildContext context) {
  final isLogin =
      Provider.of<MessagePageProvider>(context, listen: false).isLogin;

  return Padding(
    padding: const EdgeInsets.only(left: 60),
    child: Row(
      children: [
        InkWellProfile(
          avatar: post.avatar,
          userId: post.userId,
          isMe: post.userId == userId,
          child: NameVerified(
            name: formatUserName(post.name),
            isVerified: post.verified,
          ),
        ),
        Text(
          agePost(post) == "" ? "" : " • ${agePost(post)}",
          style: const TextStyle(
            fontFamily: 'Loventine-Semibold',
            color: AppColor.blackColor,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        Row(
          children: [
            Text(
              post.userAddress,
              style: const TextStyle(
                color: AppColor.blackColor,
                fontFamily: 'Loventine-Regular',
                fontSize: 14,
              ),
            ),
            isLogin
                ? CustomPopupMenuButton(
                    nameMe: nameMe,
                    userId: userId,
                    postId: post.id,
                    authorId: post.userId,
                    index: index,
                    postType: postType,
                    isPublic: post.isPublic,
                    isBookmark: post.isBookmark,
                    bookmarkId: "",
                    isDetail: false,
                    update: (p0, p1) {},
                  )
                : AppIcon(
                    path: "assets/svgs/more.svg",
                    onTap: () {
                      showBottomSheetLogin(context, 2);
                    },
                  )
          ],
        ),
      ],
    ),
  );
}

Widget titleFree(PostAll post) {
  return Padding(
    padding: const EdgeInsets.only(left: 60, bottom: 8, top: 5),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
          color: AppColor.mainColor, borderRadius: BorderRadius.circular(20)),
      child: Text(
        post.title,
        style: const TextStyle(
          fontFamily: 'Loventine-Semibold',
          color: Colors.white,
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

Widget descriptionFree(PostAll post) {
  return Expanded(
    child: Padding(
      padding: const EdgeInsets.only(right: 8.0, left: 60, bottom: 7),
      child: Text(
        maxLines: 7, // Giới hạn hiển thị tối đa 7 dòng
        overflow:
            TextOverflow.ellipsis, // Hiển thị dấu "..." khi văn bản bị cắt bỏ
        post.content,
        style: const TextStyle(
          fontFamily: 'Loventine-Regular',
          fontSize: 15,
          color: Color(0xff3C3F42),
        ),
      ),
    ),
  );
}

class ReplyAndLike extends StatefulWidget {
  final PostAll post;
  final String userId;
  final String avatar;
  final String type;
  final int countComment;
  const ReplyAndLike(
      {super.key,
      required this.post,
      required this.userId,
      required this.avatar,
      required this.type,
      required this.countComment});

  @override
  State<ReplyAndLike> createState() => _ReplyAndLikeState();
}

class _ReplyAndLikeState extends State<ReplyAndLike> {
  bool isLogin = false;
  bool isLike = false;
  int likeCounts = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = Provider.of<MessagePageProvider>(context, listen: false).isLogin;
    isLike = widget.post.isLike;
    likeCounts = widget.post.likeCounts;
  }

  @override
  void didUpdateWidget(covariant ReplyAndLike oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post != widget.post) {
      isLike = widget.post.isLike;
      likeCounts = widget.post.likeCounts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final networkInfo = Provider.of<NetworkInfo>(context);
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    final postFreeProvider =
        Provider.of<PostFreeProvider>(context, listen: false);
    final postFreeUserProvider =
        Provider.of<PostFreeOfUserProvider>(context, listen: false);
    final bookMarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      if (isLogin) {
        final result = await Connectivity().checkConnectivity();
        if (result != ConnectivityResult.none) {
          isLike
              ? {
                  setState(() {
                    isLike = false;
                    likeCounts -= 1;
                  }),
                  likeProvider.deleteLike(widget.post.id, widget.userId),
                  postFreeProvider.updateLikeInFreePost(widget.post.id, false),
                  postFreeProvider.updateLikeInFreePost1(widget.post.id, false),
                  postFreeUserProvider.updateLikeInFreePostofUser(
                      widget.post.id, false),
                  bookMarkProvider.updateLikeInBookmarkPost(
                      widget.post.id, false)
                }
              : {
                  setState(() {
                    isLike = true;
                    likeCounts += 1;
                  }),
                  likeProvider.addLike(widget.post.id, widget.userId),
                  postFreeProvider.updateLikeInFreePost(widget.post.id, true),
                  postFreeProvider.updateLikeInFreePost1(widget.post.id, true),
                  postFreeUserProvider.updateLikeInFreePostofUser(
                      widget.post.id, true),
                  bookMarkProvider.updateLikeInBookmarkPost(
                      widget.post.id, true)
                };
        }
      } else {
        showBottomSheetLogin(context, 2);
      }

      return !isLiked;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 60, top: 15),
          child: Row(
            children: [
              LikeButton(
                size: 26,
                isLiked: isLike,
                circleColor: const CircleColor(
                    start: AppColor.mainColor, end: AppColor.mainColor),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: AppColor.mainColor,
                  dotSecondaryColor: AppColor.mainColor,
                ),
                likeBuilder: (bool isLiked) {
                  return SvgPicture.asset(
                    "assets/svgs/heart-circle.svg",
                    color: isLike ? AppColor.mainColor : AppColor.blackColor,
                  );
                },
                onTap: onLikeButtonTapped,
              ),
              const SizedBox(
                width: 10,
              ),
              InkWell(
                  onTap: () async {
                    final result = networkInfo.connectionStatus;
                    showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.transparent,
                      builder: (context) => result != ConnectivityResult.none
                          ? CommentBox(
                              postId: widget.post.id,
                              userId: widget.userId,
                              avatar: widget.avatar,
                              userPostId: widget.post.userId,
                              post: widget.post,
                            )
                          : const CommentBoxOffline(),
                    );
                  },
                  child: SvgPicture.asset(
                    "assets/svgs/message_bulk.svg",
                    height: 24.5,
                    color: AppColor.deleteBubble,
                  ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 60, top: 10, bottom: 5),
          child: Row(
            children: [
              Text(
                "$likeCounts lượt thích • ",
                style: const TextStyle(
                  fontFamily: 'Loventine-Regular',
                  color: Color(0xffA1A1A1),
                ),
              ),
              Text(
                "${widget.countComment} trả lời",
                style: const TextStyle(
                  fontFamily: 'Loventine-Regular',
                  color: Color(0xffA1A1A1),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
      ],
    );
  }
}
