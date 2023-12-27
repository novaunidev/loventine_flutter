// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/modules/post/free_post/widgets/custom_pain_comment_box.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/pages/home/chat/pages/chat/chat_page.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:loventine_flutter/providers/network_info.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/providers/post_all/comment_provider.dart';
import 'package:loventine_flutter/services/chat/chat_room_service.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_icon.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/bottom_sheet_login.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:loventine_flutter/widgets/drag_handle_bottomsheet.dart';
import 'package:loventine_flutter/widgets/format_time_diff.dart';
import 'package:loventine_flutter/widgets/inkwell/inkwell_profile.dart';
import 'package:loventine_flutter/widgets/shimmer_loading/shimmer.dart';
import 'package:loventine_flutter/widgets/user_information/avatar_widget.dart';
import 'package:provider/provider.dart';

import '../../../../models/comment.dart';
import '../../../../providers/page/message_page/card_profile_provider.dart';
import '../../../../widgets/cupertino_bottom_sheet/modals/floating_modal.dart';

class CommentBox extends StatefulWidget {
  final String postId;
  final String userId;
  final String avatar;
  final String userPostId;
  final PostAll post;
  const CommentBox(
      {super.key,
      required this.postId,
      required this.userId,
      required this.avatar,
      required this.userPostId,
      required this.post});

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  late ConnectivityResult result;
  final _commentController = TextEditingController();
  String repName = "";
  String currentParentCommentId = "";
  List<Comment> commentAll = [];
  List<Comment> commentPost = [];
  List<Comment> commentComment = [];
  bool isLoading = true;
  final _dio = Dio();
  List<Comment> commentOffline = [];
  ScrollController scrollController = ScrollController();
  bool _isTextEmpty = true;
  bool isLogin = false;
  bool isLoadingBtn = false;
  bool _isTyping = false;
  FocusNode _commentFocusNode = FocusNode();

