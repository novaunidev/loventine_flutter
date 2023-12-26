import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/providers/app_socket.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CallProvider>(context, listen: true);
    String parner_avatar = provider.partner?.avatar_url as String;
    if (parner_avatar == "") {
      parner_avatar =
          'https://res.cloudinary.com/dc8kxjddi/image/upload/v1676186304/avatar_man_oicegg.gif';
    }

    Widget loading_body = Center(
        child: Column(
      children: const [
        Text(
          'Cuộc gọi đang được tiến hành ...',
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 16,
        ),
        CircularProgressIndicator(),
      ],
    ));

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
                loading_body,
              ]),
        ),
      ]),
    );
  }
}
