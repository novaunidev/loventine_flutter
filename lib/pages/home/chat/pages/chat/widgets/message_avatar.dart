import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MessageAvatar extends StatelessWidget {
  final double size;
  final String avatarUrl;

  const MessageAvatar({Key? key, this.size = 45, required this.avatarUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: avatarUrl,
      placeholder: (context, url) => Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey,
        ),
      ),
      imageBuilder: (context, image) => CircleAvatar(
        backgroundImage: image,
        radius: size,
      ),
    );
  }
}
