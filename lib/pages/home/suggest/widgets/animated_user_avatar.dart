import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/utils.dart';
import '../widgets/user_avatar.dart';

class AnimatedUserAvatar extends StatelessWidget {
  final User user;
  const AnimatedUserAvatar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -48),
      child: SizedBox(
        height: 50,
        child: TweenAnimationBuilder(
          duration: 600.ms,
          curve: Curves.easeInOutCirc,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (_, double value, __) {
            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: UserAvatar(
                    user: user,
                    radius: 8 * value + 40 * value * value,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
