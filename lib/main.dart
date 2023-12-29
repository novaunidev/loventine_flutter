// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unused_local_variable
import 'dart:io';
import 'dart:math';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/models/call_info.dart';
import 'package:loventine_flutter/models/hives/count_app.dart';
import 'package:loventine_flutter/modules/auth/app_auth.dart';
import 'package:loventine_flutter/pages/home/chat/pages/call/call_page.dart';
import 'package:loventine_flutter/providers/app_socket.dart';
import 'package:loventine_flutter/pages/home/chat/message_page.dart';
import 'package:loventine_flutter/pages/home/chat/pages/call/meeting_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loventine_flutter/providers/call/call_provider.dart';
import 'package:loventine_flutter/providers/chat/chat_room_provider.dart';
import 'package:loventine_flutter/providers/chat/chat_search_provider.dart';
import 'package:loventine_flutter/providers/information_provider.dart';
import 'package:loventine_flutter/providers/post_all/like_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_delete_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_fee_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_of_user_provider.dart';
import 'package:loventine_flutter/providers/post_all/post_free_provider.dart';
import 'package:loventine_flutter/providers/verify_provider.dart';
import 'package:loventine_flutter/services/firebase_fcm.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:loventine_flutter/providers/chat/chat_page_provider.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/card_profile_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/providers/post_filter/post_filter_provider.dart';
import 'package:loventine_flutter/providers/search_post/implements/search_post_viewmodel.dart';
import 'package:loventine_flutter/providers/search_post/interfaces/isearch_post_viewmodel.dart';
import 'package:loventine_flutter/services/notification/notifi_service.dart';
import 'models/hives/image_url.dart';
import 'modules/post/free_post/create_free_post.dart';
import 'modules/post/free_post_all_page.dart';

import '../providers/post_all/bookmark_provider.dart';
import './providers/posts.dart';
import './providers/applys.dart';
import './providers/authentication.dart';
import './providers/profiles.dart';
import './providers/saved_posts.dart';
import './providers/users.dart';
import '/providers/post_all/post_all_provider.dart';

import 'package:provider/provider.dart';

import '/providers/page/message_page/user_image_provider.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '/models/hives/userid.dart';
import '/providers/post_all/post_fee_provider.dart';
import 'pages/home/suggest/pages/suggest_page.dart';
import 'providers/banner/banner_home_provider.dart';
import 'providers/network_info.dart';
import 'providers/page/home_page_provider.dart';
import 'widgets/bottom_sheet_login.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive
    ..registerAdapter(UserIdAdapter())
    ..registerAdapter(CountAppAdapter())
    ..registerAdapter(ImageUrlAdapter());
  await Future.wait([
    Hive.openBox<UserId>('userBox'),
    Hive.openBox<CountApp>('countBox'),
    Hive.openBox<ImageUrl>('imageUrl'),
    Hive.openBox('loginBox'),
  ]);

  // await NotificationService().initNotification();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Posts()),
        ChangeNotifierProvider.value(value: PostFilterProvider()),
        ChangeNotifierProvider.value(value: Applys()),
        ChangeNotifierProvider.value(value: Authentication()),
        ChangeNotifierProvider.value(value: Profiles()),
        ChangeNotifierProvider.value(value: SavedPosts()),
        ChangeNotifierProvider.value(value: Users()),
        ChangeNotifierProvider.value(value: MessagePageProvider()),
        ChangeNotifierProvider.value(value: CardProfileProvider()),
        ChangeNotifierProvider.value(value: UserImageProvider()),
        ChangeNotifierProvider.value(value: SocketProvider()),
        ChangeNotifierProvider.value(value: PostAllProvider()),
        ChangeNotifierProvider.value(value: BookmarkProvider()),
        ChangeNotifierProvider.value(value: PostFeeProvider()),
        ChangeNotifierProvider.value(value: ChatPageProvider()),
        ChangeNotifierProvider.value(value: ChatRoomProvider()),
        ChangeNotifierProvider.value(value: ChatSearchProvider()),
        ChangeNotifierProvider.value(value: PostFreeProvider()),
        ChangeNotifierProvider.value(value: LikeProvider()),
        ChangeNotifierProvider.value(value: PostFreeOfUserProvider()),
        ChangeNotifierProvider.value(value: PostFeeOfUserProvider()),
        ChangeNotifierProvider.value(value: PostDeleteProvider()),
        ChangeNotifierProvider<ISearchPostViewModel>(
          create: (_) => SearchPostViewModel(),
        ),
        ChangeNotifierProvider.value(value: CallProvider()),
        ChangeNotifierProvider.value(value: VerifyProvider()),
        ChangeNotifierProvider.value(value: InformationProvider()),
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
        ChangeNotifierProvider(create: (context) => BannerHomeProvider()),
        ChangeNotifierProvider(create: (context) => NetworkInfo()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),

        home: AppLifecycleObserver(
          child: const MainPage(currentIndex: 0),
        ),

        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        //initialRoute: '/',
        routes: {
          '/call-page': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as CallInfo;
            return CallPage(
              callInfo: args,
            );
          },
          '/meeting': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as CallInfo;
            return MeetingScreen(
              callInfo: args,
            );
          },
          '/chat_screen': (context) {
            return const MainPage(currentIndex: 3);
          },
          '/notification': (context) {
            return const MainPage(currentIndex: 4);
          },
          '/login': (context) => const MainPage(currentIndex: 0),
        },

        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
        ],
      ),
    ),
  );
}

