import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/config.dart';

class RowContent {
  bool isSelected = false;
  String content;
  Function itemFunction;
  RowContent(
      {required this.isSelected,
      required this.content,
      required this.itemFunction});
}

int count1 = 0;
int count0 = 0;
bool isFreePost = true;
final allRowContent = [
  RowContent(
      isSelected: false,
      content: 'Không đồng ý thanh toán',
      itemFunction: (ctxRoot) {
        //
      }),
  RowContent(
      isSelected: false,
      content: 'Không đồng ý hủy công việc',
      itemFunction: (ctxRoot) {
        //
      }),
  RowContent(
      isSelected: false,
      content: 'Khác',
      itemFunction: (ctxRoot) {
        //
      }),
];

List<RowContent> selectedContent = [];

enum Option { payment, cancel, other }

class ReportUserDialog extends StatefulWidget {
  final String nameMe;
  final String adviceReportId;
  final String userId;
  ReportUserDialog(
      {Key? key,
      required this.adviceReportId,
      required this.nameMe,
      required this.userId})
      : super(key: key);

  @override
  State<ReportUserDialog> createState() => _ReportUserDialogState();
}

class _ReportUserDialogState extends State<ReportUserDialog> {
  Option? _site = Option.values[0];
  Widget itemSwitch(RowContent item, Widget flutterSwitch) {
    return ListTile(
      tileColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        item.content,
        style: const TextStyle(
            fontFamily: 'Loventine-Semibold',
            fontSize: 12,
            fontWeight: FontWeight.w400),
      ),
      trailing: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          height: 30,
          width: 30,
          child: FittedBox(child: flutterSwitch)),
    );
  }

  late String userId;

  final TextEditingController _contentController = TextEditingController();

  final dio = Dio();
  Future<void> createReport(String content) async {
    try {
      var response = await dio.post("$baseUrl/report/createReport", data: {
        'type': 'advice',
        'userThatReported': widget.userId,
        'adviceBeingReported': widget.adviceReportId,
        'content': content,
        'time': DateTime.now().toIso8601String(),
      });
      if (response.statusCode == 200) {
        setState(() {
          isReport = true; //có setState mới load lại Build
        });
      }
    } catch (e) {
      print(e);
    }
  }

  bool isReport = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: height * 0.8,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        // margin: const EdgeInsets.symmetric(horizontal: 16,),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Color(0xFFFFAFAFD),
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
          backgroundColor: const Color(0xFFFFAFAFD),
          body: isReport
              ? Stack(
                  children: [
                    Center(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              "assets/lotties/protection-shield.json",
                              height: 70,
                              onLoaded: (composition) async {
                                await Future.delayed(composition.duration);
                                Navigator.pop(context);
                              },
                              repeat: false,
                            ),
                            Text(
                              'Cảm ơn ${widget.nameMe} đã gửi báo cáo',
                              style: const TextStyle(
                                color: Color(0xff0D0D26),
                                fontFamily: 'Loventine-Black',
                                fontSize: 25,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Text(
                              'Đội ngũ LOVISER sẽ tiến hành đánh giá cẩn thận báo cáo của bạn và cam kết tận tâm bảo vệ và cải thiện trải nghiệm tuyệt vời cho người dùng.',
                              style: TextStyle(
                                color: Color(0xff0D0D26),
                                fontFamily: 'Loventine-Regular',
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Lottie.asset(
                              "assets/lotties/customer-care.json",
                              height: 240,
                              repeat: true,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Lottie.asset(
                      "assets/lotties/success.json",
                      repeat: false,
                    ),
                  ],
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Container(
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/warning_ic.png",
                                height: 60,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  '${widget.nameMe} ơi! Hãy cho LOVISER biết bài viết này đang gặp vấn đề gì vậy?',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontFamily: 'Loventine-Semibold'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Divider(),
                              const SizedBox(height: 7),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Hãy chọn vấn đề',
                                  style: TextStyle(
                                      color: Color(0xFF0D0D26),
                                      fontSize: 20,
                                      fontFamily: 'Loventine-Bold'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const SizedBox(height: 7),
                      for (int i = 0; i < allRowContent.length; i++) ...[
                        Column(
                          children: [
                            ListTile(
                              tileColor: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              title: Text(
                                allRowContent[i].content,
                                style: const TextStyle(
                                    color: Color(0xff0D0D26),
                                    fontFamily: 'Loventine-Semibold',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w100),
                              ),
                              trailing: Checkbox(
                                value: _site == Option.values[i],
                                onChanged: (bool? value) {
                                  setState(() {
                                    _site = value != null && value == true
                                        ? Option.values[i]
                                        : null;
                                  });
                                },
                                shape: const CircleBorder(),
                                activeColor: Colors.red,
                              ),
                              onTap: () {
                                setState(() {
                                  _site = Option.values[i];
                                });
                              },
                            ),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ],
                      if (_site == Option.values[2])
                        TextFormField(
                          controller: _contentController,
                          decoration: InputDecoration(
                            labelText: 'Nhập lí do báo cáo',
                          ),
                        ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffEC1C24),
                              minimumSize: const Size(327, 56),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            onPressed: () => {
                              //thanksForReport(context),
                              // createReport(),
                              if (_site == Option.payment)
                                createReport(allRowContent[0].content),
                              if (_site == Option.cancel)
                                createReport(allRowContent[1].content),
                              if (_site == Option.other)
                                {
                                  createReport(_contentController.text),
                                }
                            },
                            child: const Text(
                              'Báo cáo',
                              style: TextStyle(
                                fontFamily: 'Poppins-Regular',
                                fontSize: 16,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
