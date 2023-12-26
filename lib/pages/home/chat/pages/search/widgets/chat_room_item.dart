import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:loventine_flutter/utils/handle_string.dart';

import '../../../../../../constant.dart';
import '../../../../../../models/chat/get.dart';

class ChatRoomItem extends StatelessWidget {
  ChatRoomItem(this.chatRoom);
  final ChatRoom chatRoom;

  @override
  Widget build(BuildContext context) {
    final customName =
        HandleString.validateForLongStringWithLim(chatRoom.partner.name, 30);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: chatRoom.partner.avatarUrl,
            placeholder: (context, url) => CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                chatRoom.partner.avatarUrl,
              ),
            ),
            errorWidget: (context, url, error) => const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                defaultAvatar,
              ),
            ),
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 30,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            customName +
                ((chatRoom.type == 'job')
                    ? (((chatRoom.isConsultant)
                        ? ' - Người tư vấn'
                        : ' - Người gặp vấn đề'))
                    : ' - Ghép cặp'),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
