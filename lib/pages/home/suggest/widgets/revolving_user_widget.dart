import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/utils.dart';
import '../widgets/rotating_dotted_circle.dart';

GlobalKey revolvingWidgetKey = GlobalKey();

class RevolvingUserWidget extends StatefulWidget {
  const RevolvingUserWidget({Key? key}) : super(key: key);

  @override
  _RevolvingUserWidgetState createState() => _RevolvingUserWidgetState();
}

class _RevolvingUserWidgetState extends State<RevolvingUserWidget> {
  final double distanceBetweenDottedCircle = 125;
  final double smallestCircleHeight = 50;
  final double delta = 50;

  @override
  Widget build(BuildContext context) {
    final userList = UserList.users;
    return Stack(
      key: revolvingWidgetKey,
      alignment: Alignment.center,
      children: [
        RotatingDottedCircle(
          height: smallestCircleHeight +
              2 * delta +
              2 * distanceBetweenDottedCircle,
          users: userList.sublist(0, 4),
        ),
        RotatingDottedCircle(
          height: smallestCircleHeight + delta + distanceBetweenDottedCircle,
          rotationDirection: RotationDirection.counterclockwise,
          users: userList.sublist(4),
        ),
        RotatingDottedCircle(
          height: smallestCircleHeight,
          users: const [],
        ),
      ],
    );
  }
}
