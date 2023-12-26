import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/main.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:loventine_flutter/services/chat/message_service.dart';
import 'package:provider/provider.dart';
import 'package:volume_controller/volume_controller.dart';
import '../../../../../providers/app_socket.dart';
import '../../../../../models/call_info.dart';
import 'dart:async';
import 'package:lecle_volume_flutter/lecle_volume_flutter.dart';

class CallPage extends StatefulWidget {
  late CallInfo callInfo;
  CallPage({super.key, required this.callInfo});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  // socket
  final _socket = appSocket.socket;

  // local peers video
  final _localRTCRenderer = RTCVideoRenderer();

  // remote peers video
  final _remoteRTCRenderer = RTCVideoRenderer();

  // media stream from local peer
  MediaStream? _localStream;

  // webrtc peer connection
  RTCPeerConnection? _rtcPeerConnection;

  // ice candidates that have been collected locally
  final List<RTCIceCandidate> _iceCandidates = [];

  // media states
  bool isAudioOn = true, isVideoOn = true, isFrontCameraActive = true;

  Timer? _timer;
  int _start = 0;

  bool isMaxVolume = true;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        setState(() {
          _start = _start + 1;
        });
      },
    );
  }

  void create_message_call() {
    String _message = widget.callInfo.callType == CALL_TYPE.AUDIO
        ? 'gọi thường#'
        : 'gọi video#';
    String _time = '${(_start ~/ 3600) < 10 ? '0' : ''}${_start ~/ 3600}' +
        ':${((_start % 3600) ~/ 60) < 10 ? '0' : ''}${(_start % 3600) ~/ 60}' +
        ':${((_start % 3600) % 60) < 10 ? '0' : ''}${(_start % 3600) % 60}';

    String _type = MESSAGE_TYPE.CALL_SUCCESS;

    MessageService.create(
      widget.callInfo.chatRoomId as String,
      SocketProvider.current_user_id,
      _type,
      _message + _time,
    );
  }

  @override
  void initState() {
    _start = 0;
    startTimer();
    if (widget.callInfo.callType == CALL_TYPE.AUDIO) {
      isAudioOn = true;
      isVideoOn = false;
    } else {
      isAudioOn = true;
      isVideoOn = true;
    }
    // initialize webrtc renderers
    _localRTCRenderer.initialize();
    _remoteRTCRenderer.initialize();

    // watch common socket events like
    //  user leaving, call being denied
    _watchCommonSocketEvents();

    // setup the connection
    _setupConnection();

    init();
    // TODO: implement initState
    super.initState();
  }

  late int maxVol;
  void init() async {
    await Volume.initAudioStream(AudioManager.streamVoiceCall);
    maxVol = await Volume.getMaxVol;

    isMaxVolume = false;
    setNormalVolume();
  }

  @override
  void dispose() {
    _timer!.cancel();
    _localRTCRenderer.dispose();
    _remoteRTCRenderer.dispose();
    _localStream?.dispose();
    _rtcPeerConnection?.dispose();

    // stop watching socket events
    _socket!.off("left-call");
    _socket!.off("call-denied");
    _socket!.off("user-left");
    _socket!.off("call-accepted");
    _socket!.off("offer-answer");
    _socket!.off("offer");
    _socket!.off("ice-candidate");

    super.dispose();
  }

  _watchCommonSocketEvents() {
    _socket!.on("left-call", (data) {
      _printSpace();
      print("${widget.callInfo.receiverId} Left the call, quit now");
      _printSpace();

      _goBack();
    });

    _socket!.on("call-denied", (data) {
      _printSpace();
      print("call denied, oops");
      _printSpace();

      _goBack();
    });
  }

  _setupConnection() async {
    // create peer connection
    _rtcPeerConnection = await createPeerConnection({
      'iceServers': [
        {
          'urls': [
            'stun:stun1.l.google.com:19302',
            'stun:stun2.l.google.com:19302'
          ]
        }
      ]
    });

    // listen for media tracks from our remote pal
    _rtcPeerConnection!.onTrack = (track) {
      _printSpace();
      print("got track");
      _printSpace();

      _remoteRTCRenderer.srcObject = track.streams[0];

      setState(() {});
    };

    // create our own stream
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': isAudioOn,
      'video': isVideoOn
          ? {
              'facingMode': isFrontCameraActive ? 'user' : 'environment',
            }
          : false,
    });

    // add my local media tracks ti the rtc peer connection
    _localStream!.getTracks().forEach((track) {
      _rtcPeerConnection!.addTrack(track, _localStream!);
    });

    // set the source for my local renderer
    _localRTCRenderer.srcObject = _localStream;

    // update the page so state can be reflected
    setState(() {});

    // if we are the caller
    if (widget.callInfo.isCaller) {
      // listen for my ice candidates and add them to the ice candidate list
      _rtcPeerConnection!.onIceCandidate = (candidate) {
        setState(() => _iceCandidates.add(candidate));
      };

      // listen for whether the receiver accepts our call
      // if they accept, we create an offer and send it to them
      _socket!.on("call-accepted", (data) async {
        _printSpace();
        print("call answered");
        _printSpace();

        // create sdp offer
        var offer = await _rtcPeerConnection!.createOffer();

        // set it as our local description
        await _rtcPeerConnection!.setLocalDescription(offer);

        // send it to the fella we called
        _socket!.emit("offer",
            {'offer': offer.toMap(), 'to': widget.callInfo.receiverId});
      });

      // listen for offer answered event
      _socket!.on("offer-answer", (data) async {
        _printSpace();
        print("offer answered");
        _printSpace();

        // we set the answer as ouR remote sdp
        await _rtcPeerConnection!.setRemoteDescription(RTCSessionDescription(
            data['answer']['sdp'], data['answer']['type']));

        // we then send all collected ice candidates to the receiver
        for (var iceCandidate in _iceCandidates) {
          _socket!.emit("ice-candidate", {
            "to": widget.callInfo.receiverId,
            "candidate": {
              "sdpMid": iceCandidate.sdpMid,
              "candidate": iceCandidate.candidate,
              "sdpMLineIndex": iceCandidate.sdpMLineIndex,
            }
          });
        }
      });

      // initiate call to the remote peer
      // _socket!.emit("start-call", {"to": widget.callInfo.receiverId});

      _printSpace();
      print("start call");
      _printSpace();
    }

    // if we are the receiver
    if (!widget.callInfo.isCaller) {
      // watch out for offer
      // set it as remote sdp description,
      // generate an answer and set it as local sdp description then send it to our caller
      _socket!.on("offer", (data) async {
        _printSpace();
        print("got offer");
        _printSpace();

        // set it as remote sdp description,
        await _rtcPeerConnection!.setRemoteDescription(
            RTCSessionDescription(data['offer']['sdp'], data['offer']['type']));

        // generate an answer
        RTCSessionDescription answer = await _rtcPeerConnection!.createAnswer();

        // set answer as local sdp description then
        _rtcPeerConnection!.setLocalDescription(answer);

        // send answer to our caller
        _socket!.emit("offer-answer", {
          "answer": answer.toMap(),
          "to": widget.callInfo.receiverId,
        });
      });

      // watch out for ice candidates and add them as candidates
      _socket!.on("ice-candidate", (data) {
        _printSpace();
        print("got ice candidate");
        print("its data is $data");
        _printSpace();

        String candidate = data["candidate"]["candidate"];
        String sdpMid = data["candidate"]["sdpMid"];
        int sdpMLineIndex = data["candidate"]["sdpMLineIndex"];

        // add it
        _rtcPeerConnection!
            .addCandidate(RTCIceCandidate(candidate, sdpMid, sdpMLineIndex));
      });

      // accept call
      _socket!.emit("accept-call", {"to": widget.callInfo.receiverId});

      _socket!.on("made-recall", (data) {
        _socket!.emit("accept-call", {"to": widget.callInfo.receiverId});
      });

      _printSpace();
      print("answering call");
      _printSpace();
    }
  }

  void callerRecall() {
    _socket!.emit("make-recall", {"to": widget.callInfo.receiverId});
  }

  void notCallerReacall() {
    _socket!.emit("accept-call", {"to": widget.callInfo.receiverId});
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    final provider = Provider.of<CallProvider>(context, listen: true);

    return Scaffold(
      body: Container(
        child: Stack(
          alignment: (widget.callInfo.callType == CALL_TYPE.VIDEO)
              ? AlignmentDirectional.topStart
              : AlignmentDirectional.topCenter,
          children: [
            if (widget.callInfo.callType == CALL_TYPE.AUDIO) ...[
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
                            NetworkImage(
                                provider.partner!.avatar_url as String),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '${provider.partner?.name}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 36),
                      ),
                    ]),
              ),
            ],
            if (widget.callInfo.callType == CALL_TYPE.VIDEO) ...[
              // the person im chatting with
              Positioned.fill(
                child: RTCVideoView(_remoteRTCRenderer,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    placeholderBuilder: (_) {
                  // return RTCVideoView(
                  //   _localRTCRenderer,
                  //   objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                  //   mirror: true,
                  // );
                  // return Container(
                  //   color: Colors.grey[400],
                  //   child: Center(
                  //     child: Text(
                  //         "Vui lòng đợi, ${provider.partner!.name} đã tham gia"),
                  //   ),
                  // );
                  return Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
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
                                      NetworkImage(provider.partner!.avatar_url
                                          as String),
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  '${provider.partner?.name}',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 36),
                                ),
                                const Text(
                                  'Vui lòng đợi',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 24),
                                ),
                                const SizedBox(height: 24),
                              ]),
                        ),
                      ]);
                }),
              ),
            ],

            // my video
            if (_localRTCRenderer.srcObject != null &&
                widget.callInfo.callType == CALL_TYPE.VIDEO)
              Positioned(
                right: 16,
                top: 64,
                // height: screenSize.height / 4,
                width: 110,
                height: 180,
                // width: 120,
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: RTCVideoView(
                      _localRTCRenderer,
                      objectFit:
                          RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                      mirror: true,
                    ),
                  ),
                ),
              ),

            Positioned(
              top: 300,
              left: 24,
              child: Container(
                width: 50,
                height: 150,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(232, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(
                          100.0) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomCard(
                      width: 40,
                      height: 40,
                      borderRadius: 36,
                      onTap: () {
                        if (widget.callInfo.isCaller == true) {
                          callerRecall();
                        } else {
                          notCallerReacall();
                        }
                      },
                      child: const Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                    ),
                    if (widget.callInfo.callType == CALL_TYPE.VIDEO)
                      CustomCard(
                          width: 40,
                          height: 40,
                          borderRadius: 36,
                          childPadding: 12,
                          color: Colors.white,
                          onTap: () {
                            toggleCamera();
                          },
                          child: Image.asset('assets/images/switch_video.png',
                              color: Colors.grey)),
                  ],
                ),
              ),
            ),

            // calling with name
            Positioned(
              top: 32,
              left: 0,
              right: 0,
              child: Container(
                // color: Colors.red,
                alignment: Alignment.center,
                width: double.maxFinite,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 24,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white.withOpacity(.4),
                  ),
                  child: Text(
                    provider.partner!.name as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // stream controls
            // Positioned(
            //   left: 0,
            //   right: 0,
            //   bottom: 0,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 8),
            //     decoration: const BoxDecoration(
            //         color: Colors.black26,
            //         borderRadius: BorderRadius.only(
            //             topLeft: Radius.circular(16),
            //             topRight: Radius.circular(16))),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         // mute / unmute audio
            //         FloatingActionButton(
            //           onPressed: _toggleAudio,
            //           backgroundColor:
            //               isAudioOn ? Colors.pink[300] : Colors.black,
            //           foregroundColor: Colors.white,
            //           elevation: 0,
            //           mini: true,
            //           heroTag: " mute / unmute audio FAB",
            //           child: Icon(isAudioOn
            //               ? Icons.mic_none_outlined
            //               : Icons.mic_off_outlined),
            //         ),

            //         // show / unshow video
            //         Visibility(
            //           visible: widget.callInfo.callType == CALL_TYPE.VIDEO,
            //           child: FloatingActionButton(
            //               onPressed: _toggleVideo,
            //               backgroundColor:
            //                   isVideoOn ? Colors.pink[300] : Colors.black,
            //               foregroundColor: Colors.white,
            //               elevation: 0,
            //               mini: true,
            //               heroTag: "show / unshow video FAB",
            //               child: Icon(isVideoOn
            //                   ? Icons.videocam_rounded
            //                   : Icons.videocam_off_outlined)),
            //         ),

            //         // leave call
            //         FloatingActionButton(
            //           onPressed: () {
            //             _leaveCall();
            //             create_message_call();
            //           },
            //           backgroundColor: Colors.red[500],
            //           foregroundColor: Colors.white,
            //           elevation: 0,
            //           mini: true,
            //           heroTag: "leave call FAB",
            //           child: const Icon(Icons.call_end_outlined),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            Positioned(
              bottom: 16,
              left: (MediaQuery.sizeOf(context).width - 350.0) / 2,
              child: Container(
                width: 350,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(232, 255, 255, 255),
                  borderRadius: BorderRadius.all(Radius.circular(
                          25.0) //                 <--- border radius here
                      ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      provider.partner?.name as String,
                      style: const TextStyle(
                          color: Color(0xffEC1C24),
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '${(_start ~/ 3600) < 10 ? '0' : ''}${_start ~/ 3600}' +
                          ':${((_start % 3600) ~/ 60) < 10 ? '0' : ''}${(_start % 3600) ~/ 60}' +
                          ':${((_start % 3600) % 60) < 10 ? '0' : ''}${(_start % 3600) % 60}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(height: 12),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          CustomCard(
                              width: 56,
                              height: 56,
                              borderRadius: 36,
                              color: Colors.white,
                              childPadding: 16,
                              onTap: _toggleVolume,
                              child: isMaxVolume
                                  ? const Icon(
                                      Icons.volume_up,
                                      color: Colors.black,
                                    )
                                  : const Icon(
                                      Icons.volume_down,
                                      color: Colors.black,
                                    )),
                          CustomCard(
                            width: 56,
                            height: 56,
                            borderRadius: 36,
                            color: Colors.white,
                            childPadding: 16,
                            onTap: _toggleAudio,
                            child: isAudioOn
                                ? Image.asset('assets/images/mic.png',
                                    color: Colors.black)
                                : Image.asset(
                                    'assets/images/mic_off.png',
                                  ),
                          ),
                          const SizedBox(width: 8),
                          Visibility(
                            visible:
                                widget.callInfo.callType == CALL_TYPE.VIDEO,
                            child: CustomCard(
                              width: 56,
                              height: 56,
                              borderRadius: 36,
                              childPadding: 16,
                              color: Colors.white,
                              onTap: _toggleVideo,
                              child: isVideoOn
                                  ? Image.asset('assets/images/camera.png',
                                      color: Colors.black)
                                  : Image.asset('assets/images/camera_off.png'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          CustomCard(
                            width: 110,
                            height: 56,
                            borderRadius: 36,
                            childPadding: 16,
                            color: const Color(0xffED5454),
                            onTap: () {
                              _leaveCall();
                              create_message_call();
                              provider.stop_call();
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Kết thúc',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ),
                        ]),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toggleAudio() {
    isAudioOn = !isAudioOn;

    _localStream?.getAudioTracks().forEach((track) {
      track.enabled = isAudioOn;
    });
    setState(() {});
  }

  _toggleVideo() {
    isVideoOn = !isVideoOn;

    _localStream?.getVideoTracks().forEach((track) {
      track.enabled = isVideoOn;
    });
    setState(() {});
  }

  _unshowVideo() {}

  _leaveCall() {
    _socket!.emit("leave-call", {"to": widget.callInfo.receiverId});
    Navigator.pop(context);
    // navigatorKey.currentState?.pop();
  }

  _goBack() {
    Navigator.of(context).pop();
    // navigatorKey.currentState?.pop();
  }

  _printSpace() {
    print("<==================================>");
    print("<==================================>");
    print("\t <==================================>");
    print("<==================================>");
    print("<==================================>");
  }

  void toggleCamera() async {
    final videoTrack = _localStream!
        .getVideoTracks()
        .firstWhere((track) => track.kind == 'video');
    await Helper.switchCamera(videoTrack);
    setState(() {});
  }

  void _toggleVolume() async {
    if (isMaxVolume == true) {
      setNormalVolume();
    } else {
      setMaxVolume();
    }

    setState(() {
      isMaxVolume = !isMaxVolume;
    });
  }

  void setNormalVolume() async {
    // VolumeController().setVolume(0.3, showSystemUI: true);
    await Volume.setVol(
      androidVol: (maxVol / 4.0).toInt(),
      iOSVol: maxVol / 4.0,
      showVolumeUI: true,
    );
  }

  void setMaxVolume() async {
    // VolumeController().maxVolume(showSystemUI: true);
    await Volume.setVol(
      androidVol: maxVol,
      iOSVol: maxVol.toDouble(),
      showVolumeUI: true,
    );
  }
}
