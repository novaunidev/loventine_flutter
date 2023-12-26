// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:loventine_flutter/pages/auth/login_page.dart';
// import 'dart:async';

// import '../../models/hives/count_app.dart';
// import '../../widgets/cupertino_bottom_sheet/src/material_with_modal_page_route.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Hive.box<CountApp>('countBox').clear();
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushReplacement(
//         context,
//         MaterialWithModalsPageRoute(builder: (context) => Login()),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size padding = MediaQuery.sizeOf(context);
//     return Scaffold(
//       body: Container(
//         color: Colors.white,
//         child: Column(
//           children: <Widget>[
//             Center(
//               child: Container(
//                   child: Column(
//                 children: <Widget>[
//                   Container(
//                     child: Stack(
//                       alignment: AlignmentDirectional.center,
//                       children: <Widget>[
//                         Padding(
//                           padding: EdgeInsets.only(top: padding.height * 0.3),
//                           child: Container(
//                             height: MediaQuery.sizeOf(context).height * 0.4,
//                             width: MediaQuery.sizeOf(context).width * 0.5,
//                             child: const Image(
//                               image: AssetImage('assets/images/loviser.png'),
//                             ),
//                           ),
//                         ),
//                         Container(
//                           height: MediaQuery.sizeOf(context).height * 0.25,
//                           width: MediaQuery.sizeOf(context).width * 0.5,
//                           child: const Image(
//                             image: AssetImage(
//                               'assets/images/love_animation.gif',
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: MediaQuery.sizeOf(context).height * 0.13,
//                   ),
//                   Container(
//                     height: MediaQuery.sizeOf(context).height * 0.03,
//                     width: MediaQuery.sizeOf(context).width * 0.5,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: const <Widget>[
//                         Text(
//                           'from',
//                           style: TextStyle(
//                               decoration: TextDecoration.none,
//                               color: Colors.black,
//                               fontFamily: 'Loventine-Semibold',
//                               fontSize: 16,
//                               fontWeight: FontWeight.normal),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(bottom: 20),
//                     // height: MediaQuery.sizeOf(context).height * 0.1,
//                     // width: MediaQuery.sizeOf(context).width * 0.5,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: const <Widget>[
//                           Image(
//                             image: AssetImage('assets/images/logo.png'),
//                           ),
//                           Text(
//                             'NOVA Universe',
//                             style: TextStyle(
//                                 decoration: TextDecoration.none,
//                                 color: Colors.black,
//                                 fontFamily: 'Montserrat-Bold',
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 20),
//                           )
//                         ]),
//                   ),
//                 ],
//               )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
