import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/user_name_shortener.dart';
import 'package:provider/provider.dart';
import '../../../../../providers/chat/chat_page_provider.dart';
import '../../../../../providers/chat/chat_room_provider.dart';
import '../../../../../providers/call/call_provider.dart';
import '../../../../../models/chat/get.dart';
import '../../../../../widgets/shimmer_simple.dart';
import './widgets/message_list.dart';
import 'widgets/message_avatar.dart';

class ChatPage extends StatefulWidget {
  final ChatRoom chatRoom;
  final isConsultantisCurrent;
  const ChatPage(
      {Key? key, required this.chatRoom, required this.isConsultantisCurrent})
      : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChatPageProvider>(context, listen: false)
          .init(widget.chatRoom);
    });
  }

  bool stateIsKeyBoardShow = false;

  bool isKeyBoardShow = false;

  @override
  Widget build(BuildContext context) {
    final chatPageProvider =
        Provider.of<ChatPageProvider>(context, listen: true);
    final callProvider = Provider.of<CallProvider>(context, listen: false);

    final appBar = AppBar(
      backgroundColor: Colors.white.withAlpha(200),
      titleSpacing: -10,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ),

      elevation: 0.5,
      leading: IconButton(
        onPressed: () {
          chatPageProvider.leaveChat();
          Provider.of<ChatRoomProvider>(context, listen: false).getChatRooms(1);
          Navigator.pop(context);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              MessageAvatar(
                size: 20,
                avatarUrl: widget.chatRoom.partner.avatarUrl,
              ),
              if (widget.chatRoom.partner.online)
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
                )
            ],
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                formatUserName(widget.chatRoom.partner.name),
                style: const TextStyle(
                  fontFamily: 'Loventine-Bold',
                  fontSize: 18,
                  color: AppColor.blackColor,
                ),
              ),
              Text(
                (widget.chatRoom.partner.online)
                    ? 'Đang hoạt động'
                    : 'Không hoạt động',
                style: const TextStyle(
                  fontFamily: 'Loventine-Regular',
                  fontSize: 13,
                  color: AppColor.deleteBubble,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        InkWell(
            onTap: () {
              callProvider.make_call(
                chatPageProvider.chatRoom.partner.sId,
                CALL_TYPE.AUDIO,
                chatPageProvider.chatRoom.sId,
              );
            },
            child: SvgPicture.asset(
              "assets/svgs/call.svg",
              height: 25,
              color: AppColor.blackColor,
            )),
        const SizedBox(width: 20),
        InkWell(
            onTap: () {
              callProvider.make_call(
                chatPageProvider.chatRoom.partner.sId,
                CALL_TYPE.VIDEO,
                chatPageProvider.chatRoom.sId,
              );
            },
            child: SvgPicture.asset(
              "assets/svgs/video.svg",
              height: 27,
              color: AppColor.blackColor,
            )),
        const SizedBox(width: 20),

        // PopupMenuButton<int>(
        //   icon: const Icon(
        //     Icons.more_vert,
        //     color: Color(0xFF229D1F),
        //   ),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0),
        //   ),
        //   onSelected: (value) {
        //     print('Value: $value');
        //     if (value == 1) {
        //       // showGeneralDialog(
        //       //     barrierLabel: "Barrier",
        //       //     barrierDismissible: true,
        //       //     barrierColor: Colors.transparent,
        //       //     transitionDuration: const Duration(milliseconds: 400),
        //       //     context: context,
        //       //     pageBuilder: (_, __, ___) {
        //       //       if (SocketProvider.current_user_id ==
        //       //           widget.chatRoom.UserId1) {
        //       //         return BlurredDialog(
        //       //             dialogContent: ReportUserDialog(
        //       //           adviceReportId: apply["_id"],
        //       //           nameMe: widget.chatRoom.UserName1,
        //       //           userId: SocketProvider.current_user_id,
        //       //         ));
        //       //       } else {
        //       //         return BlurredDialog(
        //       //             dialogContent: ReportUserDialog(
        //       //           adviceReportId: apply["_id"],
        //       //           nameMe: widget.chatRoom.UserName2,
        //       //           userId: SocketProvider.current_user_id,
        //       //         ));
        //       //       }
        //       //     },
        //       //     transitionBuilder: (_, anim, __, child) {
        //       //       Tween<Offset> tween;
        //       //       tween = Tween(begin: const Offset(0, 1), end: Offset.zero);

        //       //       return SlideTransition(
        //       //         position: tween.animate(
        //       //           CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        //       //         ),
        //       //         child: child,
        //       //       );
        //       //     });
        //     } else if (value == 2) {
        //       // Mục 2 được chọn
        //     }
        //     //else if (value == 3) {
        //     //   // Mục 3 được chọn
        //     // }
        //   },
        //   itemBuilder: (BuildContext context) => [
        //     PopupMenuItem<int>(
        //       value: 1,
        //       child: Row(
        //         children: [
        //           Image.asset(
        //             "assets/images/report_user_ico.png",
        //             width: 30,
        //           ),
        //           const Text(
        //             ' Báo cáo',
        //             style: TextStyle(
        //               fontFamily: 'Loventine-Bold',
        //               fontSize: 15,
        //               color: Color(0xff3C3F42),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ],
      // bottom: PreferredSize(
      //   child: Container(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         // isLoading_apply
      //         //     ? CircularProgressIndicator()
      //         //     : InkWell(
      //         //         onTap: () {
      //         //           show_apply_model(context);
      //         //         },
      //         //         child: Text(
      //         //           'Xem tình trạng công việc',
      //         //           style: TextStyle(color: Colors.grey),
      //         //         )),
      //         CustomCard(
      //             borderRadius: 30,
      //             color: Colors.red,
      //             child: Icon(
      //               Icons.notifications,
      //               color: Colors.white,
      //             )),
      //       ],
      //     ),
      //   ),
      //   preferredSize: Size.fromHeight(25),
      // ),
    );

    return Scaffold(
      appBar: appBar,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: chatPageProvider.isLoadingInit
          ? ShimmerSimple()
          : MessageList(widget.chatRoom.partner.avatarUrl, context),
    );
  }
}
