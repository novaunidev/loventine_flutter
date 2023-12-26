import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:loventine_flutter/utils/handle_string.dart';

import '../../../../../../constant.dart';

class ResultItem extends StatelessWidget {
  ResultItem(this.avatarUrl, this.name);
  final String avatarUrl;
  final String name;
  @override
  Widget build(BuildContext context) {
    final customName = HandleString.validateForLongStringWithLim(name, 30);

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: avatarUrl,
            placeholder: (context, url) => CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                avatarUrl,
              ),
            ),
            errorWidget: (context, url, error) => const CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(
                defaultAvatar,
              ),
            ),
            imageBuilder: (context, image) => CircleAvatar(
              backgroundImage: image,
              radius: 30,
            ),
          ),
          const SizedBox(width: 15),
          Text(
            customName,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
