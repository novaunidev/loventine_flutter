// ignore_for_file: unused_field

import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/models/call_info.dart';
import 'package:loventine_flutter/providers/app_socket.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:loventine_flutter/services/chat/message_service.dart';
import 'package:loventine_flutter/utils/utils.dart';
import '../../main.dart';
import '../../models/chat/user_meeting.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:just_audio/just_audio.dart' as Audio;
import 'package:audio_session/audio_session.dart';
import 'package:path/path.dart';

class CallProvider extends ChangeNotifier {
  bool _isCaller = true;
  bool get isCaller => _isCaller;

  UserMeeting? _partner;
  UserMeeting? get partner => _partner;

  String _callType = '';
  String get callType => _callType;

  String _chatRoomId = '';
  String get chatRoomId => _chatRoomId;

  bool _isCallingSuccess = false;
  bool get isCallingSuccess => _isCallingSuccess;

  void setIsCallingSuccess(value) {
    _isCallingSuccess = value;
    notifyListeners();
  }

  String _status = '';
  String get status => _status;

  bool _inCalling = false;
  bool get inCalling => _inCalling;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isInCallPage = false;
  bool get isInCallPage => _isInCallPage;

  void setIsInCallPage(value) {
    _isInCallPage = value;
  }

  void init() {
    appSocket.socket.on('open_calling_ui', (jsonData) {
      try {
        reset();
        // print('open_calling_ui');
        //print(jsonData);
        // Map<String, dynamic> data = json.decode(jsonData) as Map<String, dynamic>;
        //print(json.encode(jsonData));

        final new_t = json.encode(jsonData);
        final data = json.decode(new_t) as Map<String, dynamic>;
        print('kiet');
        print(data);
        _isCaller = data['isCaller'];
        // if (isCaller == false) {
        //   caller_id = data['caller_id'];
        //   _MeetingScreen_caller_name = data['caller_name'];
        // }
        //print(data['partner']);
        _callType = data['call_type'];
        _chatRoomId = data["chatRoomId"];

        _partner = UserMeeting.fromJson(data);
        // print(_MeetingScreen_partner?.toJson());

        notifyListeners();

        if (_isCaller == true) {
          playAudio("assets/audios/loviser_hold_rington.mp3");
        } else {
          playAudio("assets/audios/loviser_ringtone.mp3");
        }

        // String? currentPath;
        // navigatorKey.currentState?.popUntil((route) {
        //   currentPath = route.settings.name;
        //   return true;
        // });
        // print('heelo ${ModalRoute.of(context)!.settings.name}');

        if (_isInCallPage == true) {
          navigatorKey.currentState?.pushReplacementNamed(
            '/meeting',
            arguments: CallInfo(
              callerId: SocketProvider.current_user_id,
              receiverId: _partner?.id,
              chatRoomId: chatRoomId,
              callType: _callType,
              isCaller: _isCaller,
            ),
          );
        } else {
          _isInCallPage = true;
          navigatorKey.currentState?.pushNamed(
            '/meeting',
            arguments: CallInfo(
              callerId: SocketProvider.current_user_id,
              receiverId: _partner?.id,
              chatRoomId: chatRoomId,
              callType: _callType,
              isCaller: _isCaller,
            ),
          );
        }
      } catch (err) {
        print(err);
      }
    });

    appSocket.socket.on('meeting_refresh_media', (jsonData) async {
      // _isLoading = true;
      _isCallingSuccess = true;

      _status = 'stop';
      stopAudio();
      notifyListeners();

      navigatorKey.currentState?.pushNamed(
        '/call-page',
        arguments: CallInfo(
          callerId: SocketProvider.current_user_id,
          receiverId: _partner?.id,
          chatRoomId: chatRoomId,
          callType: _callType,
          isCaller: _isCaller,
        ),
      );
      // clear music when waiting
      // state_of_audioPlayer = false;
      // await _audioPlayer.stop();
      // await _audioPlayer.dispose();

      // final session = await AudioSession.instance;
      // await session.configure(const AudioSessionConfiguration(
      //   androidAudioAttributes: AndroidAudioAttributes(
      //     usage: AndroidAudioUsage.voiceCommunicationSignalling,
      //   ),
      // ));

      // signaling = Signaling();
      // await _localRenderer.initialize();
      // await _remoteRenderer.initialize();

      // signaling.onAddRemoteStream = ((stream) {
      //   _remoteRenderer.srcObject = stream;
      //   notifyListeners();
      // });

      // _inCalling = true;
      // _start = 0;

      // openCameraAndMic();

      // Future.delayed(const Duration(seconds: 2));

      // if (_isCaller) {
      //   await createRoom();
      // }

      //  _isLoading = false;
      // notifyListeners();
    });

    appSocket.socket.on('stop_call', (jsonData) {
      _status = 'stop';
      stopAudio();
      notifyListeners();
    });

    appSocket.socket.on('receiver_busy', (jsonData) {
      //print("receiver_busy");
      stopAudio();
      _status = 'receiver_busy';

      final new_t = json.encode(jsonData);
      final data = json.decode(new_t) as Map<String, dynamic>;
      print('kiet');
      print(data);
      _isCaller = data['isCaller'];
      // if (isCaller == false) {
      //   caller_id = data['caller_id'];
      //   _MeetingScreen_caller_name = data['caller_name'];
      // }
      //print(data['partner']);
      _callType = data['call_type'];

      _partner = UserMeeting.fromJson(data);
      // print(_MeetingScreen_partner?.toJson());
      _isCallingSuccess = false;
      create_message_call();
      notifyListeners();

      navigatorKey.currentState?.pushNamed(
        '/meeting',
        arguments: CallInfo(
          callerId: SocketProvider.current_user_id,
          receiverId: _partner?.id,
          chatRoomId: chatRoomId,
          callType: _callType,
          isCaller: _isCaller,
        ),
      );
    });

    appSocket.socket.on('meeting_agreed', (jsonData) {
      _status = 'meeting_agreed';
      stopAudio();
      notifyListeners();
    });
  }

