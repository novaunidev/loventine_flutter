import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../../models/chat/get.dart';

class ItemMessage extends StatefulWidget {
  //const ItemMessage({super.key});
  const ItemMessage({Key? key, required this.chatRoom}) : super(key: key);

  final ChatRoom chatRoom;

  @override
  State<ItemMessage> createState() => _ItemMessageState();
}

class _ItemMessageState extends State<ItemMessage> {
  String Sub(String str) {
    return str.substring(0, 20);
  }

  @override
  Widget build(BuildContext context) {
    String message = '';
    String dateTimeString = '';
    String num_unwatched = '';
    if (widget.chatRoom.lastMessage == null) {
      message = 'Hai bạn vừa được kết nối';
    } else {
      message = (widget.chatRoom.lastMessage?.message as String);
      message.substring(0, min(20, message.length));
      DateTime dateTime =
          DateTime.parse(widget.chatRoom.lastMessage?.createdAt as String);
      dateTimeString = dateTime.toLocal().toString().substring(11, 16);
      num_unwatched = widget.chatRoom.me.numUnwatched.toString();
      if (num_unwatched == "0") num_unwatched = "";
      bool isImage = message.substring(0, min(4, message.length)) == "http";
      if (isImage) {
        message = "Đường dẫn";
      }
      if (widget.chatRoom.lastMessage?.isDeleted == true) {
        message = "Tin nhắn đã xóa";
      }
    }

    final isAllowNotifi = widget.chatRoom.me.isAllowNotifiCation;

    return InkWell(
      // onTap: () => Navigator.of(context)
      //     .push(
      //   MaterialPageRoute(
      //     builder: (_) => ChatPage(chatRoom: widget.chatRoom),
      //   ),
      // )
      //     .then((value) {
      //   setState(() {});
      // }),
      child: Padding(
        padding: const EdgeInsets.only(
          // left: 20.0,
          // right: 20,
          bottom: 10,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                widget.chatRoom.partner.avatarUrl,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.chatRoom.partner.name,
                          style: const TextStyle(
                              fontSize: 15, fontFamily: "Loventine-Bold"),
                        ),
                      ),
                      Text(
                        dateTimeString,
                        style: const TextStyle(
                            fontSize: 12, fontFamily: "Loventine-Regular"),
                      ),
                      if (isAllowNotifi == false)
                        Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                            child: Image.asset(
                              "assets/images/no_reminders.png",
                              height: 25,
                            ))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '$message ...',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: "Loventine-Regular",
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: (num_unwatched != "") ? true : false,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(6.0),
                            child: Text(
                              num_unwatched,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
