import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../providers/page/message_page/message_page_provider.dart';

class AvatarWidget extends StatefulWidget {
  final double size;
  final BoxShape? shape;
  const AvatarWidget({Key? key, this.size = 45, this.shape = BoxShape.circle})
      : super(key: key);

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  String avatarUrl = '';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<MessagePageProvider>(context, listen: false)
          .getAvatarUrl();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessagePageProvider>(
      builder: (context, value, child) {
        return CachedNetworkImage(
          imageUrl: value.avatar_url,
          imageBuilder: (context, imageProvider) => Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: widget.shape!,
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) => Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: widget.shape!,
              color: Colors.grey,
            ),
          ),
          errorWidget: (context, url, error) => Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: widget.shape!,
              color: Colors.grey,
            ),
          ),
        );
      },
    );
  }
}