class AppLifecycleObserver extends StatefulWidget {
  final Widget child;

  AppLifecycleObserver({required this.child});

  @override
  _AppLifecycleObserverState createState() => _AppLifecycleObserverState();
}

class _AppLifecycleObserverState extends State<AppLifecycleObserver>
    with WidgetsBindingObserver {
  late NetworkInfo networkInfo;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    networkInfo = NetworkInfo(onConnectivityChangedCallback: () {
      String message;
      SnackbarType type;
      if (networkInfo.connectionStatus == ConnectivityResult.none) {
        message = "Bạn đang ngoại tuyến";
        type = SnackbarType.warning;
      } else {
        message = "Đã khôi phục kết nối mạng";
        type = SnackbarType.success;
      }

      CustomSnackbar.show(context, title: message, type: type);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void updateAppState(String state) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('app_state', state);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      print("RESUMED");
      updateAppState("RESUMED");
    }

    if (state == AppLifecycleState.inactive) {
      print("INACTIVE");
      updateAppState("INACTIVE");
    }

    if (state == AppLifecycleState.paused) {
      print("PAUSED");
      updateAppState("PAUSED");
    }

    if (state == AppLifecycleState.detached) {
      print("DETACHED");
      updateAppState("DETACHED");
      // FlutterBackgroundService().startService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class MainPage extends StatefulWidget {
  final int currentIndex;

  const MainPage({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void dispose() {
    super.dispose();
  }

  late String current_user_id;
  bool isLogin = false;
  bool countOnboarding = false;
  late List<bool> _hasBeenInitialized;

  @override
  void initState() {
    final box = Hive.box<UserId>('userBox');
    UserId? userId = box.get('userid');
    if (userId != null) {
      current_user_id = userId.userid!;
    }
    isLogin = Provider.of<MessagePageProvider>(context, listen: false).isLogin;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await appSocket.init(current_user_id, context);
      Provider.of<MessagePageProvider>(context, listen: false)
          .setCurrentUserId(current_user_id);
      print('jwt kiet ${appAuth.isNeedLogout}');
      if (appAuth.isNeedLogout == true) {
        appAuth.setNeedLogout(false);
        handleLogout(context);
      }
    });
    super.initState();

    currentIndex = widget.currentIndex;
    _hasBeenInitialized = List.generate(4, (_) => false);
    _hasBeenInitialized[widget.currentIndex] = true;
  }

  var currentIndex = 0;

  void handleLogout(context) async {
    var userId = SocketProvider.current_user_id;
    CustomSnackbar.show(context, title: '  Đang đăng xuất...', indicator: true);
    var uri = Uri.parse('$urlAuthLogout/$userId');
    Response res = await patch(uri);
    appSocket.close();
    await Hive.box<CountApp>('countBox').clear();
    await Hive.box<UserId>('userBox').clear();
    await Provider.of<MessagePageProvider>(context, listen: false).initialize();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove('userId');
    await prefs.remove('deviceId');
    await Provider.of<UserImageProvider>(context, listen: false)
        .getAllUserImage(userId);
    List<String> fcmTokens =
        Provider.of<UserImageProvider>(context, listen: false).fcmTokens;
    if (!Platform.isWindows && !Platform.isIOS) {
      await FirebaseFCM().removeToken(userId, fcmTokens);
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    navigatorKey.currentState?.pushNamed('/login');
  }

  void onTabTapped(int index) {
    setState(() {
      if (isLogin) {
        Provider.of<ChatRoomProvider>(context, listen: false).getChatRooms({});
        currentIndex = index;
      } else {
        showBottomSheetLogin(context, 2);
      }
    });
  }

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const FreePostAllPage();
      case 1:
        return isLogin ? const SuggestPage() : Container();
      case 2:
        return isLogin ? MessagePage() : Container();
      case 3:
        return isLogin ? const CreateFreePost() : Container();

      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    double displayWidth = min(MediaQuery.of(context).size.width, 400);
    final chatRoomProvider =
        Provider.of<ChatRoomProvider>(context, listen: true);

    return Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            _buildScreen(0),
            _buildScreen(1),
            _buildScreen(2),
            _buildScreen(3),
            // Add other screens if necessary
          ],
        ),
        extendBody: true,
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: onTabTapped,
          selectedIndex: currentIndex,
          destinations: <Widget>[
            NavigationDestination(
              icon: Image.asset(
                'assets/images/home.png',
                height: 25,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/images/star.png',
                height: 25,
              ),
              label: 'Gợi ý',
            ),
            NavigationDestination(
              icon: Badge(
                label: const Text('2'),
                child: Image.asset(
                  'assets/images/chat.png',
                  height: 25,
                ),
              ),
              label: 'Tin nhắn',
            ),
            NavigationDestination(
              icon: Image.asset(
                'assets/images/add.png',
                height: 25,
              ),
              label: 'Đăng',
            ),
          ],
          indicatorColor: AppColor.mainColor.withOpacity(0.5),
        ));
  }
}

// flutter: SocketProvider.current_user_id 658dc3552108076094ac6824
// flutter: userId 658dc3922108076094ac6864
// flutter:  CHAT_ROOM_TYPE.MATCHING matching