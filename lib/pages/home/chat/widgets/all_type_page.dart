import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/models/chat/get.dart';
import 'package:loventine_flutter/services/chat/chat_room_service.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../../../constant.dart';
import '../../../../providers/chat/chat_room_provider.dart';
import '../../../../widgets/cupertino_bottom_sheet/modals/floating_modal.dart';
import '../../../../widgets/custom_page_route/custom_page_route.dart';
import '../pages/chat/chat_page.dart';
import 'item_message.dart';

class AllTypePage extends StatelessWidget {
  AllTypePage(this.chatrooms, this.changeSelected);
  final List<ChatRoom> chatrooms;
  final Function changeSelected;

  void updateAllowNotifiInPage(ChatRoom _chatRoom, context) {
    final isAllowNotifi = _chatRoom.me.isAllowNotifiCation;
    showFloatingModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            (isAllowNotifi)
                ? ListTile(
                    onTap: () async {
                      await ChatRoomService.update(
                        _chatRoom.sId,
                        false,
                      ).then((value) {
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
                        _chatRoom.sId,
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

  groupWidgets(context, List<ChatRoom> chatrooms, String title) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              if (title == "Việc làm của tôi")
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    "assets/images/chat_my_job.png",
                    height: 27,
                  ),
                ),
              if (title == "Tôi thuê tư vấn")
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    "assets/images/i_hire.png",
                    height: 27,
                  ),
                ),
              if (title == "Ghép cặp")
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Image.asset(
                    "assets/images/find_love.png",
                    height: 27,
                  ),
                ),
              Text(
                '$title',
                style:
                    const TextStyle(fontFamily: "Loventine-Bold", fontSize: 15),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              changeSelected(title);
            },
            child: const Text(
              'Xem thêm',
              style: TextStyle(
                  fontFamily: "Loventine-Semibold",
                  fontSize: 15,
                  color: AppColor.mainColor),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      if (chatrooms.isEmpty)
        const Text(
          'Danh sách trống',
          style: TextStyle(
              fontFamily: "Loventine-Semibold",
              fontSize: 15,
              color: Colors.grey),
        ),
      for (int index = 0;
          index < min(chatrooms.length, limitItems);
          index++) ...[
        GestureDetector(
            onLongPress: () {
              updateAllowNotifiInPage(chatrooms[index], context);
            },
            onTap: () => appNavigate(
                context,
                ChatPage(
                  chatRoom: chatrooms[index],
                  isConsultantisCurrent: true,
                )),
            child: ItemMessage(chatRoom: chatrooms[index])),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<ChatRoom> myjobs = chatrooms.where((chatRoom) {
      if (chatRoom.type == 'job' && chatRoom.isConsultant == true) return true;
      return false;
    }).toList();
    List<ChatRoom> myhirings = chatrooms.where((chatRoom) {
      if (chatRoom.type == 'job' && chatRoom.isConsultant == false) return true;
      return false;
    }).toList();
    List<ChatRoom> matchings = chatrooms.where((chatRoom) {
      if (chatRoom.type == 'matching') return true;
      return false;
    }).toList();
    return Column(children: [
      ...groupWidgets(context, myjobs, my_jobs),
      const SizedBox(height: 16),
      ...groupWidgets(context, myhirings, my_hirings),
      const SizedBox(height: 16),
      ...groupWidgets(context, matchings, matching),
    ]);
  }
}
