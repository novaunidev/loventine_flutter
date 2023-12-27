// ignore_for_file: use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/providers/post_all/bookmark_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_delete_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_fee_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_provider.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';

import '../pages/report/report_post_dialog.dart';
import '../providers/post_all/post_fee_provider.dart';
import '../values/app_color.dart';
import 'blurred_dialog.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final String nameMe;
  final String userId;
  final String postId;
  final bool isPublic;
  final String authorId;
  final int index;
  final String postType;
  final bool isBookmark;
  final String bookmarkId;
  final bool isDetail;
  final double paddingRight;
  final Function(bool, bool) update;
  const CustomPopupMenuButton(
      {super.key,
      required this.nameMe,
      required this.userId,
      required this.postId,
      required this.authorId,
      required this.index,
      required this.postType,
      required this.isPublic,
      required this.isBookmark,
      required this.bookmarkId,
      required this.isDetail,
      required this.update,
      this.paddingRight = 20});

  @override
  Widget build(BuildContext context) {
    final postFeeProvider =
        Provider.of<PostFeeProvider>(context, listen: false);
    final postDeleteProvider =
        Provider.of<PostDeleteProvider>(context, listen: false);
    final postFreeProvider =
        Provider.of<PostFreeProvider>(context, listen: false);
    final postFreeUserProvider =
        Provider.of<PostFreeOfUserProvider>(context, listen: false);
    final postFeeUserProvider =
        Provider.of<PostFeeOfUserProvider>(context, listen: false);
    final bookMarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    editObject(bool _isPublic) async {
      try {
        final respronse =
            await Dio().patch("$baseUrl/post/updatePost/$postId", data: {
          'isPublic': "$_isPublic",
        });
        if (respronse.statusCode == 200) {
          CustomSnackbar.show(context,
              title: "Chỉnh sửa đối tượng thành công",
              type: SnackbarType.success);
          postFreeProvider.updateObjectInFreePost(postId, _isPublic);
          postFreeProvider.updateObjectInFreePost1(postId, _isPublic);
          postFreeUserProvider.updateObjectInFreePostofUser(postId, _isPublic);
          bookMarkProvider.updateObjectInBookmarkPost(postId, _isPublic);
        } else {
          CustomSnackbar.show(context,
              title: "Chỉnh sửa đối tượng thất bại",
              type: SnackbarType.failure);
        }
      } catch (e) {
        print(e);
      }
    }

    return PopupMenuButton<int>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onSelected: (value) {
        if (value == 2) {
          authorId == userId
              ? postDeleteProvider.moveToTrash(postId).whenComplete(() {
                  if (postType == "free") {
                    
                    postFreeProvider.deleteFreePost(postId, true);
                    bookMarkProvider.updateDeleteInBookmarkPost(postId);
                  } else if (postType == "free1") {
                    postFreeProvider.getAllFreePostPage1(userId);
                  } else if (postType == "fee") {
                    postFeeProvider.deleteFeePost(postId);
                    bookMarkProvider.updateDeleteInBookmarkPost(postId);
                  } else if (postType == "freeUser") {
                    postFreeUserProvider.deleteFreePostofUser(index);
                    postFreeProvider.getAllFreePostPage1(userId);
                  } else if (postType == "feeUser") {
                    postFeeUserProvider.deleteFeePostofUser(index);
                  }
                  if (isDetail) {
                    Navigator.pop(context);
                  }
                })
              : showGeneralDialog(
                  barrierLabel: "Barrier",
                  barrierDismissible: true,
                  barrierColor: Colors.transparent,
                  transitionDuration: const Duration(milliseconds: 400),
                  context: context,
                  pageBuilder: (_, __, ___) {
                    return BlurredDialog(
                      dialogContent: ReportPostDialog(
                        nameMe: nameMe,
                        userId: userId,
                        postId: postId,
                      ),
                    );
                  },
                  transitionBuilder: (_, anim, __, child) {
                    Tween<Offset> tween;
                    tween = Tween(begin: const Offset(0, 1), end: Offset.zero);

                    return SlideTransition(
                      position: tween.animate(
                        CurvedAnimation(parent: anim, curve: Curves.easeInOut),
                      ),
                      child: child,
                    );
                  },
                );
        } else if (value == 1) {
          if (postType == "bookmark") {
            bookMarkProvider.deleteBookmark(
                bookmarkId,
                context,
                userId,
                index,
                postId,
                postFeeProvider,
                postFreeProvider,
                postFreeUserProvider,
                postFeeUserProvider);
          } else if (isBookmark) {
            final _bookmarkId = bookMarkProvider.findIdByPostId(postId);
            bookMarkProvider
                .deleteBookmark(
                    _bookmarkId,
                    context,
                    userId,
                    index,
                    postId,
                    postFeeProvider,
                    postFreeProvider,
                    postFreeUserProvider,
                    postFeeUserProvider)
                .whenComplete(() => update(false, isPublic));
          } else {
            bookMarkProvider
                .addBookmark(postId, userId, context, postFeeProvider,
                    postFreeProvider, postFreeUserProvider, postFeeUserProvider)
                .whenComplete(() => update(true, isPublic));
          }

          // Mục 2 được chọn
        } else if (value == 3) {
          showModalBottomSheet(
            backgroundColor: Colors.white,
            isScrollControlled: false,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            builder: (context) {
              return EditObject(
                isPublic: isPublic,
              );
            },
          ).then((value) {
            if (value != null) {
              if (value == Option.public) {
                if (isPublic == false) {
                  editObject(true);
                  update(isBookmark, true);
                }
              } else {
                if (isPublic) {
                  editObject(false);
                  update(isBookmark, false);
                }
              }
            }
          });
        }
      },
      itemBuilder: (BuildContext context) => [
        if (postType == "bookmark") ...[
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/svgs/trash.svg",
                  height: 22,
                  color: AppColor.blackColor,
                ),
                const Text(
                  ' Bỏ Lưu',
                  style: TextStyle(
                    fontFamily: 'Loventine-Bold',
                    fontSize: 15,
                    color: Color(0xff3C3F42),
                  ),
                ),
              ],
            ),
          )
        ] else if (postType == "free" || postType == "freeUser") ...[
          if (authorId == userId) ...[
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/save-minus.svg",
                    height: 20,
                    color: AppColor.blackColor,
                  ),
                  Text(
                    isBookmark ? ' Bỏ lưu' : ' Lưu công việc',
                    style: const TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontSize: 15,
                      color: Color(0xff3C3F42),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/trash.svg",
                    height: 22,
                    color: AppColor.blackColor,
                  ),
                  const Text(
                    ' Xóa bài viết',
                    style: TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontSize: 15,
                      color: Color(0xff3C3F42),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 3,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/lock-1.svg",
                    height: 20,
                    color: AppColor.blackColor,
                  ),
                  const Text(
                    ' Chỉnh sửa đối tượng',
                    style: TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontSize: 15,
                      color: Color(0xff3C3F42),
                    ),
                  ),
                ],
              ),
            )
          ] else ...[
            PopupMenuItem<int>(
              value: 1,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/save-minus.svg",
                    height: 20,
                    color: AppColor.blackColor,
                  ),
                  Text(
                    isBookmark ? ' Bỏ lưu' : ' Lưu công việc',
                    style: const TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontSize: 15,
                      color: Color(0xff3C3F42),
                    ),
                  ),
                ],
              ),
            ),
            PopupMenuItem<int>(
              value: 2,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svgs/danger.svg",
                    height: 20,
                  ),
                  const Text(
                    ' Báo cáo bài viết',
                    style: TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontSize: 15,
                      color: Color(0xff3C3F42),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ] else ...[
          PopupMenuItem<int>(
            value: 1,
            child: Row(
              children: [
                SvgPicture.asset(
                  "assets/svgs/save-minus.svg",
                  height: 20,
                  color: AppColor.blackColor,
                ),
                Text(
                  isBookmark ? ' Bỏ lưu' : ' Lưu công việc',
                  style: TextStyle(
                    fontFamily: 'Loventine-Bold',
                    fontSize: 15,
                    color: Color(0xff3C3F42),
                  ),
                ),
              ],
            ),
          ),
          authorId == userId
              ? PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/trash.svg",
                        height: 22,
                        color: AppColor.blackColor,
                      ),
                      const Text(
                        ' Xóa bài viết',
                        style: TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 15,
                          color: Color(0xff3C3F42),
                        ),
                      ),
                    ],
                  ),
                )
              : PopupMenuItem<int>(
                  value: 2,
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "assets/svgs/danger.svg",
                        height: 20,
                      ),
                      const Text(
                        ' Báo cáo bài viết',
                        style: TextStyle(
                          fontFamily: 'Loventine-Bold',
                          fontSize: 15,
                          color: Color(0xff3C3F42),
                        ),
                      ),
                    ],
                  ),
                ),
        ]
      ],
      child: Padding(
        padding: EdgeInsets.only(left: 7, right: paddingRight),
        child: SvgPicture.asset(
          "assets/svgs/more.svg",
          height: 24,
          color: isDetail && postType == "fee" ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

enum Option { public, private }

class EditObject extends StatefulWidget {
  final bool isPublic;
  const EditObject({super.key, required this.isPublic});

  @override
  State<EditObject> createState() => _EditObjectState();
}

class _EditObjectState extends State<EditObject> {
  Option? _site = Option.values[0];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _site = widget.isPublic ? Option.values[0] : Option.values[1];
  }

  Widget itemchoose(String title, String description, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          setState(() {
            _site = Option.values[index];
          });
        },
        child: Row(
          children: [
            Container(
                padding: const EdgeInsets.all(11),
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xffe4e6eb)),
                child: index == 0
                    ? SvgPicture.asset(
                        'assets/svgs/public.svg',
                        color: Colors.black,
                      )
                    : SvgPicture.asset(
                        'assets/svgs/lock-1_b.svg',
                        color: Colors.black,
                      )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Loventine-Bold",
                        color: Color(0xff020202)),
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: AppColor.textBlack),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Checkbox(
              value: _site == Option.values[index],
              onChanged: (bool? value) async {
                setState(() {
                  _site = value != null && value == true
                      ? Option.values[index]
                      : null;
                });
              },
              shape: const CircleBorder(),
              activeColor: AppColor.mainColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Container(
          padding: const EdgeInsetsDirectional.only(bottom: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 3),
                        child: Text(
                          'Chọn đối tượng',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Loventine-Semibold',
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Image.asset(
                          'assets/images/close.png',
                          height: 25,
                        ),
                        onTap: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                color: const Color.fromARGB(255, 210, 210, 223),
              ),
              const SizedBox(
                height: 5,
              ),
              itemchoose("Công khai",
                  "Bất kì ai cũng có thể xem bình luận của nhau", 0),
              itemchoose(
                  "Chỉ mình tôi",
                  "Chỉ mình bạn có thể xem, người bình luận sẽ không thấy được các bình luận của người khác",
                  1),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, _site);
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      minimumSize: Size(width * 0.9, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: AppColor.mainColor,
                      onPrimary: Colors.white),
                  child: const Text(
                    "Xong",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Loventine-Bold",
                    ),
                  )),
              const SizedBox(
                width: 10,
              )
            ],
          )),
    );
  }
}
