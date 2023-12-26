// import 'package:flutter/material.dart';
// import '../../models/post.dart';

// class PostDetail extends StatefulWidget {
//   final Post post;
//   const PostDetail({Key? key, required this.post}) : super(key: key);
//   @override
//   State<PostDetail> createState() => _PostDetailState();
// }

// class _PostDetailState extends State<PostDetail> {
//   @override
//   Widget build(BuildContext context) {
//     final currentWidth = MediaQuery.sizeOf(context).width;
//     final currentHeight = MediaQuery.sizeOf(context).height;
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     CircleAvatar(
//                       radius: 20,
//                       backgroundImage: NetworkImage(widget.post.avaURL),
//                     ),
//                     SizedBox(width: currentWidth * 0.03),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.post.name,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(
//                           height: currentHeight * 0.005,
//                         ),
//                         Text(widget.post.emotion),
//                       ],
//                     ),
//                     const Spacer(),
//                     InkWell(
//                       onTap: () {},
//                       child: const Icon(Icons.more_vert),
//                     )
//                   ],
//                 ),
//                 SizedBox(height: currentHeight * 0.01),
//                 Text(
//                   widget.post.content,
//                   style: TextStyle(height: currentHeight * 0.0022),
//                 ),
//                 SizedBox(
//                   height: currentHeight * 0.02,
//                 ),
//                 Image.asset('assets/images/other.png'),
//                 SizedBox(
//                   height: currentHeight * 0.03,
//                 ),
//                 Row(
//                   children: [
//                     SizedBox(
//                       width: currentWidth * 0.03,
//                     ),
//                     // InkWell(
//                     //   onTap: () {},
//                     //   child: const Iconify(
//                     //     Mdi.cards_heart_outline,
//                     //     color: Colors.grey,
//                     //   ),
//                     // ),
//                     SizedBox(
//                       width: currentWidth * 0.01,
//                     ),
//                     const Text(
//                       "110",
//                       style: TextStyle(color: Colors.grey),
//                     ),
//                     SizedBox(
//                       width: currentWidth * 0.1,
//                     ),
//                     // InkWell(
//                     //   onTap: () {},
//                     //   child: const Iconify(
//                     //     Mdi.comment_outline,
//                     //     color: Colors.grey,
//                     //   ),
//                     // ),
//                     SizedBox(
//                       width: currentWidth * 0.01,
//                     ),
//                     const Expanded(
//                       child: Text(
//                         "32",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     ),
//                     // InkWell(
//                     //   onTap: () {},
//                     //   child: const Iconify(
//                     //     Ic.baseline_bookmark_border,
//                     //     color: Colors.grey,
//                     //   ),
//                     // ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: currentHeight * 0.03,
//                 ),
//                 Container(
//                   width: currentWidth * 0.9,
//                   height: currentHeight * 0.08,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   padding: const EdgeInsets.all(10),
//                   child: Padding(
//                     padding: EdgeInsets.only(left: currentWidth * 0.06),
//                     child: const TextField(
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: 'Viết bình luận',
//                         hintStyle: TextStyle(
//                           color: Colors.grey,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