  void endMeeting() {
    stopAudio();
    _isCallingSuccess = false;
    if (_status != 'meeting_agreed') {
      stop_call();
    }
    // hangUp();
    _status = 'stop';
    // if (_MeetingScreen_MediaConection != null) {
    //   _MeetingScreen_MediaConection?.close();
    // }
    //initRenderers();
    // if (state_of_audioPlayer == true) {
    //   audio_stop();
    // }
    notifyListeners();
    //('stop meeting');
  }

  // Audio.AudioPlayer _audioPlayer = new Audio.AudioPlayer();
  // bool state_of_audioPlayer = false;

  // Future<void> audio_play(String url) async {
  //   state_of_audioPlayer = true;
  //   final session = await AudioSession.instance;
  //   await session.configure(const AudioSessionConfiguration(
  //     androidAudioAttributes: AndroidAudioAttributes(
  //       usage: AndroidAudioUsage.voiceCommunicationSignalling,
  //     ),
  //   ));

  //   _audioPlayer = Audio.AudioPlayer();
  //   await _audioPlayer.setAsset(url);
  //   await _audioPlayer.setLoopMode(Audio.LoopMode.one);
  //   await _audioPlayer.setVolume(1.0);
  //   _audioPlayer.play();
  // }

  // void audio_stop() {
  //   state_of_audioPlayer = false;
  //   _audioPlayer.stop();
  //   // _audioPlayer.dispose();
  // }

  void reset() {
    _isCaller = true;
    _inCalling = false;
    _inCalling = false;
    _status = '';
  }

  void make_call(
      String? partnerId, String? call_type, String? value_chatRoomId) {
    Map data = {
      'receiver_id': (partnerId == null) ? '${_partner?.id}' : partnerId,
      'call_type': (call_type == null) ? _callType : call_type,
      'chatRoomId': (value_chatRoomId == null) ? _chatRoomId : value_chatRoomId,
    };
    appSocket.socket.emit("make_call", data);
  }

  void stop_call() {
    Map data = {
      'receiver_id': '${_partner?.id}',
    };
    appSocket.socket.emit("stop_call", data);
  }

  void meeting_agree() {
    Map data = {
      'partner_user_id': '${_partner?.id}',
    };
    appSocket.socket.emit("meeting_agree", data);
  }

  void create_message_call() {
    if (_status == 'meeting_agreed') return;
    String _message =
        _callType == CALL_TYPE.AUDIO ? 'gọi thường#' : 'gọi video#';

    String _time = '';
    String _type = MESSAGE_TYPE.CALL_FAILED;

    MessageService.create(
      _chatRoomId,
      SocketProvider.current_user_id,
      _type,
      _message + _time,
    );
  }
}
