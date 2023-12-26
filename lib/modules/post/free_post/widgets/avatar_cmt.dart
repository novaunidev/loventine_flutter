import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/widgets/inkwell/inkwell_profile.dart';

class AvatarCmt extends StatefulWidget {
  final String postId;
  final String avatar;
  final bool isPuclic;
  final bool online;
  final bool isMe;
  final String userId;
  final List<String> userComment;
  const AvatarCmt(
      {super.key,
      required this.postId,
      required this.avatar,
      required this.isPuclic,
      required this.isMe,
      required this.userId,
      required this.userComment,
      required this.online});

  @override
  State<AvatarCmt> createState() => _AvatarCmtState();
}

class _AvatarCmtState extends State<AvatarCmt> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWellProfile(
          avatar: widget.avatar,
          userId: widget.userId,
          isMe: widget.isMe,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(widget.avatar),
              ),
              if (widget.online)
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xff68c85a),
                    border: Border.all(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (widget.userComment.isEmpty) ...[
          const SizedBox()
        ] else ...[
          const Expanded(
              child: Padding(
            padding: EdgeInsets.only(bottom: 5, top: 5),
            child: VerticalDivider(
              width: 1,
              thickness: 2,
              color: Color(0xffD9D9D9),
            ),
          )),
          if (widget.isPuclic == true) ...[
            if (widget.userComment.length == 3) ...[
              SizedBox(
                height: 35,
                width: 35,
                child: Stack(
                  children: [
                    Positioned(
                        right: 0,
                        top: 0,
                        height: 18,
                        width: 18,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.userComment[0]),
                        )),
                    Positioned(
                        left: 0,
                        top: 9,
                        height: 13,
                        width: 13,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.userComment[1]),
                        )),
                    Positioned(
                        right: 9,
                        bottom: 0,
                        height: 9,
                        width: 9,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.userComment[2]),
                        ))
                  ],
                ),
              )
            ] else if (widget.userComment.length == 2) ...[
              SizedBox(
                height: 19,
                width: 34,
                child: Stack(
                  children: [
                    Positioned(
                        left: 0,
                        height: 18,
                        width: 18,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.userComment[0]),
                        )),
                    Positioned(
                        right: -2,
                        bottom: -3,
                        top: -3,
                        child: Container(
                          width: 23,
                          height: 23,
                          decoration: const BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                        )),
                    Positioned(
                        right: 0,
                        height: 18,
                        width: 18,
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.userComment[1]),
                        )),
                  ],
                ),
              )
            ] else ...[
              SizedBox(
                height: 18,
                width: 18,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(widget.userComment[0]),
                ),
              )
            ]
          ] else ...[
            SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset('assets/svgs/lock-circle.svg'))
          ]
        ]
      ],
    );
  }
}
