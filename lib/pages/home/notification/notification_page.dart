import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_cards/flutter_custom_cards.dart';
import 'package:loventine_flutter/constant.dart';
import 'package:loventine_flutter/pages/home/notification/widgets/notifi_item.dart';
import 'package:loventine_flutter/services/notification/notification_service.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/shimmer_simple.dart';
import 'package:provider/provider.dart';
import '../../../providers/notification/notification_provider.dart';
import '../../../widgets/user_information/avatar_widget.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      var notifProvider =
          Provider.of<NotificationProvider>(context, listen: false);
      notifProvider.init();

      scrollController.addListener(() {
        if (!notifProvider.isLoadingMore &&
            scrollController.position.pixels ==
                scrollController.position.maxScrollExtent) {
          notifProvider.getMore();
          print('get more notifications');
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notificationProvider =
        Provider.of<NotificationProvider>(context, listen: true);
    final notifications = notificationProvider.notifications;
    final isLoading = notificationProvider.isLoading;

    final countWatched =
        notifications.where((notification) => !notification.isWatched).length;
    final countWatchedString =
        (countWatched >= 99) ? '99+' : countWatched.toString();

    Widget body;
    if (isLoading) {
      body = ShimmerSimple();
    } else if (notifications.isEmpty) {
      body = _noNotificationsWidget();
    } else {
      body = _notificationsScaffold(countWatchedString, notifications, context);
    }
    return Scaffold(body: body);
  }

  Widget _noNotificationsWidget() {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(
            "assets/images/searchResult_left.png",
            height: 15,
          ),
        ),
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: StreamBuilder(
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return Container();
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Không có thông báo',
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: 'Loventine-Black',
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Bạn hiện không có thông báo vào lúc này',
                    style: TextStyle(
                      fontFamily: 'Loventine-Regular',
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Image.asset(
                    'assets/images/no_notification.gif',
                    width: 300,
                    height: 300,
                  ),
                ],
              );
            }
          }),
          stream: null,
        ),
      ),
    );
  }

  Scaffold _notificationsScaffold(
      String countWatchedString, List notifications, BuildContext context) {
    final tabs = ["Tất cả", "Công việc", "Tôi thuê"];
    final tabContents = [
      _allNotifications(notifications),
      _notificationsOfType(notifications, NOTIFICATION_TYPE.JOB),
      _notificationsOfType(notifications, NOTIFICATION_TYPE.HIRING)
    ];

    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool _) {
          return [_buildSliverAppBar(countWatchedString)];
        },
        body: DefaultTabController(
          length: 3,
          child: Column(
            children: [
              _buildCustomCard(context, tabs),
              Expanded(child: TabBarView(children: tabContents)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _allNotifications(List notifications) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        controller: scrollController,
        itemCount: notifications.length +
            (Provider.of<NotificationProvider>(context, listen: true)
                    .isLoadingMore
                ? 1
                : 0),
        itemBuilder: (BuildContext context, int index) {
          if (index < notifications.length) {
            return GestureDetector(
              onLongPress: () {},
              onTap: () {},
              child: NotificationItem(notifications[index]),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _notificationsOfType(List notifications, String type) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: notifications.length,
        itemBuilder: (BuildContext context, int index) {
          if (notifications[index].type != type) return Container();
          return NotificationItem(notifications[index]);
        },
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(String countWatchedString) {
    return SliverAppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: const Text(
        'Thông báo',
        style: TextStyle(
          color: Color(0xFF0D0D26),
          fontSize: 15,
          fontFamily: "Loventine-Bold",
        ),
      ),
      elevation: 0.0,
      backgroundColor: const Color(0xFFF9F9F9),
      actions: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 0, 24, 0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              AvatarWidget(),
              Visibility(
                visible: NotificationService.num_notification_unwatch > 0,
                child: Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      maxWidth: double.infinity,
                      minHeight: 16,
                      maxHeight: double.infinity,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.all(Radius.circular(167)),
                    ),
                    child: Center(
                      child: Text(
                        NotificationService.num_notification_unwatch <= 99
                            ? NotificationService.num_notification_unwatch
                                .toString()
                            : '99+',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  CustomCard _buildCustomCard(BuildContext context, List<String> tabs) {
    return CustomCard(
      childPadding: 10,
      borderRadius: 25,
      elevation: 0,
      color: Color(0xFFF2F6FD),
      width: MediaQuery.of(context).size.width * 0.9,
      child: TabBar(
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        labelColor: Colors.black,
        tabs: tabs
            .map((tabText) => Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabText,
                    style: const TextStyle(
                        fontFamily: 'Loventine-Bold',
                        fontSize: 15,
                        color: Colors.black),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
