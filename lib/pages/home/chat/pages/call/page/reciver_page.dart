import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/providers/app_socket.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReciverPage extends StatelessWidget {
  const ReciverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CallProvider>(context, listen: true);
    String parner_avatar = provider.partner?.avatar_url as String;
    if (parner_avatar == "") {
      parner_avatar =
          'https://res.cloudinary.com/dc8kxjddi/image/upload/v1676186304/avatar_man_oicegg.gif';
    }

    List<Widget> calling_reciver_body = [
      Text(
        'Đang gọi ${(provider.callType == CALL_TYPE.AUDIO) ? 'thường' : 'video'} đến bạn...',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w400, fontSize: 15),
      ),
      const SizedBox(height: 100),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCard(
            width: 72,
            height: 72,
            borderRadius: 36,
            color: Colors.red,
            onTap: () {
              provider.create_message_call();
              provider.endMeeting();
            },
            child: const Icon(
              Icons.call_end,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(width: 72),
          CustomCard(
            width: 72,
            height: 72,
            borderRadius: 36,
            color: Colors.lightGreenAccent,
            onTap: () {
              provider.meeting_agree();
            },
            child: const Icon(
              Icons.call,
              color: Colors.white,
              size: 50,
            ),
          ),
        ],
      )
    ];

    return Scaffold(
      body: Stack(alignment: AlignmentDirectional.topCenter, children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg_call.gif"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(206, 38, 41, 51),
        ),
        Positioned(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 100.0,
                  backgroundImage:
                      // AssetImage('assets/images/avt_default.gif'),
                      NetworkImage(parner_avatar),
                ),
                const SizedBox(height: 24),
                Text(
                  '${provider.partner?.name}',
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 36),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: debugMode,
                  child: Text('Socket id : ${appSocket.socket.id as String}'),
                ),
                ...calling_reciver_body,
              ]),
        ),
      ]),
    );
  }
}
