import 'package:flutter/material.dart';

import '../../../../constant.dart';
import '../../../../models/notification.dart' as NotificationModel;
import '../../../../utils/handle_string.dart';
import '../../../../values/app_color.dart';

class NotificationItem extends StatelessWidget {
  final NotificationModel.Notification notification;
  NotificationItem(this.notification);

  @override
  Widget build(BuildContext context) {
    final isSystemNotification =
        notification.receiver == notification.author!.sId;
    String noti_text = ((isSystemNotification == false &&
                notification.text.contains(notification.author!.name) == false)
            ? '${notification.author!.name} '
            : '') +
        notification.text;
    return Column(
      children: [
        Row(
          children: [
            if (!isSystemNotification)
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(notification.author!.avatarUrl),
              ),
            if (isSystemNotification)
              CircleAvatar(
                radius: 25,
                child: Image.asset("assets/images/LOVISER_ICON.png"),
              ),
            Container(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    noti_text,
                    style: TextStyle(
                      fontFamily: notification.isWatched == false
                          ? 'Loventine-Bold'
                          : 'Loventine-Regular',
                      color: notification.isWatched == false
                          ? Color(0xff0D0D26)
                          : Color(0xff95969D),
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Container(
                    height: 3,
                  ),
                  Row(
                    children: [
                      Text(
                          HandleString.timeDistanceFromNow(
                              DateTime.parse(notification.createdAt)),
                          style: TextStyle(
                            fontFamily: notification.isWatched == false
                                ? 'Loventine-Semibold'
                                : 'Loventine-Regular',
                            color: notification.isWatched == false
                                ? Color(0xff0D0D26)
                                : Color(0xff95969D),
                            fontSize: 14,
                          )),
                      Container(
                        width: 3,
                      ),
                      if (notification.isWatched == false)
                        Container(
                          height: 9,
                          width: 9,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.mainColor,
                            border:
                                Border.all(width: 2, color: AppColor.mainColor),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        Container(
          height: 10,
        )
      ],
    );
  }
}
