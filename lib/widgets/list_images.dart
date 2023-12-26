// import 'package:cached_network_image/cached_network_image.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ListImages extends StatelessWidget {
  final PostAll post;
  final int indexColumn;
  final double? paddingLeft;

  const ListImages(
      {super.key,
      required this.post,
      required this.indexColumn,
      this.paddingLeft = 60});

  @override
  Widget build(BuildContext context) {
    return post.images.isEmpty
        ? Container()
        : post.images.length == 1
            ? GestureDetector(
                onTap: () {
                  Navigator.push(context, PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ImageDetail(
                          images: post.images,
                          tag: "$indexColumn",
                          initialIndex: 0,
                        ),
                      );
                    },
                  ));
                },
                child: Hero(
                  tag: "$indexColumn",
                  child: Padding(
                    padding: EdgeInsets.only(
                        right: 20, left: paddingLeft!, bottom: 10),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(post.images[0])),
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 7, bottom: 15),
                child: SizedBox(
                  height: 240,
                  width: MediaQuery.sizeOf(context).width,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) => true,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: post.images.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: ImageDetail(
                                      images: post.images,
                                      tag: "$indexColumn" "$index",
                                      initialIndex: index,
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                          child: index == 0
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      right: 5, left: paddingLeft!),
                                  child: Hero(
                                    tag: "$indexColumn" "$index",
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        // border: Border.all(width: 0.1, color: Colors.black),
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(post.images[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Hero(
                                    tag: "$indexColumn" "$index",
                                    child: Container(
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image:
                                              NetworkImage(post.images[index]),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              );
  }
}

class ImageDetail extends StatefulWidget {
  final String tag;
  final List<String> images;
  final int initialIndex;
  const ImageDetail(
      {super.key,
      required this.images,
      required this.tag,
      required this.initialIndex});

  @override
  State<ImageDetail> createState() => _ImageDetailState();
}

class _ImageDetailState extends State<ImageDetail> {
  late PageController _pageController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return DismissiblePage(
      onDismissed: () => Navigator.of(context).pop(),
      // Start of the optional properties
      isFullScreen: false,
      disabled: false,
      minRadius: 10,
      maxRadius: 10,
      dragSensitivity: 1.0,
      maxTransformValue: .8,
      direction: DismissiblePageDismissDirection.multi,
      backgroundColor: Colors.black,
      // onDragStart: () {
      //   print('onDragStart');
      // },
      // onDragUpdate: (details) {
      //   print(details);
      // },
      dismissThresholds: {
        DismissiblePageDismissDirection.vertical: .2,
      },
      minScale: .8,
      startingOpacity: 1,
      reverseDuration: const Duration(milliseconds: 250),
      // End of the optional properties
      child: Hero(
        tag: widget.tag,
        child: PhotoViewGallery.builder(
          builder: (BuildContext context, int index) =>
              PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(widget.images[index]),
            maxScale: PhotoViewComputedScale.covered,
            minScale: PhotoViewComputedScale.contained,
          ),
          itemCount: widget.images.length,
          // loadingBuilder: (context, event) =>
          //     _imageGalleryLoadingBuilder(event),
          pageController: _pageController,
          scrollPhysics: const ClampingScrollPhysics(),
        ),
      ),
    );
  }
}
