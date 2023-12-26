import 'package:flutter/material.dart';

class MoreUserPage extends StatefulWidget {
  const MoreUserPage({super.key});

  @override
  State<MoreUserPage> createState() => _MoreUserPageState();
}

class _MoreUserPageState extends State<MoreUserPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    final app_bar = Container(
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
            const Text(
              'Người khác',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      clipBehavior: Clip.none,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            SizedBox(height: height),
            app_bar,
            const SizedBox(height: 16),
            // for (int index = 0; index < users.length; index++) ...[
            //   GestureDetector(
            //     onTap: () async {
            //       var chatroom = await chatSearchProvider
            //           .getChatRoomFromUserItem(users[index]);
            //       Navigator.of(context).push(
            //         MaterialPageRoute(
            //           builder: (_) => ChatPage(
            //             chatRoom: chatroom,
            //             isConsultantisCurrent: true,
            //           ),
            //         ),
            //       );
            //     },
            //     child: ResultItem(users[index].avatarUrl, users[index].name),
            //   ),
            // ],
          ],
        ),
      ),
    ));
  }
}
