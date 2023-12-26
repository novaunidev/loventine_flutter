import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:loventine_flutter/constant.dart';
import '../../config.dart';
import 'package:rive/rive.dart';

import '../../widgets/animated_btn_rating.dart';

class RatingPage extends StatefulWidget {
  final String? consultingJob;
  final String nameConsultant;
  final String avatarConsultant;
  final String nameUser;
  final String avatarUser;
  const RatingPage(
      {Key? key,
      this.consultingJob,
      required this.nameUser,
      required this.avatarUser,
      required this.nameConsultant,
      required this.avatarConsultant})
      : super(key: key);

  @override
  State<RatingPage> createState() => _RatingPageState();
}

class CustomPositioned extends StatelessWidget {
  const CustomPositioned({super.key, this.scale = 1, required this.child});

  final double scale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 100,
            width: 100,
            child: Transform.scale(
              scale: scale,
              child: child,
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _RatingPageState extends State<RatingPage> {
  final TextEditingController _contentController = TextEditingController();
  StateMachineController? controller;
  SMIInput<double>? inputValue;
  late RiveAnimationController _btnAnimationController;

  final dio = Dio();
  bool isShowLoading = false;
  bool isShowConfetti = false;
  late SMITrigger error;
  late SMITrigger success;
  late SMITrigger reset;
  late String? consultingJobId = widget.consultingJob as String;

  late SMITrigger confetti;

  void _onCheckRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, 'State Machine 1');

    artboard.addController(controller!);
    error = controller.findInput<bool>('Error') as SMITrigger;
    success = controller.findInput<bool>('Check') as SMITrigger;
    reset = controller.findInput<bool>('Reset') as SMITrigger;
  }

  void _onConfettiRiveInit(Artboard artboard) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, "State Machine 1");
    artboard.addController(controller!);

    confetti = controller.findInput<bool>("Trigger explosion") as SMITrigger;
  }

  void rating(BuildContext context) {
    // confetti.fire();
    setState(() {
      isShowConfetti = true;
      isShowLoading = true;
    });
    int? id = inputValue?.id;
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        print(consultingJobId);
        Response response = await dio
            .post("$baseUrl/review/createReview/$consultingJobId", data: {
          "star": controller?.getInputValue(id!),
          "title": "Title làm sau!!!",
          "time": DateTime.now().toIso8601String(),
          "content": (_contentController.text == '')
              ? DEFAULT.EMPTY_STRING
              : _contentController.text,
          "nameUser": widget.nameUser,
          "avatarUser": widget.avatarUser,
        });
        if (response.statusCode == 200) {
          success.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              confetti.fire();
              // Navigate & hide confetti
              Future.delayed(const Duration(seconds: 1), () {
                // Navigator.pop(context);
              });
            },
          );
        } else {
          error.fire();
          Future.delayed(
            const Duration(seconds: 2),
            () {
              setState(() {
                isShowLoading = false;
              });
              reset.fire();
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Stack(
        children: [
          Container(
            height: height * 0.7,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xfffafafa),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(0, 30),
                  blurRadius: 60,
                ),
                const BoxShadow(
                  color: Colors.black45,
                  offset: Offset(0, 30),
                  blurRadius: 60,
                ),
              ],
            ),
            child: Scaffold(
              body: SingleChildScrollView(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/rating_page.gif"),
                  Text(
                    "Đánh giá và phản hồi",
                    style:
                        TextStyle(fontFamily: "Loventine-Bold", fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 20),
                    child: Column(
                      children: [
                        Text(
                          "Đánh giá mức độ hoàn thành của ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Loventine-Regular",
                              fontSize: 15,
                              color: Color(0xff5B555C)),
                        ),
                        Container(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(100, 100, 111, 0.3),
                                offset: Offset(0, 5),
                                blurRadius: 29,
                              ),
                            ],
                          ),
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.avatarConsultant),
                              backgroundColor: Colors.grey[300],
                            ),
                          ),
                        ),
                        Text(
                          widget.nameConsultant,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: "Loventine-Bold",
                              fontSize: 15,
                              color: Color(0xff5B555C)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.7,
                    height: height * 0.1,
                    child: RiveAnimation.asset(
                      'assets/rives/rating.riv',
                      onInit: (art) {
                        controller = StateMachineController.fromArtboard(
                          art,
                          "State Machine 1",
                        );

                        if (controller != null) {
                          art.addController(controller!);
                          inputValue = controller?.findInput("Rating");
                          inputValue?.change(1);
                        }
                      },
                    ),
                  ),
                  TextField(
                    controller: _contentController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 30.0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF2F2F3)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffF2F2F3)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Hãy ghi nhận xét của bạn về Trọng Nhân",
                      hintStyle: TextStyle(
                          color: Color(0xff616161),
                          fontFamily: "Loventine-Regular"),
                      filled: true,
                      fillColor: Color(0xffF2F2F3),
                    ),
                    style: TextStyle(fontFamily: "Loventine-Regular"),
                    maxLines: 200,
                    minLines: 1,
                  ),
                  const SizedBox(height: 10),
                  AnimatedBtn(
                    btnAnimationController: _btnAnimationController,
                    press: () {
                      _btnAnimationController.isActive = true;

                      Future.delayed(
                        const Duration(milliseconds: 800),
                        () {
                          setState(() {});
                          rating(context);
                          // int? id = inputValue?.id;
                          // print(controller?.getInputValue(id!));
                        },
                      );
                    },
                  ),
                ],
              )),
            ),
          ),
          isShowLoading
              ? CustomPositioned(
                  child: RiveAnimation.asset(
                    'assets/rives/check.riv',
                    fit: BoxFit.cover,
                    onInit: _onCheckRiveInit,
                  ),
                )
              : const SizedBox(),
          isShowConfetti
              ? CustomPositioned(
                  scale: 6,
                  child: RiveAnimation.asset(
                    "assets/rives/confetti.riv",
                    onInit: _onConfettiRiveInit,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