  Future<void> getAllCommentsOfAPost(String postId) async {
    try {
      var result =
          await _dio.get("$urlComments/post/$postId");
      List<dynamic> data = result.data as List<dynamic>;
      commentAll = [];
      for (int i = 0; i < data.length; i++) {
        final userCommentId = data[i]["userCommentId"];
        final response = await Dio().get('$urlUsers/$userCommentId');
        print(data[i]);
        print(response.data);
        commentAll.add(Comment.toComment(data[i] as Map<String, dynamic>, response.data));
      }
      print(commentAll);
      commentOffline = [];
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

  addChildren() {
    int indexAll =
        commentAll.indexWhere((post) => post.id == currentParentCommentId);
    int indexPost =
        commentPost.indexWhere((post) => post.id == currentParentCommentId);
    int indexComment =
        commentComment.indexWhere((post) => post.id == currentParentCommentId);
    if (indexAll != -1) {
      List<String> updatelist = commentAll[indexAll].childrenComments;
      updatelist.add("value");
      Comment update = Comment(
          id: commentAll[indexAll].id,
          content: commentAll[indexAll].content,
          postId: commentAll[indexAll].postId,
          userCommentId: commentAll[indexAll].userCommentId,
          nameUserCommentId: commentAll[indexAll].nameUserCommentId,
          avatarUserCommentId: commentAll[indexAll].avatarUserCommentId,
          time: commentAll[indexAll].time,
          replyType: commentAll[indexAll].replyType,
          parentCommentId: commentAll[indexAll].parentCommentId,
          userPostId: commentAll[indexAll].userPostId,
          childrenComments: updatelist);
      commentAll[indexAll] = update;
    }
    if (indexPost != -1) {
      List<String> updatelist = commentPost[indexPost].childrenComments;
      updatelist.add("value");
      Comment update = Comment(
          id: commentPost[indexPost].id,
          content: commentPost[indexPost].content,
          postId: commentPost[indexPost].postId,
          userCommentId: commentPost[indexPost].userCommentId,
          nameUserCommentId: commentPost[indexPost].nameUserCommentId,
          avatarUserCommentId: commentPost[indexPost].avatarUserCommentId,
          time: commentPost[indexPost].time,
          replyType: commentPost[indexPost].replyType,
          parentCommentId: commentPost[indexPost].parentCommentId,
          userPostId: commentPost[indexPost].userPostId,
          childrenComments: updatelist);
      commentPost[indexPost] = update;
    }
    if (indexComment != -1) {
      List<String> updatelist = commentComment[indexComment].childrenComments;
      updatelist.add("value");
      Comment update = Comment(
          id: commentComment[indexComment].id,
          content: commentComment[indexComment].content,
          postId: commentComment[indexComment].postId,
          userCommentId: commentComment[indexComment].userCommentId,
          nameUserCommentId: commentComment[indexComment].nameUserCommentId,
          avatarUserCommentId: commentComment[indexComment].avatarUserCommentId,
          time: commentComment[indexComment].time,
          replyType: commentComment[indexComment].replyType,
          parentCommentId: commentComment[indexComment].parentCommentId,
          userPostId: commentComment[indexComment].userPostId,
          childrenComments: updatelist);
      commentComment[indexComment] = update;
    }
  }

  Future<void> checkInternet() async {
    result = Provider.of<NetworkInfo>(context, listen: false).connectionStatus;
    if (result != ConnectivityResult.none) {
      if (commentOffline.isNotEmpty) {
        for (int i = 0; i < commentOffline.length; i++) {
          CommentProvider().addComment(
              commentOffline[i].postId,
              commentOffline[i].userCommentId,
              commentOffline[i].parentCommentId,
              commentOffline[i].time,
              commentOffline[i].replyType,
              commentOffline[i].content,
              commentOffline[i].userPostId);
        }
        CustomSnackbar.show(context,
            title: "Bình luận bạn đã được đăng. Vui lòng tải lại để xem",
            type: SnackbarType.success);
      }
    } else {}
  }

  startStreaming() {
    NetworkInfo networkInfo = NetworkInfo();
    networkInfo.onConnectivityChangedCallback = () => checkInternet();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLogin = Provider.of<MessagePageProvider>(context, listen: false).isLogin;
    _commentController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      initializeComments();
      startStreaming();
    });
  }

