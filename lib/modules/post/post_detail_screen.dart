// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:like_button/like_button.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/modules/post/free_post/widgets/comment_box.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/providers/post_all/bookmark_provider.dart';
import 'package:loventine_flutter/providers/post_all/like_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_icon.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/bottom_sheet_login.dart';
import 'package:loventine_flutter/widgets/custom_popup_menu_button.dart';
import 'package:loventine_flutter/widgets/inkwell/inkwell_profile.dart';
import 'package:loventine_flutter/widgets/user_information/name_verified.dart';
import 'package:loventine_flutter/widgets/user_name_shortener.dart';
import 'package:provider/provider.dart';

import '../../models/comment.dart';
import '../../providers/network_info.dart';
import '../../providers/post_all/comment_provider.dart';
import '../../providers/post_all/post_free_of_user_provider.dart';
import '../../providers/post_all/post_free_provider.dart';

import '../../widgets/custom_snackbar.dart';
import '../../widgets/list_images.dart';
import '../../widgets/shimmer_loading/shimmer.dart';
import '../../widgets/user_information/avatar_widget.dart';
import 'free_post_all_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostDetailScreen extends StatefulWidget {
  final PostAll post;
  final String userId;
  final String avatar;
  final String userName;
  final int index;
  final int page;
  final String type;
  const PostDetailScreen(
      {super.key,
      required this.post,
      required this.userId,
      required this.avatar,
      required this.page,
      required this.type,
      required this.userName,
      required this.index});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  List<Comment> commentAll = [];
  List<Comment> commentPost = [];
  List<Comment> commentComment = [];
  bool isLoading = true;
  final _dio = Dio();
  String repName = "";
  String currentParentCommentId = "";
  late ConnectivityResult result;
  final _commentController = TextEditingController();
  bool _isTextEmpty = true;
  bool isConnect = false;
  ScrollController scrollController = ScrollController();
  bool isChange = false;
  bool isLogin = false;
  bool isLoadingBtn = false;
  bool _isTyping = false;
  FocusNode _commentFocusNode = FocusNode();
  bool _isPublic = false;
  bool _isBookmark = false;
  @override
  void initState() {
    super.initState();
    _isPublic = widget.post.isPublic;
    _isBookmark = widget.post.isBookmark;
    isLogin = Provider.of<MessagePageProvider>(context, listen: false).isLogin;
    _commentController.addListener(_onTextChanged);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeComments();
      startStreaming();
    });
  }

  Future<bool> isHateSpeech(String text) async {
    final response = await http.post(
      Uri.parse(hateSpeechUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': _commentController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['is_hate_speech'];
    } else {
      // Handle error or return a default value
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }

  startStreaming() {
    NetworkInfo networkInfo = NetworkInfo();
    networkInfo.onConnectivityChangedCallback = () => checkInternet();
  }

  void _onTextChanged() {
    setState(() {
      _isTextEmpty = _commentController.text.isEmpty;
    });
  }

  Future<void> checkInternet() async {
    result = Provider.of<NetworkInfo>(context, listen: false).connectionStatus;
    if (result != ConnectivityResult.none) {
      setState(() {
        isConnect = true;
      });
      initializeComments();
    } else {
      setState(() {
        isConnect = false;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> initializeComments() async {
    await getAllCommentsOfAPost(widget.post.id);
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      isConnect = true;
      isLoading = false;
    });
  }

  Future<void> getAllCommentsOfAPost(String postId) async {
    try {
      var result = await _dio.get("$urlComments/post/$postId");

      List<dynamic> data = result.data as List<dynamic>;
      commentAll = [];
      for (int i = 0; i < data.length; i++) {
        final userCommentId = data[i]["userCommentId"];
        final response = await Dio().get('$urlUsers/$userCommentId');
        commentAll.add(
            Comment.toComment(data[i] as Map<String, dynamic>, response.data));
      }

      // Lấy danh sách bài đăng có chứa "postType" = "fee"
      commentPost = widget.post.isPublic
          ? commentAll.where((comment) => comment.replyType == "post").toList()
          : widget.post.userId == widget.userId
              ? commentAll
                  .where((comment) => comment.replyType == "post")
                  .toList()
              : commentAll
                  .where((comment) =>
                      comment.replyType == "post" &&
                      comment.userCommentId == widget.userId)
                  .toList();
      commentComment = commentAll
          .where((comment) => comment.replyType == "comment")
          .toList();
    } catch (e) {
      commentAll = [];
      print(e);
    }
    // notifyListeners();
  }

  Shimmer commentBoxLoading() {
    return Shimmer.fromColors(
      period: const Duration(seconds: 2),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          shimmerWidget(40, 110),
          shimmerWidget(45, 140),
          shimmerWidget(60, 90),
          shimmerWidget(60, 190),
          shimmerWidget(40, 190),
        ],
      ),
    );
  }

  Widget shimmerWidget(double height, double width) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.sizeOf(context).width;
    return Scaffold(
      bottomSheet: isConnect == false
          ? const SizedBox()
          : isLogin
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        height: 1,
                        width: double.infinity,
                        color: AppColor.borderButton),
                    AnimatedContainer(
                      height: repName == "" ? 0 : 30.0,
                      duration: const Duration(milliseconds: 200),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 30, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RichText(
                              text: TextSpan(
                                style: AppText.contentRegular(),
                                children: <TextSpan>[
                                  const TextSpan(text: 'Đang trả lời '),
                                  TextSpan(
                                    text: repName,
                                    style: AppText.contentRegular(
                                        fontFamily: "Loventine-Semibold"),
                                  ),
                                ],
                              ),
                            ),
                            (repName != "")
                                ? IconButton(
                                    onPressed: () => setState(() {
                                      repName = "";
                                    }),
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColor.blackColor,
                                      size: 16.0,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 200.0,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            width: displayWidth * 0.9,
                            decoration: BoxDecoration(
                              color: const Color(0xffeeeeee),
                              borderRadius: BorderRadius.circular(40),
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                            padding: const EdgeInsets.fromLTRB(5, 5, 10, 5),
                            child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeInOut,
                                  height: _isTyping ? 0 : 30,
                                  child: _isTyping
                                      ? const SizedBox(
                                          width: 5,
                                        )
                                      : const AvatarWidget(
                                          size: 30,
                                        ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: TextField(
                                    enabled: !isLoadingBtn,
                                    controller: _commentController,
                                    focusNode: _commentFocusNode,
                                    cursorColor: AppColor.mainColor,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    onChanged: (text) {
                                      setState(() {
                                        _isTyping = text.trim().isNotEmpty;
                                      });
                                    },
                                    style: AppText.contentRegular(),
                                    decoration: InputDecoration.collapsed(
                                        hintText: 'Viết bình luận...',
                                        hintStyle: AppText.contentRegular(
                                            color: AppColor.iconColor)),
                                  ),
                                ),
                                _isTextEmpty
                                    ? const SizedBox()
                                    : InkWell(
                                        onTap: () async {
                                          if (!await isHateSpeech(
                                              'yourTextHere')) {
                                            if (isLoadingBtn == false) {
                                              setState(() {
                                                isLoadingBtn = true;
                                                _isTyping = false;
                                              });
                                              final result =
                                                  await Connectivity()
                                                      .checkConnectivity();
                                              if (result !=
                                                  ConnectivityResult.none) {
                                                repName == ""
                                                    ? CommentProvider()
                                                        .addComment(
                                                            widget.post.id,
                                                            widget.userId,
                                                            "658bc259dc7db7f924462d4a",
                                                            DateTime.now()
                                                                .toString(),
                                                            "post",
                                                            _commentController
                                                                .text,
                                                            widget.post.userId)
                                                        .whenComplete(() {
                                                        _commentController
                                                            .clear();
                                                        initializeComments();
                                                        scrollController
                                                            .animateTo(
                                                          scrollController
                                                              .position
                                                              .maxScrollExtent,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          curve:
                                                              Curves.easeInOut,
                                                        );
                                                        setState(() {
                                                          isLoadingBtn = false;
                                                          _isTyping = false;
                                                        });
                                                      })
                                                    : CommentProvider()
                                                        .addComment(
                                                            widget.post.id,
                                                            widget.userId,
                                                            currentParentCommentId,
                                                            DateTime.now()
                                                                .toString(),
                                                            "comment",
                                                            _commentController
                                                                .text,
                                                            "")
                                                        .whenComplete(() {
                                                        _commentController
                                                            .clear();
                                                        initializeComments();
                                                        setState(() {
                                                          isLoadingBtn = false;
                                                          _isTyping = false;
                                                        });
                                                      });
                                              } else {}
                                            }
                                          } else {
                                            CustomSnackbar.show(context,
                                                title: "Không được phép đăng!",
                                                message:
                                                    "Do từ ngữ không phù hợp",
                                                type: SnackbarType.failure);
                                          }
                                        },
                                        child: isLoadingBtn
                                            ? Text("Đang viết...",
                                                textAlign: TextAlign.center,
                                                style: AppText.describeText())
                                            : SvgPicture.asset(
                                                "assets/svgs/send-1.svg",
                                                height: 27,
                                                color: AppColor.chatBubble,
                                              ),
                                      ),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  height: 40,
                  color: Colors.black87,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showBottomSheetLogin(context, 2);
                        },
                        child: const Text(
                          "Đăng nhập",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Text(
                        " để thực hiện bình luận và thả cảm xúc",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Quay lại",
          style: AppText.contentRegular(),
        ),
        titleSpacing: 0,
        leadingWidth: 40,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop(isChange);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  InkWellProfile(
                    avatar: widget.post.avatar,
                    userId: widget.post.userId,
                    isMe: widget.post.userId == widget.userId,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(widget.post.avatar),
                        ),
                        if (widget.post.online)
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(0xff68c85a),
                              border: Border.all(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: displayWidth - 65,
                        child: Row(
                          children: [
                            InkWellProfile(
                              avatar: widget.post.avatar,
                              userId: widget.post.userId,
                              isMe: widget.post.userId == widget.userId,
                              child: NameVerified(
                                name: formatUserName(widget.post.name),
                                isVerified: widget.post.verified,
                              ),
                            ),
                            Text(
                              agePost(widget.post) == ""
                                  ? ""
                                  : " • ${agePost(widget.post)}",
                              style: const TextStyle(
                                fontFamily: 'Loventine-Semibold',
                                color: AppColor.blackColor,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Spacer(),
                            Text(
                              widget.post.userAddress,
                              style: const TextStyle(
                                color: AppColor.blackColor,
                                fontFamily: 'Loventine-Regular',
                                fontSize: 14,
                              ),
                            ),
                            isLogin
                                ? CustomPopupMenuButton(
                                    paddingRight: 7,
                                    nameMe: widget.userName,
                                    userId: widget.userId,
                                    postId: widget.post.id,
                                    authorId: widget.post.userId,
                                    index: widget.index,
                                    postType: widget.type,
                                    isPublic: _isPublic,
                                    isBookmark: _isBookmark,
                                    bookmarkId: "",
                                    isDetail: true,
                                    post: widget.post,
                                    update: (p0, p1) {
                                      setState(() {
                                        _isBookmark = p0;
                                        _isPublic = p1;
                                      });
                                    },
                                  )
                                : AppIcon(
                                    path: "assets/svgs/more.svg",
                                    onTap: () {
                                      showBottomSheetLogin(context, 2);
                                    },
                                  ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          widget.post.title,
                          style: const TextStyle(
                            fontFamily: 'Loventine-Semibold',
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                widget.post.content,
                style: AppText.contentRegular(),
              ),
            ),
            ListImages(
              post: widget.post,
              indexColumn: widget.index,
              paddingLeft: 10,
            ),
            ReplyAndLikeInPostDetail(
              post: widget.post,
              userId: widget.userId,
              avatar: widget.avatar,
              page: widget.page,
              isLogin: isLogin,
              type: widget.type,
              commentFocusNode: _commentFocusNode,
              countComment: commentAll.length,
              isChange: (p0) {
                setState(() {
                  isChange = p0;
                });
              },
            ),
            const Divider(color: AppColor.borderButton),
            isConnect == false
                ? commentBoxLoading()
                : isLoading == true
                    ? commentBoxLoading()
                    : commentAll.isEmpty
                        ? Center(
                            child: Text("Hãy là người đầu tiên bình luận",
                                style: AppText.describeText()),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: ListView.builder(
                              itemCount: commentPost.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CommentItem(
                                  commentAll: commentAll,
                                  commentPost: commentPost[index],
                                  commentComment: commentComment,
                                  onInitializeComments: initializeComments,
                                  userId: widget.userId,
                                  last: commentPost.last == commentPost[index],
                                  isLogin: isLogin,
                                  userPostId: widget.post.userId,
                                  repComment: (value, parentCommentId, userId) {
                                    print(parentCommentId);
                                    setState(() {
                                      userId == widget.userId
                                          ? repName = "chính mình"
                                          : repName = value;
                                      currentParentCommentId = parentCommentId;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

class ReplyAndLikeInPostDetail extends StatefulWidget {
  final PostAll post;
  final String userId;
  final String avatar;
  final int page;
  final bool isLogin;
  final String type;
  final Function(bool) isChange;
  final FocusNode commentFocusNode;
  final int countComment;
  const ReplyAndLikeInPostDetail(
      {super.key,
      required this.post,
      required this.userId,
      required this.avatar,
      required this.page,
      required this.isLogin,
      required this.isChange,
      required this.type,
      required this.commentFocusNode,
      required this.countComment});

  @override
  State<ReplyAndLikeInPostDetail> createState() =>
      _ReplyAndLikeInPostDetailState();
}

class _ReplyAndLikeInPostDetailState extends State<ReplyAndLikeInPostDetail> {
  List<Comment> commentAll = [];
  bool isLike = false;
  int likeCounts = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLike = widget.post.isLike;
    likeCounts = widget.post.likeCounts;
  }

  @override
  void didUpdateWidget(covariant ReplyAndLikeInPostDetail oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.post != widget.post) {
      isLike = widget.post.isLike;
      likeCounts = widget.post.likeCounts;
    }
  }

  @override
  Widget build(BuildContext context) {
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    final postFreeProvider =
        Provider.of<PostFreeProvider>(context, listen: false);
    final postFreeUserProvider =
        Provider.of<PostFreeOfUserProvider>(context, listen: false);
    final bookMarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    Future<bool> onLikeButtonTapped(bool isLiked) async {
      if (widget.isLogin) {
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

    return Padding(
      padding: const EdgeInsets.all(10),
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
            width: 5,
          ),
          Text(
            "$likeCounts",
            style: const TextStyle(
                fontFamily: 'Loventine-Regular',
                color: Colors.black,
                fontSize: 15),
          ),
          const SizedBox(
            width: 15,
          ),
          InkWell(
            onTap: () async {
              if (widget.isLogin) {
                FocusScope.of(context).requestFocus(widget.commentFocusNode);
              } else {
                showBottomSheetLogin(context, 2);
              }
            },
            child: SvgPicture.asset(
              "assets/svgs/message_bulk.svg",
              height: 24.5,
              color: AppColor.deleteBubble,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "${widget.countComment}",
            style: const TextStyle(
                fontFamily: 'Loventine-Regular',
                color: Colors.black,
                fontSize: 15),
          ),
        ],
      ),
    );
  }
}

// class ListImageDisplayInPostDetail extends StatelessWidget {
//   final List<String> image;
//   ListImageDisplayInPostDetail({super.key, required this.image});
//   List<int> column1 = [1, 1, 1, 2, 2];
//   List<int> column2 = [0, 1, 2, 2, 3];
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 250,
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Column(
//               children: [
//                 for (int i = 0; i < column1[image.length - 1]; i++)
//                   Expanded(
//                     child: _containerImage(i, 250 / column1[image.length - 1],
//                         double.infinity, "image11$i", context, image),
//                   ),
//               ],
//             ),
//           ),
//           (image.length >= 2)
//               ? Expanded(
//                   child: Column(
//                     children: [
//                       for (int i = column1[image.length - 1];
//                           i < image.length;
//                           i++)
//                         Expanded(
//                           child: _containerImage(
//                               i,
//                               250 / column2[image.length - 1],
//                               double.infinity,
//                               "image22$i",
//                               context,
//                               image),
//                         ),
//                     ],
//                   ),
//                 )
//               : const SizedBox(),
//         ],
//       ),
//     );
//   }

//   Widget _containerImage(int i, double height, double width, String tag,
//       BuildContext context, List<String> images) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ImageDetail(
//               images: images,
//               tag: tag,
//               initialIndex: i,
//             ),
//           ),
//         );
//       },
//       child: Hero(
//         tag: tag,
//         child: Container(
//           width: width,
//           height: height,
//           margin: const EdgeInsets.all(3.0),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(5),
//             image: DecorationImage(
//                 fit: BoxFit.cover, image: NetworkImage(images[i])),
//           ),
//         ),
//       ),
//     );
//   }
// }
