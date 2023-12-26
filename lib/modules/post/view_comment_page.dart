import 'package:flutter/material.dart';

class ViewCommentPage extends StatefulWidget {
  final List<Map<String, dynamic>> comments;
  const ViewCommentPage({super.key, required this.comments});

  @override
  State<ViewCommentPage> createState() => _ViewCommentPageState();
}

class _ViewCommentPageState extends State<ViewCommentPage> {
  final _commentController = TextEditingController();
  String repName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomSheet: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                height: repName == "" ? 0 : 40.0,
                duration: const Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Đang trả lời $repName',
                      //style: AppStyles.semibold.copyWith(fontSize: 16.0),
                    ),
                    (repName != "")
                        ? IconButton(
                            onPressed: () => setState(() {
                              repName = "";
                            }),
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                              size: 16.0,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                              'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Bình Luận ',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      " Đăng",
                      style: TextStyle(
                        fontFamily: "Loventine-Extrabold",
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 14,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Bình Luận',
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Loventine-Extrabold",
            fontSize: 18,
          ),
        ),
        elevation: 0.0,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          // for (var item in widget.comments)
          //   CommentItem(
          //     item: item,
          //     repComment: (value) {
          //       setState(() {
          //         repName = value;
          //       });
          //     },
          //   ),
          const SizedBox(height: 100.0),
        ],
      ),
    );
  }
}