  void _onTextChanged() {
    setState(() {
      _isTextEmpty = _commentController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> initializeComments() async {
    await getAllCommentsOfAPost(widget.postId);
    if (mounted) {
      setState(() {});
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        isLoading = false;
      });
    }
  }

  Shimmer commentBoxLoading() {
    return Shimmer.fromColors(
      period: Duration(seconds: 2),
      baseColor: const Color(0xffe6e5eb),
      highlightColor: const Color(0xffe6e5eb),
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
    final userCurrent = Provider.of<CardProfileProvider>(context).user;

    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Column(
              children: [
                const DragHandleBottomSheet(),
                Text('Bình Luận', style: AppText.titleHeader()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.post.isPublic
                        ? SvgPicture.asset(
                            'assets/svgs/public.svg',
                            color: AppColor.iconColor,
                            height: 16,
                          )
                        : SvgPicture.asset(
                            'assets/svgs/lock-1_b.svg',
                            color: AppColor.iconColor,
                            height: 16,
                          ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                        widget.post.isPublic
                            ? 'Bất kì ai cũng có thể thấy được bình luận bên dưới'
                            : widget.post.userId == widget.userId
                                ? 'Chỉ có bạn thấy những bình luận bên dưới'
                                : 'Chỉ có bạn và ${widget.post.name} thấy được bình luận của nhau',
                        style: AppText.describeText(fontSize: 13)),
                  ],
                ),
              ],
            ),
            centerTitle: true,
            elevation: 0.0,
            automaticallyImplyLeading: false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: Container(color: const Color(0xfff2f2f2), height: 1),
            )),
        backgroundColor: Colors.white,
        bottomSheet: isLogin
            ? Material(
                color: Colors.white,
                child: Column(
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
                            width: width * 0.9,
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
                                          if (checkText(
                                              _commentController.text)) {
                                            CustomSnackbar.show(context,
                                                type: SnackbarType.failure,
                                                title: "Lỗi",
                                                message:
                                                    "Văn bản chứa từ không phù hợp");
                                          } else {
                                            if (isLoadingBtn == false) {
                                              setState(() {
                                                isLoadingBtn = true;
                                              });
                                              final result =
                                                  await Connectivity()
                                                      .checkConnectivity();
                                              if (result !=
                                                  ConnectivityResult.none) {
                                                repName == ""
                                                    ? CommentProvider()
                                                        .addComment(
                                                            widget.postId,
                                                            widget.userId,
                                                            "658bc259dc7db7f924462d4a",
                                                            DateTime.now()
                                                                .toString(),
                                                            "post",
                                                            _commentController
                                                                .text,
                                                            widget.userPostId)
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
                                                            widget.postId,
                                                            widget.userId,
                                                            currentParentCommentId,
                                                            DateTime.now()
                                                                .toString(),
                                                            "comment",
                                                            _commentController
                                                                .text,
                                                            widget.userPostId)
                                                        .whenComplete(() {
                                                        _commentController
                                                            .clear();
                                                        initializeComments();
                                                        setState(() {
                                                          isLoadingBtn = false;
                                                          _isTyping = false;
                                                        });
                                                      });
                                              } else {
                                                if (repName == "") {
                                                  setState(() {
                                                    commentPost.add(Comment(
                                                        id: "null",
                                                        content:
                                                            _commentController
                                                                .text,
                                                        postId: widget.postId,
                                                        userCommentId:
                                                            widget.userId,
                                                        nameUserCommentId:
                                                            userCurrent.name,
                                                        avatarUserCommentId:
                                                            widget.avatar,
                                                        time: DateTime.now()
                                                            .toString(),
                                                        replyType: "post",
                                                        parentCommentId: "658bc259dc7db7f924462d4a",
                                                        userPostId:
                                                            widget.userPostId,
                                                        childrenComments: []));
                                                    addChildren();
                                                    commentOffline.add(Comment(
                                                        id: "null",
                                                        content:
                                                            _commentController
                                                                .text,
                                                        postId: widget.postId,
                                                        userCommentId:
                                                            widget.userId,
                                                        nameUserCommentId:
                                                            userCurrent.name,
                                                        avatarUserCommentId:
                                                            widget.avatar,
                                                        time: DateTime.now()
                                                            .toString(),
                                                        replyType: "post",
                                                        parentCommentId: "658bc259dc7db7f924462d4a",
                                                        userPostId:
                                                            widget.userPostId,
                                                        childrenComments: []));
                                                    isLoadingBtn = false;
                                                    _isTyping = false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    commentComment.add(Comment(
                                                        id: "null",
                                                        content:
                                                            _commentController
                                                                .text,
                                                        postId: widget.postId,
                                                        userCommentId:
                                                            widget.userId,
                                                        nameUserCommentId:
                                                            userCurrent.name,
                                                        avatarUserCommentId:
                                                            widget.avatar,
                                                        time: DateTime.now()
                                                            .toString(),
                                                        replyType: "comment",
                                                        parentCommentId:
                                                            currentParentCommentId,
                                                        userPostId: "null",
                                                        childrenComments: []));
                                                    addChildren();
                                                    commentOffline.add(Comment(
                                                        id: "null",
                                                        content:
                                                            _commentController
                                                                .text,
                                                        postId: widget.postId,
                                                        userCommentId:
                                                            widget.userId,
                                                        nameUserCommentId:
                                                            userCurrent.name,
                                                        avatarUserCommentId:
                                                            widget.avatar,
                                                        time: DateTime.now()
                                                            .toString(),
                                                        replyType: "comment",
                                                        parentCommentId:
                                                            currentParentCommentId,
                                                        userPostId: "null",
                                                        childrenComments: []));
                                                    isLoadingBtn = false;
                                                    _isTyping = false;
                                                  });
                                                }
                                                _commentController.clear();
                                              }
                                            }
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
                ),
              )
            : const SizedBox(),
        body: isLoading == true
            ? commentBoxLoading()
            : commentAll.isEmpty
                ? Center(
                    child: Text(
                      "Hãy là người đầu tiên bình luận",
                      style: AppText.describeText(),
                    ),
                  )
                : Padding(
                    padding:
                        const EdgeInsets.only(bottom: 60, left: 10, right: 10),
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: commentPost.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CommentItem(
                              commentAll: commentAll,
                              commentPost: commentPost[index],
                              commentComment: commentComment,
                              onInitializeComments: initializeComments,
                              userId: widget.userId,
                              last: commentPost.last == commentPost[index],
                              isLogin: isLogin,
                              userPostId: widget.userPostId,
                              repComment: (value, parentCommentId, userId) {
                                setState(() {
                                  userId == widget.userId
                                      ? repName = "chính mình"
                                      : repName = value;
                                  currentParentCommentId = parentCommentId;
                                });
                              },
                            ),
                            if (index != commentPost.length - 1)
                              const Divider(color: AppColor.borderButton),
                          ],
                        );
                      },
                    ),
                  ));
  }
}

