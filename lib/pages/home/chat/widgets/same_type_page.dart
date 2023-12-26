import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/models/chat/get.dart';
import 'package:loventine_flutter/widgets/cupertino_bottom_sheet/modals/floating_modal.dart';
import 'package:provider/provider.dart';

import '../../../../providers/chat/chat_room_provider.dart';
import '../../../../services/chat/chat_room_service.dart';
import '../pages/chat/chat_page.dart';
import './item_message.dart';

class SameTypePage extends StatefulWidget {
  SameTypePage(this.chatrooms);
  final List<ChatRoom> chatrooms;

  @override
  State<SameTypePage> createState() => _SameTypePageState();
}

class _SameTypePageState extends State<SameTypePage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollController.addListener(() {
        if (Provider.of<ChatRoomProvider>(context, listen: false)
                .isLoadingMore ==
            true) {
          return;
        }
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          Provider.of<ChatRoomProvider>(context, listen: false)
              .getMoreChatRooms();
          print('getMoreChatRooms..');
        }
      });
    });
  }

  void _scrollListener() {}

  void updateAllowNotifiInPage(ChatRoom chatRoom, context) {
    final isAllowNotifi = chatRoom.me.isAllowNotifiCation;

    showFloatingModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            (isAllowNotifi)
                ? ListTile(
                    onTap: () async {
                      await ChatRoomService.update(chatRoom.sId, false)
                          .then((value) {
                        print('ok');
                      }).catchError((e) {
                        print(e);
                      });
                      Provider.of<ChatRoomProvider>(context, listen: false)
                          .getChatRooms(1);
                      Navigator.of(context).pop();
                    },
                    leading: Image.asset(
                      "assets/images/no_reminders.png",
                      height: 25,
                    ),
                    title: const Text(
                      'Tắt thông báo',
                      style: TextStyle(
                        fontFamily: "Loventine-Semibold",
                        fontSize: 15,
                      ),
                    ),
                  )
                : ListTile(
                    onTap: () async {
                      await ChatRoomService.update(
                        chatRoom.sId,
                        true,
                      ).then((value) {
                        print('ok');
                      }).catchError((e) {
                        print(e);
                      });
                      Provider.of<ChatRoomProvider>(context, listen: false)
                          .getChatRooms(1);
                      Navigator.of(context).pop();
                    },
                    leading: Lottie.asset("assets/lotties/notification.json",
                        height: 25),
                    title: const Text(
                      'Bật thông báo',
                      style: TextStyle(
                        fontFamily: "Loventine-Semibold",
                        fontSize: 15,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final chatRoomProvider =
        Provider.of<ChatRoomProvider>(context, listen: true);
    print(widget.chatrooms.length);
    return Column(children: [
      if (widget.chatrooms.isEmpty)
        const Text(
          'Danh sách trống',
          style: TextStyle(color: Colors.grey),
        ),
      if (widget.chatrooms.isNotEmpty)
        SizedBox(
          height: 500,
          child: ListView.builder(
            controller: scrollController,
            itemCount: chatRoomProvider.isLoadingMore
                ? widget.chatrooms.length + 1
                : widget.chatrooms.length,
            itemBuilder: (context, index) {
              if (index < widget.chatrooms.length) {
                return GestureDetector(
                  onLongPress: () {
                    updateAllowNotifiInPage(widget.chatrooms[index], context);
                  },
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ChatPage(
                        chatRoom: widget.chatrooms[index],
                        isConsultantisCurrent: true,
                      ),
                    ),
                  ),
                  child: ItemMessage(chatRoom: widget.chatrooms[index]),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
    ]);
  }
}
