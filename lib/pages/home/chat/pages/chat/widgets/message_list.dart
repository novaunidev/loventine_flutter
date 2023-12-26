import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';
import '../../../../../../modules/post/free_post/widgets/media_service.dart';
import '../../../../../../providers/chat/chat_page_provider.dart';

import '../../../../../../values/app_color.dart';
import '../../../../../../widgets/scroll_to_index/scroll_to_index.dart';
import './message_item.dart';

class MessageList extends StatefulWidget {
  final BuildContext pageContext;
  final String parnerAvatar;
  const MessageList(this.parnerAvatar, this.pageContext);

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  bool isKeyBoardShow = false;
  bool isShow = false;
  List<AssetEntity> assetList = [];
  AssetPathEntity? selectedAlbum;
  List<AssetPathEntity> albumList = [];
  List<AssetEntity> selectedAssetList = [];
  FocusNode _textNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isKeyBoardShow = false;

    //   KeyboardVisibility.onChange.listen((event) {
    //   setState(() {
    //     _isKeyboardActive = event;
    //   });
    // });
    MediaServices().loadAlbums(RequestType.image).then(
      (value) {
        setState(() {
          albumList = value;
          selectedAlbum = value[0];
        });
        //LOAD RECENT ASSETS
        MediaServices().loadAssets(selectedAlbum!).then(
          (value) {
            setState(() {
              assetList = value;
            });
          },
        );
      },
    );

