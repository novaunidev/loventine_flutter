import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/modules/profile/widgets/card_profile_widget.dart';
import 'package:loventine_flutter/modules/profile/widgets/card_skill_widget.dart';
import 'package:loventine_flutter/modules/profile/widgets/card_study_widget.dart';
import 'package:loventine_flutter/modules/profile/widgets/card_work_widget.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/back_icon.dart';
import 'package:loventine_flutter/widgets/shimmer_post/shimmer_post_free.dart';
import 'package:provider/provider.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import '../../../widgets/user_information/avatar_widget.dart';
import '../../../widgets/user_information/name_user_current.dart';
import '../widgets/avatar_scale.dart';

class MyProfilePage extends StatefulWidget {
  final bool isMe;
  final String userId;
  final String avatar;
  const MyProfilePage(
      {super.key,
      this.isMe = false,
      required this.userId,
      required this.avatar});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final ScrollController _scrollController = ScrollController();
  final _offset = ValueNotifier<double>(0.0);
  bool isLoading = true;
  var top = 0.0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      if (widget.isMe) {
        await Provider.of<CardProfileProvider>(context, listen: false)
            .fetchCurrentUser(widget.userId);
      } else {
        await Provider.of<CardProfileProvider>(context, listen: false)
            .fetchOtherUser(widget.userId);
      }

      setState(() {
        isLoading = false;
      });
    });
    _scrollController.addListener(() {
      _offset.value = _scrollController.offset;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final userCurrent = context.watch<CardProfileProvider>().user;
    final userOther =
        Provider.of<CardProfileProvider>(context, listen: false).userOther;
    //final size = MediaQuery.sizeOf(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFC).withOpacity(0.98),
      body: isLoading
          ? ShimmerFreeLoading(width, height)
          : SafeArea(
              top: false,
              bottom: false,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomScrollView(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        leading: BackIcon(),
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        expandedHeight: 190,
                        pinned: true,
                        stretch: true,
                        flexibleSpace: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          top = constraints.biggest.height;
                          return FlexibleSpaceBar(
                              stretchModes: const [StretchMode.zoomBackground],
                              collapseMode: CollapseMode.parallax,
                              centerTitle: true,
                              title: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AnimatedOpacity(
                                    duration: const Duration(milliseconds: 300),
                                    opacity: top <= 110.0 ? 1.0 : 0,
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        SizedBox(
                                          height: kToolbarHeight / 1.7,
                                          width: kToolbarHeight / 1.7,
                                          child: widget.isMe
                                              ? const AvatarWidget(
                                                  size: 60,
                                                )
                                              : SizedBox(
                                                  height: 60,
                                                  width: 60,
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      widget.avatar,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  )),
                                        ),
                                        const SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          widget.isMe
                                              ? nameUserCurrent(context)
                                              : userOther.name,
                                          style: const TextStyle(
                                            color: AppColor.blackColor,
                                            fontFamily: 'Loventine-Bold',
                                            fontSize: 19,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              background: Lottie.asset(
                                  "assets/lotties/backgroud_universe_ver2.json",
                                  fit: BoxFit.cover));
                        }),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Consumer<CardProfileProvider>(
                              builder: (context, data, child) {
                            return Column(
                              children: [
                                CardProfileWidget(
                                  isMe: widget.isMe,
                                  user: widget.isMe ? userCurrent : userOther,
                                  reviews: data.reviews,
                                  avatar: widget.avatar,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Works Start
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: CardWorkWidget(
                                          isMe: widget.isMe,
                                          works: data.works,
                                        )),

                                    const SizedBox(height: 20),
                                    //
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: CardStudyWidget(
                                          isMe: widget.isMe,
                                          educations: data.educations,
                                        )),
                                    const SizedBox(height: 20),
                                    //

                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: CardSkillWidget(
                                          isMe: widget.isMe,
                                          skills: data.skills,
                                        )),
                                    //
                                    // const SizedBox(height: 20),
                                    // Padding(
                                    //   padding:
                                    //       const EdgeInsets.symmetric(horizontal: 20.0),
                                    //   child: Consumer<UserLanguageProvider>(
                                    //     builder: (context, userLanguageData, _) {
                                    //       return CardLanguageWidget(
                                    //         isMe: widget.isMe,
                                    //         languages: userLanguageData.languages,
                                    //       );
                                    //     },
                                    //   ),
                                    // ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ],
                            );
                          });
                        }, childCount: 1),
                      ),
                    ],
                  ),
                  avatarScale(
                      _scrollController, _offset, widget.isMe, widget.avatar)
                ],
              ),
            ),
    );
  }
}
