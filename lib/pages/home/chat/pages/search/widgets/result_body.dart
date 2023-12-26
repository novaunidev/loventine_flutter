import 'package:flutter/material.dart';

import 'package:loventine_flutter/providers/chat/chat_search_provider.dart';
import 'package:provider/provider.dart';

import '../../chat/chat_page.dart';

import 'chat_room_item.dart';

class ResultBody extends StatefulWidget {
  const ResultBody({super.key});

  @override
  State<ResultBody> createState() => _ResultBodyState();
}

class _ResultBodyState extends State<ResultBody> {
  @override
  Widget build(BuildContext context) {
    final chatSearchProvider =
        Provider.of<ChatSearchProvider>(context, listen: true);

    final chatrooms = chatSearchProvider.chatRooms;
    return Column(
      children: [
        const SizedBox(height: 24),
        if (chatSearchProvider.isLoadingSearchChatRoom)
          const Center(child: CircularProgressIndicator()),
        // if (chatrooms.isEmpty &&
        //     chatSearchProvider.isLoadingSearchChatRoom == false)
        //   const Text(
        //     'Danh sách trống',
        //     style: TextStyle(color: Colors.grey),
        //   ),
        for (int index = 0; index < chatrooms.length; index++) ...[
          GestureDetector(
            onTap: () async {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ChatPage(
                    chatRoom: chatrooms[index],
                    isConsultantisCurrent: true,
                  ),
                ),
              );
            },
            child: ChatRoomItem(chatrooms[index]),
          ),
        ],
        const SizedBox(height: 16),

        const SizedBox(height: 16),
        if (chatSearchProvider.isLoadingSearchUser == true)
          const Center(child: CircularProgressIndicator()),
      ],
    );
  }
}