    _textNode.addListener(() {
      if (_textNode.hasFocus) {
        setState(() {
          isShow = false;
        });
      }
    });
  }

  Future uploadImage(BuildContext context) async {
    setState(() {
      isShow = false;
    });
    await Provider.of<ChatPageProvider>(context, listen: false)
        .uploadImages(selectedAssetList);
  }

  final TextEditingController _controller = TextEditingController();
  bool _isTyping = false;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    _textNode.dispose();
  }

  bool checkIsLast(
      String currentUserId, String beforeUserId, String beforeType, int index) {
    bool isLast = true;
    if (index != 0) {
      if (currentUserId != beforeUserId) {
        isLast = true;
      } else if (beforeType == 'isDate') {
        isLast = true;
      } else if (beforeType == 'status') {
        isLast = true;
      } else {
        isLast = false;
      }
    }
    return isLast;
  }

  String checkIsLocation(
      String currentUserId,
      String beforeUserId,
      String afterUserId,
      String beforeType,
      String afterType,
      int index,
      int lenght) {
    String isLocation = 'bot';
    if (index != 0) {
      if (index != lenght - 1) {
        if (currentUserId != afterUserId && currentUserId != beforeUserId) {
          isLocation = 'alone';
        } else if (afterType == 'isDate' && currentUserId != beforeUserId) {
          isLocation = 'alone';
        } else if (beforeType == 'isDate' && currentUserId != afterUserId) {
          isLocation = 'alone';
        } else if (afterType == 'isDate' && beforeType == 'isDate') {
          isLocation = 'alone';
        } else if (afterType == 'status' && beforeType == 'status') {
          isLocation = 'alone';
        } else if (afterType == 'isDate' && beforeType == 'status') {
          isLocation = 'alone';
        } else if (currentUserId != afterUserId && beforeType == 'status') {
          isLocation = 'alone';
        } else if (currentUserId != beforeUserId && afterType == 'status') {
          isLocation = 'alone';
        } else if (beforeType == 'isDate' && afterType == 'status') {
          isLocation = 'alone';
        } else if (afterType == 'isDate') {
          isLocation = 'top';
        } else if (beforeType == 'isDate') {
          isLocation = 'bot';
        } else if (afterType == 'status') {
          isLocation = 'top';
        } else if (beforeType == 'status') {
          isLocation = 'bot';
        } else if (currentUserId != beforeUserId) {
          isLocation = 'bot';
        } else if (currentUserId != afterUserId) {
          isLocation = 'top';
        } else {
          isLocation = 'center';
        }
      }
    }
    return isLocation;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;

    final chatPageProvider =
        Provider.of<ChatPageProvider>(context, listen: true);
    final messages = chatPageProvider.messagesCustom;
    // final lastMessage = messages.isNotEmpty
    //     ? messages[messages.length - 1]
    //     : Message(
    //         sId: '',
    //         message: '',
    //         userId: '',
    //         type: '',
    //         chatRoomId: '',
    //         isDeleted: false,
    //         isSent: false,
    //       );
    if (chatPageProvider.isLoadingKeyBoard == false &&
        isKeyBoardShow == false) {
      if (MediaQuery.of(widget.pageContext).viewInsets.bottom > 0) {
        chatPageProvider.jumbWhenShowKeyBoard();
        isKeyBoardShow = true;
        // chatPageProvider.jumbWhenShowKeyBoard();
      }
    } else {
      if (MediaQuery.of(widget.pageContext).viewInsets.bottom <= 0) {
        isKeyBoardShow = false;
      }
    }

    return Stack(
      children: [
        SizedBox(
          height: isShow ? height * 0.6 - 7 : height,
          child: Stack(
            children: [
              Column(
                children: [
                  Visibility(
                    visible: chatPageProvider.isLoadingMore,
                    child: const SizedBox(
                      height: 30,
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        setState(() {
                          isShow = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 20.0,
                          right: 20,
                        ),
                        child: (messages.isEmpty)
                            ? const Center(child: Text('Hội thoại trống'))
                            : Consumer<ChatPageProvider>(
                                builder: (context, provider, child) {
                                  return CustomScrollView(
                                    reverse: true,
                                    clipBehavior: Clip.none,
                                    scrollBehavior:
                                        ScrollConfiguration.of(context)
                                            .copyWith(scrollbars: false),
                                    physics: const BouncingScrollPhysics(),
                                    controller: provider.controller,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    cacheExtent: 500.0,
                                    slivers: [
                                      // SliverToBoxAdapter(
                                      //   child: Visibility(
                                      //     visible: (chatPageProvider.isSeen &&
                                      //         lastMessage.userId ==
                                      //             SocketProvider
                                      //                 .current_user_id),
                                      //     child: Align(
                                      //       alignment: Alignment.bottomRight,
                                      //       child: CachedNetworkImage(
                                      //         imageUrl: widget.parnerAvatar,
                                      //         placeholder: (context, url) =>
                                      //             CircleAvatar(
                                      //           radius: 8,
                                      //           backgroundImage: NetworkImage(
                                      //             widget.parnerAvatar,
                                      //           ),
                                      //         ),
                                      //         errorWidget:
                                      //             (context, url, error) =>
                                      //                 const CircleAvatar(
                                      //           radius: 8,
                                      //           backgroundImage: NetworkImage(
                                      //             defaultAvatar,
                                      //           ),
                                      //         ),
                                      //         imageBuilder: (context, image) =>
                                      //             CircleAvatar(
                                      //           backgroundImage: image,
                                      //           radius: 8,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      SliverList(
                                          delegate: SliverChildBuilderDelegate(
                                        (context, index) {
                                          bool isLast = true;
                                          String isLocation = 'bot';
                                          if (index != 0 &&
                                              index !=
                                                  provider.messagesCustom
                                                          .length -
                                                      1) {
                                            final currentUserId = provider
                                                .messagesCustom[index].userId;
                                            final beforeUserId = provider
                                                .messagesCustom[index - 1]
                                                .userId;
                                            final afterUserId = provider
                                                .messagesCustom[index + 1]
                                                .userId;
                                            final beforeType = provider
                                                .messagesCustom[index - 1].type;
                                            final afterType = provider
                                                .messagesCustom[index + 1].type;
                                            final lenght =
                                                provider.messagesCustom.length;

                                            isLast = checkIsLast(
                                                currentUserId,
                                                beforeUserId,
                                                beforeType,
                                                index);

                                            isLocation = checkIsLocation(
                                                currentUserId,
                                                beforeUserId,
                                                afterUserId,
                                                beforeType,
                                                afterType,
                                                index,
                                                lenght);
                                          }

                                          return AutoScrollTag(
                                            key: ValueKey(index),
                                            controller: provider.controller,
                                            index: index,
                                            child: MessageItem(
                                                provider.messagesCustom[index],
                                                widget.parnerAvatar,
                                                "$index",
                                                provider.isSeen,
                                                isLast,
                                                isLocation),
                                          );
                                        },
                                        childCount:
                                            provider.messagesCustom.length,
                                      )),
                                    ],
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: chatPageProvider.isLoadingImage,
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CupertinoActivityIndicator(),
                      ),
                    ),
                  ),

                  //Nhập tin nhắn

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
                                duration: const Duration(milliseconds: 100),
                                curve: Curves.easeInOut,
                                height: _isTyping ? 0 : 27,
                                child: _isTyping
                                    ? const SizedBox(
                                        width: 10,
                                      )
                                    : InkWell(
                                        onTap: () {
                                          // showApply();
                                        },
                                        child: SvgPicture.asset(
                                          "assets/svgs/more-circle.svg",
                                          height: 30,
                                          color: AppColor.chatBubble,
                                        ),
                                      ),
                              ),
                              Expanded(
                                child: TextField(
                                  controller: _controller,
                                  cursorColor: AppColor.mainColor,
                                  focusNode: _textNode,
                                  // textInputAction: TextInputAction.send,
                                  // onEditingComplete: () {
                                  //   chatPageProvider
                                  //       .sendMessageText(_controller.text.trim());
                                  //   _controller.clear();
                                  //   setState(() {
                                  //     _isTyping = false;
                                  //   });
                                  // },
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  onChanged: (text) {
                                    chatPageProvider.sendTyping();
                                    setState(() {
                                      _isTyping = text.trim().isNotEmpty;
                                    });
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Loventine-Regular',
                                    fontSize: 15,
                                    color: AppColor.blackColor,
                                  ),
                                  decoration: const InputDecoration.collapsed(
                                    hintText: 'Nhắn tin...',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Loventine-Regular',
                                      fontSize: 15,
                                      color: AppColor.iconColor,
                                    ),
                                  ),
                                ),
                              ),
                              Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeInOut,
                                    height: _isTyping ||
                                            _controller.text.trim().isNotEmpty
                                        ? 27
                                        : 0,
                                    child: InkWell(
                                      onTap: () {
                                        chatPageProvider.sendMessageText(
                                            _controller.text.trim());
                                        _controller.clear();
                                        setState(() {
                                          _isTyping = false;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svgs/send-1.svg",
                                        height: 27,
                                        color: AppColor.chatBubble,
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 150),
                                    curve: Curves.easeInOut,
                                    height: _isTyping ||
                                            _controller.text.trim().isNotEmpty
                                        ? 0
                                        : 27,
                                    child: InkWell(
                                      onTap: () {
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                        setState(() {
                                          isShow = true;
                                        });
                                      },
                                      child: SvgPicture.asset(
                                        "assets/svgs/gallery.svg",
                                        height: 27,
                                        color: AppColor.deleteBubble,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  //End.
                  const SizedBox(
                    height: 7,
                  )
                ],
              ),
              Positioned(
                bottom: 17,
                left: 12,
                child: Visibility(
                  visible:
                      chatPageProvider.isTyping && chatPageProvider.isBottom,
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Lottie.asset(
                      'assets/lotties/Loading_dots.json',
                      height: 70,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        isShow == false
            ? const SizedBox()
            : DraggableScrollableSheet(
                initialChildSize: 0.36,
                maxChildSize: 1,
                minChildSize: 0.36,
                builder: (context, scroll) {
                  return Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        CustomScrollView(
                          controller: scroll,
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverPersistentHeader(
                              pinned: true,
                              floating: true,
                              delegate: _SliverAppBarDelegate(
                                minHeight:
                                    40, // Chiều cao tối thiểu của SliverAppBar là 20
                                maxHeight:
                                    40, // Chiều cao tối đa của SliverAppBar là 40
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5), // Màu của bóng
                                          spreadRadius:
                                              -3, // Độ xổ của bóng (lớn hơn giá trị, bóng càng lớn)
                                          blurRadius:
                                              7, // Độ mờ của bóng (lớn hơn giá trị, bóng càng mờ)
                                          offset: const Offset(0,
                                              -3), // Vị trí của bóng (thay đổi giá trị X và Y để di chuyển bóng)
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (selectedAlbum != null)
                                            GestureDetector(
                                              onTap: () {
                                                albums(height);
                                              },
                                              child: Text(
                                                selectedAlbum!.name == "Recent"
                                                    ? "Gallery"
                                                    : selectedAlbum!.name,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ),
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              left: 5,
                                            ),
                                            child: Icon(
                                              Icons.arrow_downward,
                                              color: Colors.black,
                                              size: 15,
                                            ),
                                          ),
                                          const Spacer(),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                isShow = false;
                                              });
                                            },
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SliverGrid(
                                delegate: SliverChildBuilderDelegate(
                                    childCount: assetList.length,
                                    (context, index) {
                                  AssetEntity assetEntity = assetList[index];
                                  return assetWidget(assetEntity);
                                }),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4))
                          ],
                        ),
                        selectedAssetList.isEmpty
                            ? SizedBox()
                            : Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: InkWell(
                                    onTap: () {
                                      uploadImage(context).whenComplete(() {
                                        setState(() {
                                          selectedAssetList = [];
                                        });
                                      });
                                    },
                                    child: Container(
                                      height: 50,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(18)),
                                      child: Center(
                                          child: Text(
                                        "Gửi ${selectedAssetList.length}",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  );
                }),
      ],
    );
  }

  Widget assetWidget(AssetEntity assetEntity) => GestureDetector(
        onTap: () {
          if (selectedAssetList.contains(assetEntity)) {
            setState(() {
              selectedAssetList.remove(assetEntity);
            });
          } else if (selectedAssetList.length < 9) {
            setState(() {
              selectedAssetList.add(assetEntity);
            });
          }
        },
        child: Padding(
          padding: EdgeInsets.all(
              selectedAssetList.contains(assetEntity) == true ? 5 : 0),
          child: Stack(
            children: [
              Positioned.fill(
                child: AssetEntityImage(
                  assetEntity,
                  isOriginal: false,
                  thumbnailSize: const ThumbnailSize.square(250),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    );
                  },
                ),
              ),
              selectedAssetList.contains(assetEntity) == false
                  ? const SizedBox()
                  : Positioned.fill(
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.5,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                "${selectedAssetList.indexOf(assetEntity) + 1}",
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      );

  void albums(height) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff101010),
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      builder: (context) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: albumList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                setState(() {
                  selectedAlbum = albumList[index];
                });
                await MediaServices().loadAssets(albumList[index]).then(
                  (value) {
                    setState(() {
                      assetList = value;
                    });
                    Navigator.pop(context);
                  },
                );
              },
              title: Text(
                albumList[index].name == "Recent"
                    ? "Gallery"
                    : albumList[index].name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