class CommentItem extends StatefulWidget {
  const CommentItem(
      {super.key,
      required this.commentAll,
      required this.commentComment,
      required this.commentPost,
      required this.repComment,
      required this.onInitializeComments,
      required this.userId,
      required this.isLogin,
      required this.last,
      required this.userPostId});

  final Function(String, String, String) repComment;
  final Comment commentPost;
  final List<Comment> commentComment;
  final List<Comment> commentAll;
  final Function() onInitializeComments;
  final String userId;
  final bool last;
  final bool isLogin;
  final String userPostId;

  @override
  State<CommentItem> createState() => _CommentItemState();
}

class _CommentItemState extends State<CommentItem> {
  bool checkShow1 = false;
  bool checkShow2 = false;
  @override
  Widget build(BuildContext context) {
    final List<Comment> commentLv2 = widget.commentComment
        .where((comment) => comment.parentCommentId == widget.commentPost.id)
        .toList();
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : 35 + 8.0,
        bottom: 8,
        top: 8,
        right: isRTL ? 40 + 35 : 0);
    Widget customPaint() => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 4, left: 2),
              child: InkWellProfile(
                isMe: widget.userId == widget.commentPost.userCommentId,
                userId: widget.commentPost.userCommentId,
                avatar: widget.commentPost.avatarUserCommentId,
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(widget.commentPost.avatarUserCommentId),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWellProfile(
                        isMe: widget.userId == widget.commentPost.userCommentId,
                        userId: widget.commentPost.userCommentId,
                        avatar: widget.commentPost.avatarUserCommentId,
                        child: Text(widget.commentPost.nameUserCommentId,
                            style: AppText.contentSemibold()),
                      ),
                      const Spacer(),
                      Text(formatTimeDiffStringComment(widget.commentPost.time),
                          style: AppText.describeText()),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(widget.commentPost.content,
                      style: AppText.contentRegular()),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.commentPost.id == "null"
                      ? Text(
                          "Đang đăng...",
                          style: AppText.contentRegular(),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IconButton(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                onPressed: () {
                                  if (widget.isLogin) {
                                    widget.repComment(
                                        widget.commentPost.nameUserCommentId,
                                        widget.commentPost.id,
                                        widget.commentPost.userCommentId);
                                    setState(() {
                                      checkShow1 = true;
                                    });
                                  } else {
                                    showBottomSheetLogin(context, 2);
                                  }
                                },
                                icon: SvgPicture.asset(
                                    'assets/svgs/message_l.svg')),
                            widget.userPostId == widget.userId &&
                                    widget.commentPost.userCommentId !=
                                        widget.userId
                                ? IconButton(
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.centerLeft,
                                    onPressed: () {
                                      //
                                      print('kiet here 3');
                                      CustomSnackbar.show(
                                        context,
                                        title:
                                            'Đang đi chuyển đến khung chat ghép đôi, vui lòng đợi',
                                        type: SnackbarType.success,
                                      );
                                      goToMatchingChatRoom(
                                        widget.commentPost.userCommentId,
                                        context,
                                      );
                                    },
                                    icon: SvgPicture.asset(
                                        'assets/svgs/send-2_l.svg'))
                                : SizedBox(),
                          ],
                        ),
                ],
              ),
            ),
            AppIcon(
              path: 'assets/svgs/more.svg',
              onTap: () {
                if (widget.isLogin) {
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          widget.userId == widget.commentPost.userCommentId
                              ? InkWell(
                                  onTap: () async {
                                    final result = await Connectivity()
                                        .checkConnectivity();
                                    if (result != ConnectivityResult.none) {
                                      CommentProvider()
                                          .deleteComment(widget.commentPost.id)
                                          .whenComplete(() {
                                        widget.onInitializeComments();
                                        Navigator.pop(context);
                                        // initializeComments();
                                      });
                                    } else {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "Hãy kết nối mạng",
                                          style: AppText.describeText(),
                                        ),
                                        duration: const Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                  child: ListTile(
                                    leading: const Icon(Icons.remove),
                                    title: Text(
                                      'Xóa',
                                      style: AppText.contentRegular(),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  child: ListTile(
                                    leading: const Icon(Icons.warning),
                                    title: Text(
                                      'Báo cáo',
                                      style: AppText.contentRegular(),
                                    ),
                                  ),
                                )
                        ],
                      );
                    },
                  );
                } else {
                  showBottomSheetLogin(context, 2);
                }
              },
            )
          ],
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        commentLv2.isNotEmpty
            ? CustomPaint(
                painter: RootPainter(const Size(40, 40),
                    const Color(0xffe6e5eb), 1.5, Directionality.of(context)),
                child: customPaint())
            : customPaint(),
        if (checkShow1) ...[
          ...commentLv2.map((item) => CommentLv2Widget(
                item: item,
                last: commentLv2.indexOf(item) == (commentLv2.length - 1),
                level: 2,
                commentAll: widget.commentAll,
                commentComment: widget.commentComment,
                isLogin: widget.isLogin,
                userPostId: widget.userPostId,
                repComment: (p0, p1, p2) {
                  widget.repComment(p0, p1, p2);
                },
                onInitializeComments: () {
                  widget.onInitializeComments();
                },
                userId: widget.userId,
              ))
        ] else ...[
          commentLv2.isEmpty
              ? const SizedBox()
              : checkShow1
                  ? const SizedBox()
                  : CustomPaint(
                      painter: Painter(
                        isLast: true,
                        padding: padding,
                        textDirection: Directionality.of(context),
                        avatarRoot: const Size(40, 40),
                        avatarChild: const Size(5, 5),
                        pathColor: const Color(0xffe6e5eb),
                        strokeWidth: 1.5,
                      ),
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 0,
                            bottom: padding.bottom,
                            left: padding.left,
                            right: padding.right),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              checkShow1 = !checkShow1;
                            });
                          },
                          child: Text(
                            'Xem thêm ${commentLv2.length} câu trả lời',
                            style: AppText.describeText(),
                          ),
                        ),
                      ),
                    ),
        ],
        if (checkShow1)
          Align(
            alignment: Alignment.topRight,
            child: InkWell(
              onTap: () {
                setState(() {
                  checkShow1 = false;
                  // checkShow2 = false;
                });
              },
              child: Text('Thu gọn', style: AppText.describeText()),
            ),
          ),
      ],
    );
  }
}

