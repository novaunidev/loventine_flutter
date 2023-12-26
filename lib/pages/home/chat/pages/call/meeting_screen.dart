// ignore_for_file: unused_local_variable
import 'package:just_audio/just_audio.dart' as Audio;
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/call_info.dart';
import 'package:loventine_flutter/pages/home/chat/pages/call/call_page.dart';
import 'package:loventine_flutter/pages/home/chat/pages/call/page/caller_page.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'page/busy_page.dart';
import 'page/loading_page.dart';
import 'page/reciver_page.dart';

class MeetingScreen extends StatefulWidget {
  late CallInfo callInfo;
  MeetingScreen({super.key, required this.callInfo});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  // late Audio.AudioPlayer _audioPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    // _audioPlayer = Audio.AudioPlayer();
    // if (widget.callInfo.isCaller) {
    //   await _audioPlayer.setAsset("assets/audios/loviser_hold_rington.mp3");
    // } else {
    //   await _audioPlayer.setAsset("assets/audios/loviser_ringtone.mp3");
    // }

    // await _audioPlayer.setLoopMode(Audio.LoopMode.one);
    // await _audioPlayer.setVolume(1.0);
    // _audioPlayer.play();
  }

  @override
  void dispose() {
    // _audioPlayer.stop();
    // _audioPlayer.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CallProvider>(context, listen: true);

    Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Thao tác đã được chặn'),
            actions: [
              ElevatedButton(
                child: const Text('Đóng'),
                onPressed: () => Navigator.pop(context, false),
              ),
            ],
          ),
        );

    return WillPopScope(
      onWillPop: () async {
        final showPop = await showWarning(context);
        return false;
      },
      child: provider.isLoading == true
          ? const LoadingPage()
          : provider.status != ''
              ? const BusyPage()
              : provider.inCalling
                  ? const Scaffold()
                  : provider.isCaller
                      ? const CallerPage()
                      : const ReciverPage(),
    );
  }
}
