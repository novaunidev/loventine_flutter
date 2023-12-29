// ignore_for_file: non_constant_identifier_names

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:loventine_flutter/animation/like_effect.dart';
import 'package:loventine_flutter/models/post_all.dart';
import 'package:loventine_flutter/modules/post/free_post_all_page.dart';
import 'package:loventine_flutter/modules/post/post_detail_screen.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/user_image_provider.dart';
import 'package:loventine_flutter/providers/post_all/bookmark_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_provider.dart';
import 'package:loventine_flutter/widgets/shimmer_post/shimmer_post_free.dart';
import 'package:loventine_flutter/widgets/user_information/name_user_current.dart';
import 'package:provider/provider.dart';

import '../providers/post_all/like_provider.dart';

class UserPostFree extends StatefulWidget {
  // final String userId;
  // final String avatar;
  const UserPostFree({super.key});

  @override
  State<UserPostFree> createState() => _UserPostFreeState();
}

class _UserPostFreeState extends State<UserPostFree> {
  bool isLoading = true;
  List<PostAll> postFreeUser = [];
  late String current_user_id = '';
  String avatarUrl = "";
  bool _showLike = false;
  late Offset _tapPosition;
  int indexDoubleTap = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
          .current_user_id;
      avatarUrl = Provider.of<UserImageProvider>(context, listen: false).avatar;
      // await Provider.of<PostFreeOfUserProvider>(context, listen: false)
      //     .getAllFreePostsOfUser(current_user_id);
      // postFreeUser = Provider.of<PostFreeOfUserProvider>(context, listen: false)
      //     .postFreeUser;
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    final likeProvider = Provider.of<LikeProvider>(context, listen: false);
    final postFreeProvider =
        Provider.of<PostFreeProvider>(context, listen: false);
    final postFreeUserProvider =
        Provider.of<PostFreeOfUserProvider>(context, listen: false);
    final bookMarkProvider =
        Provider.of<BookmarkProvider>(context, listen: false);
    Future<void> onLikeDoubleTapped(PostAll post) async {
      final result = await Connectivity().checkConnectivity();
      if (result != ConnectivityResult.none) {
        if (post.isLike == false) {
          likeProvider.addLike(post.id, current_user_id);
          postFreeProvider.updateLikeInFreePost(post.id, true);
          postFreeProvider.updateLikeInFreePost1(post.id, true);
          postFreeUserProvider.updateLikeInFreePostofUser(post.id, true);
          bookMarkProvider.updateLikeInBookmarkPost(post.id, true);
        }
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  "assets/images/searchResult_left.png",
                  height: 15,
                ),
              ),
              title: const Text(
                "Quay lại",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Loventine-Regular",
                    fontSize: 15),
              ),
              toolbarHeight: 60,
              titleSpacing: -10,
              backgroundColor: Colors.white,
              elevation: 0,
            )
          ],
          body: isLoading
              ? ShimmerFreeLoading(width, height)
              :  SingleChildScrollView(
                      child: Consumer<PostFreeProvider>(
                      builder: (context, postAllData, _) => ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: postAllData.postFree.length,
                          itemBuilder: (context, index) {
                            final post = postAllData.postFree[index];
                            return post.userId != current_user_id
                            ?SizedBox()
                            :GestureDetector(
                                onDoubleTapDown: (details) {
                                  setState(() {
                                    _tapPosition = details.localPosition;
                                    _showLike = true;
                                    indexDoubleTap = index;
                                  });
                                  onLikeDoubleTapped(
                                      postAllData.postFree[index]);
                                },
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostDetailScreen(
                                              post: postAllData
                                                  .postFree[index],
                                              userId: current_user_id,
                                              avatar: avatarUrl,
                                              page: 2,
                                              type: "freeUser",
                                              userName:
                                                  nameUserCurrent(context),
                                              index: index,
                                            )),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Container(
                                      color: Colors.white,
                                      child: FreePostItem(
                                        avatar: avatarUrl,
                                        post: postAllData.postFree[index],
                                        userId: current_user_id,
                                        userName: "",
                                        index: index,
                                        type: "freeUser",
                                      ),
                                    ),
                                    if (_showLike && indexDoubleTap == index)
                                      LikeEffect(
                                        onCompleted: (value) => setState(() {
                                          _showLike = value;
                                        }),
                                        top: _tapPosition.dy,
                                        left: _tapPosition.dx,
                                      ),
                                  ],
                                ));
                          }),
                    )),
        ));
  }
}
