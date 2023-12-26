import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loventine_flutter/widgets/user_information/avatar_widget.dart';

Widget avatarScale(
  ScrollController scrollController,
  ValueNotifier<double> offset,
  bool isMe,
  String avatar,
) {
  //starting fab position
  const double defaultTopMargin = 200.0 - 4.0;
  //pixels from top where scaling should start
  const double scaleStart = 160.0;
  //pixels from top where scaling should end
  const double scaleEnd = scaleStart / 2;

  return ValueListenableBuilder<double>(
    valueListenable: offset,
    builder: (context, offset, child) {
      double top = defaultTopMargin;
      double scale = 1.0;
      if (scrollController.hasClients) {
        top -= offset;
        if (offset < defaultTopMargin - scaleStart) {
          //offset small => don't scale down
          scale = 1.0;
        } else if (offset < defaultTopMargin - scaleEnd) {
          //offset between scaleStart and scaleEnd => scale down
          scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
        } else {
          //offset passed scaleEnd => hide fab
          scale = 0.0;
        }
      }

      return Positioned(
        top: top - 30,
        child: Transform(
          transform: Matrix4.identity()..scale(scale * 2),
          alignment: Alignment.center,
          child: FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {},
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              width: 100,
              height: 100,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: isMe
                    ? const AvatarWidget(
                        size: 90,
                      )
                    : SizedBox(
                        height: 90,
                        width: 90,
                        child: ClipOval(
                          child: Image.network(
                            avatar,
                            fit: BoxFit.cover,
                          ),
                        )),
              ),
            ),
          ),
        ),
      );
    },
  );
}
