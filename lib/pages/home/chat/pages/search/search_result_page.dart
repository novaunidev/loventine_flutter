import 'dart:math';

import 'package:flutter/material.dart';

import 'package:loventine_flutter/pages/home/chat/pages/search/widgets/result_body.dart';
import 'package:loventine_flutter/providers/chat/chat_search_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../../models/chat/get.dart';
import '../../../../../constant.dart';
import '../../widgets/item_message.dart';
import '../chat/chat_page.dart';

class SearchResultPage extends StatefulWidget {
  final List<ChatRoom> chatrooms;
  const SearchResultPage(this.chatrooms);

  @override
  State<SearchResultPage> createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChatSearchProvider>(context, listen: false).initSearchPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;
    List<ChatRoom> myjobs = widget.chatrooms.where((chatRoom) {
      if (chatRoom.type == 'job' && chatRoom.isConsultant == true) return true;
      return false;
    }).toList();
    List<ChatRoom> myhirings = widget.chatrooms.where((chatRoom) {
      if (chatRoom.type == 'job' && chatRoom.isConsultant == false) return true;
      return false;
    }).toList();
    List<ChatRoom> matchings = widget.chatrooms.where((chatRoom) {
      if (chatRoom.type == 'matching') return true;
      return false;
    }).toList();

    final search_bar = Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back)),
            const SizedBox(width: 15),
            Expanded(
              child: TextField(
                autofocus: true,
                controller: _controller,
                onChanged: ((value) {
                  Provider.of<ChatSearchProvider>(context, listen: false)
                      .search(value.trim());
                  Provider.of<ChatSearchProvider>(context, listen: false)
                      .setterSearchString(value.trim());
                  setState(() {});
                }),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Tìm kiếm',
                  hintStyle: TextStyle(
                    fontFamily: 'Loventine-Semibold',
                  ),
                ),
              ),
            ),
            IconButton(
              alignment: Alignment.center,
              onPressed: () {
                _controller.clear();
                setState(() {});
              },
              icon: const Icon(Icons.clear),
            ),
          ],
        ),
      ),
    );

    groupWidgets(context, List<ChatRoom> chatrooms, String title) {
      return [
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
        const SizedBox(height: 16),
        if (chatrooms.isEmpty)
          const Text(
            'Danh sách trống',
            style: TextStyle(color: Colors.grey),
          ),
        for (int index = 0;
            index < min(chatrooms.length, limitItems);
            index++) ...[
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ChatPage(
                      chatRoom: chatrooms[index],
                      isConsultantisCurrent: true,
                    ),
                  ),
                );
              },
              child: ItemMessage(chatRoom: chatrooms[index])),
        ],
      ];
    }

    final default_body = [
      const SizedBox(height: 24),
      ...groupWidgets(context, myjobs, my_jobs),
      const SizedBox(height: 16),
      ...groupWidgets(context, myhirings, my_hirings),
      const SizedBox(height: 16),
      ...groupWidgets(context, matchings, matching),
    ];

    return Scaffold(
        body: SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            SizedBox(height: height),
            search_bar,
            if (_controller.text.trim() == '') ...default_body,
            if (_controller.text.trim() != '') const ResultBody(),
          ],
        ),
      ),
    ));
  }
}