class CommentLv2Widget extends StatefulWidget {
  final Comment item;
  final List<Comment> commentComment;
  final String userId;
  final bool last;
  final bool isLogin;
  final List<Comment> commentAll;
  final int level;
  final Function() onInitializeComments;
  final Function(String, String, String) repComment;
  final String userPostId;
  const CommentLv2Widget(
      {super.key,
      required this.item,
      required this.commentComment,
      required this.last,
      required this.isLogin,
      required this.userId,
      required this.commentAll,
      required this.level,
      required this.onInitializeComments,
      required this.repComment,
      required this.userPostId});

  @override
  State<CommentLv2Widget> createState() => _CommentLv2WidgetState();
}

class _CommentLv2WidgetState extends State<CommentLv2Widget> {
  bool checkShow2 = false;
  @override
  Widget build(BuildContext context) {
    final commentLv3 = widget.commentComment
        .where((comment) => comment.parentCommentId == widget.item.id)
        .toList();

    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : 35 + 8.0,
        bottom: 8,
        top: 8,
        right: isRTL ? 40 + 35 : 0);
    Widget customPaint() => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 7,
              ),
              child: InkWellProfile(
                isMe: widget.userId == widget.item.userCommentId,
                userId: widget.item.userCommentId,
                avatar: widget.item.avatarUserCommentId,
                child: Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.item.avatarUserCommentId),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 7,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    InkWellProfile(
                      isMe: widget.userId == widget.item.userCommentId,
                      userId: widget.item.userCommentId,
                      avatar: widget.item.avatarUserCommentId,
                      child: Text(widget.item.nameUserCommentId,
                          style: AppText.contentSemibold()),
                    ),
                    const Spacer(),
                    Text(formatTimeDiffStringComment(widget.item.time),
                        style: AppText.describeText()),
                  ],
                ),
                const SizedBox(
                  height: 2,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text:
                              "${nameparentCommentId(widget.item.parentCommentId)} ",
                          style:
                              AppText.contentSemibold(color: AppColor.verify)),
                      TextSpan(
                          text: widget.item.content,
                          style: AppText.contentRegular()),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                widget.item.id == "null"
                    ? Text(
                        "Đang đăng...",
                        style: AppText.contentRegular(),
                      )
                    : Row(
                        children: [
                          IconButton(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                              onPressed: () {
                                if (widget.isLogin) {
                                  widget.repComment(
                                      widget.item.nameUserCommentId,
                                      widget.item.id,
                                      widget.item.userCommentId);
                                  setState(() {
                                    checkShow2 = true;
                                  });
                                } else {
                                  showBottomSheetLogin(context, 2);
                                }
                              },
                              icon: SvgPicture.asset(
                                  'assets/svgs/message_l.svg')),
                          widget.userPostId == widget.userId &&
                                  widget.item.userCommentId != widget.userId
                              ? IconButton(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerLeft,
                                  onPressed: () {
                                    // kiet here
                                    print('kiet here 1');
                                    // CustomSnackbar.show(
                                    //   context,
                                    //   title: 'kiet here 1',
                                    //   type: SnackbarType.success,
                                    // );
                                    CustomSnackbar.show(
                                      context,
                                      title:
                                          'Đang đi chuyển đến khung chat ghép đôi, vui lòng đợi',
                                      type: SnackbarType.success,
                                    );
                                    goToMatchingChatRoom(
                                      widget.item.userCommentId,
                                      context,
                                    );
                                  },
                                  icon: SvgPicture.asset(
                                      'assets/svgs/send-2_l.svg'))
                              : SizedBox(),
                        ],
                      ),
              ],
            )),
            AppIcon(
              onTap: () {
                if (widget.isLogin) {
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Wrap(
                        children: [
                          widget.userId == widget.item.userCommentId
                              ? InkWell(
                                  onTap: () async {
                                    final result = await Connectivity()
                                        .checkConnectivity();
                                    if (result != ConnectivityResult.none) {
                                      CommentProvider()
                                          .deleteComment(widget.item.id)
                                          .whenComplete(() {
                                        widget.onInitializeComments();
                                        Navigator.pop(context);
                                        // initializeComments();
                                      });
                                    } else {
                                      Navigator.pop(context);

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Hãy kết nối mạng"),
                                        duration: Duration(seconds: 2),
                                      ));
                                    }
                                  },
                                  child: const ListTile(
                                    leading: Icon(Icons.remove),
                                    title: Text('Xóa'),
                                  ),
                                )
                              : const InkWell(
                                  child: ListTile(
                                    leading: Icon(Icons.warning),
                                    title: Text('Báo cáo'),
                                  ),
                                )
                        ],
                      );
                    },
                  );
                } else {
                  showBottomSheetLogin(context, 2);
                }
              },
              path: 'assets/svgs/more.svg',
            ),
          ],
        );
    return CustomPaint(
      painter: Painter(
        isLast: widget.last,
        padding: EdgeInsets.only(
            left: isRTL ? 0 : 35 + 8.0,
            bottom: 8,
            top: 15,
            right: isRTL ? 40 + 35 : 0),
        textDirection: Directionality.of(context),
        avatarRoot: const Size(40, 40),
        avatarChild: const Size(30, 30),
        pathColor: const Color(0xffe6e5eb),
        strokeWidth: 1.5,
      ),
      child: Container(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              child: widget.item.childrenComments.isNotEmpty
                  ? CustomPaint(
                      painter: RootPainter(
                          Size(40, 30),
                          const Color(0xffe6e5eb),
                          1.5,
                          Directionality.of(context)),
                      child: customPaint())
                  : customPaint(),
            ),
            if (checkShow2) ...[
              ...commentLv3
                  .map((item) => commentLv3Widget(
                      item: item,
                      level: 3,
                      last:
                          commentLv3.indexOf(item) == (commentLv3.length - 1)))
                  .toList(),
            ] else ...[
              commentLv3.isEmpty
                  ? const SizedBox()
                  : (!checkShow2)
                      ? CustomPaint(
                          painter: Painter(
                            isLast: true,
                            padding: padding,
                            textDirection: Directionality.of(context),
                            avatarRoot: Size(40, 40),
                            avatarChild: Size(5, 5),
                            pathColor: const Color(0xffe6e5eb),
                            strokeWidth: 1.5,
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 0,
                                bottom: padding.bottom,
                                left: padding.left,
                                right: padding.right),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  checkShow2 = !checkShow2;
                                });
                              },
                              child: Text(
                                'Xem thêm câu trả lời',
                                style: AppText.describeText(),
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
            ],
          ],
        ),
      ),
    );
  }

  Widget commentLv3Widget(
      {required Comment item, required int level, required bool last}) {
    final commentLv3 = widget.commentComment
        .where((comment) => comment.parentCommentId == item.id)
        .toList();
    bool isRTL = Directionality.of(context) == TextDirection.rtl;
    final EdgeInsets padding = EdgeInsets.only(
        left: isRTL ? 0 : 35 + 8.0,
        bottom: 8,
        top: 10,
        right: isRTL ? 40 + 35 : 0);
    return Column(
      children: [
        CustomPaint(
          painter: Painter(
            isLast: last && item.childrenComments.isEmpty,
            padding: EdgeInsets.only(
                left: isRTL ? 0 : 35 + 8.0,
                bottom: 8,
                top: 16,
                right: isRTL ? 40 + 35 : 0),
            textDirection: Directionality.of(context),
            avatarRoot: const Size(40, 30),
            avatarChild: const Size(30, 30),
            pathColor: const Color(0xffe6e5eb),
            strokeWidth: 1.5,
          ),
          child: Container(
            padding: padding,
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Column(
                          children: [
                            InkWellProfile(
                              isMe: widget.userId == item.userCommentId,
                              userId: item.userCommentId,
                              avatar: item.avatarUserCommentId,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        NetworkImage(item.avatarUserCommentId),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              InkWellProfile(
                                isMe: widget.userId == item.userCommentId,
                                userId: item.userCommentId,
                                avatar: item.avatarUserCommentId,
                                child: Text(item.nameUserCommentId,
                                    style: AppText.contentSemibold()),
                              ),
                              const Spacer(),
                              Text(formatTimeDiffStringComment(item.time),
                                  style: AppText.describeText()),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text:
                                        "${nameparentCommentId(item.parentCommentId)} ",
                                    style: AppText.contentSemibold(
                                        color: AppColor.verify)),
                                TextSpan(
                                  text: item.content,
                                  style: AppText.contentRegular(),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          item.id == "null"
                              ? Text(
                                  "Đang đăng...",
                                  style: AppText.contentRegular(),
                                )
                              : Row(
                                  children: [
                                    IconButton(
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.centerLeft,
                                        onPressed: () {
                                          if (widget.isLogin) {
                                            widget.repComment(
                                                item.nameUserCommentId,
                                                item.id,
                                                item.userCommentId);
                                          } else {
                                            showBottomSheetLogin(context, 2);
                                          }
                                        },
                                        icon: SvgPicture.asset(
                                            'assets/svgs/message_l.svg')),
                                    widget.userPostId == widget.userId &&
                                            item.userCommentId != widget.userId
                                        ? IconButton(
                                            padding: EdgeInsets.zero,
                                            alignment: Alignment.centerLeft,
                                            onPressed: () {
                                              print('kiet here 2');

                                              CustomSnackbar.show(
                                                context,
                                                title:
                                                    'Đang đi chuyển đến khung chat ghép đôi, vui lòng đợi',
                                                type: SnackbarType.success,
                                              );

                                              goToMatchingChatRoom(
                                                widget.item.userCommentId,
                                                context,
                                              );
                                            },
                                            icon: SvgPicture.asset(
                                                'assets/svgs/send-2_l.svg'))
                                        : SizedBox()
                                  ],
                                ),
                          const SizedBox(height: 10.0),
                        ],
                      )),
                      AppIcon(
                        path: 'assets/svgs/more.svg',
                        onTap: () {
                          if (widget.isLogin) {
                            showFloatingModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    widget.userId == item.userCommentId
                                        ? InkWell(
                                            onTap: () async {
                                              final result =
                                                  await Connectivity()
                                                      .checkConnectivity();
                                              if (result !=
                                                  ConnectivityResult.none) {
                                                CommentProvider()
                                                    .deleteComment(item.id)
                                                    .whenComplete(() {
                                                  widget.onInitializeComments();
                                                  Navigator.pop(context);
                                                  // initializeComments();
                                                });
                                              } else {
                                                Navigator.pop(context);

                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  backgroundColor: Colors.red,
                                                  content:
                                                      Text("Hãy kết nối mạng"),
                                                  duration:
                                                      Duration(seconds: 2),
                                                ));
                                              }
                                            },
                                            child: const ListTile(
                                              leading: Icon(Icons.remove),
                                              title: Text('Xóa'),
                                            ),
                                          )
                                        : const InkWell(
                                            child: ListTile(
                                              leading: Icon(Icons.warning),
                                              title: Text('Báo cáo'),
                                            ),
                                          )
                                  ],
                                );
                              },
                            );
                          } else {
                            showBottomSheetLogin(context, 2);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ...commentLv3
            .map((item) => commentLv3Widget(
                item: item,
                level: 4,
                last: last &&
                    commentLv3.indexOf(item) == (commentLv3.length - 1)))
            .toList(),
      ],
    );
  }

  String nameparentCommentId(String parentCommentId) {
    String name = "";
    for (int i = 0; i < widget.commentAll.length; i++) {
      if (widget.commentAll[i].id == parentCommentId) {
        name = widget.commentAll[i].nameUserCommentId;
      }
    }
    return name;
  }
}

Future<void> goToMatchingChatRoom(String userId, context) async {
  try {
    await ChatRoomService.create(
        SocketProvider.current_user_id, userId, CHAT_ROOM_TYPE.MATCHING);
    final result = await ChatRoomService.getOneWith(
        SocketProvider.current_user_id,
        userId,
        CHAT_ROOM_TYPE.MATCHING,
        SocketProvider.current_user_id);

    if (result.runtimeType.toString() != 'String') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ChatPage(
            chatRoom: result,
            isConsultantisCurrent: true,
          ),
        ),
      );
    }
  } catch (e) {
    print(e);
  }
}
