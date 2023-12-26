// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/modules/profile/widgets/info_profile.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/back_icon.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_date_picker.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import '../../../models/profile/user_education.dart';
import 'package:dio/dio.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import '../../../providers/page/message_page/message_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:loventine_flutter/config.dart';

class EducationEditWidget extends StatefulWidget {
  const EducationEditWidget(
      {super.key,
      required this.eduIndex,
      required this.educations,
      required this.isMe});
  final int eduIndex;
  final List<UserEducation> educations;
  final bool isMe;

  @override
  State<EducationEditWidget> createState() => _EducationEditWidgetState();
}

class _EducationEditWidgetState extends State<EducationEditWidget> {
  final TextEditingController _descriptionController = TextEditingController();

  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String current_user_id;
  late bool _isLoading = false;
  bool isLoading = false;
  late String educationId = widget.educations[widget.eduIndex].id;
  late String levelShow = widget.educations[widget.eduIndex].level;
  late String schoolNameShow = widget.educations[widget.eduIndex].schoolName;
  final dio = Dio();
  String levelValue = "Không muốn trả lời";
  bool isChange = false;
  DateTime initStartDate = DateTime.now();
  DateTime initEndDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _schoolNameController.text = widget.educations[widget.eduIndex].schoolName;
    _majorController.text = widget.educations[widget.eduIndex].majors;
    _startTimeController.text =
        widget.educations[widget.eduIndex].educationStartDate;
    _endTimeController.text =
        widget.educations[widget.eduIndex].educationEndDate;
    _descriptionController.text =
        widget.educations[widget.eduIndex].educationDescribe;
    levelValue = widget.educations[widget.eduIndex].level;
    if (widget.educations[widget.eduIndex].educationStartDate != "") {
      initStartDate = DateFormat('dd/MM/yyyy')
          .parse(widget.educations[widget.eduIndex].educationStartDate);
    }
    if (widget.educations[widget.eduIndex].educationEndDate != "") {
      initEndDate = DateFormat('dd/MM/yyyy')
          .parse(widget.educations[widget.eduIndex].educationEndDate);
    }
    current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
  }

//Start
//
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

//Delete
  Future<void> deleteEducation() async {
    try {
      Response response =
          await dio.delete("$baseUrl/education/deleteEducation/$educationId");
      if (response.statusCode == 200) {
        CustomSnackbar.show(
          context,
          title: 'Xóa thành công',
          message: 'Bạn xóa cấp độ $levelShow tại trường $schoolNameShow',
          type: SnackbarType.success,
        );

        Provider.of<CardProfileProvider>(context, listen: false)
            .fetchCurrentUser(current_user_id);

        Navigator.pop(context);
      }
    } catch (e) {
      print(e);
    }
  }

//Update
  Future<void> updateEducation() async {
    try {
      var response = await dio
          .put("$baseUrl/education/updateEducation/$educationId", data: {
        'level': levelValue,
        'schoolName': _schoolNameController.text,
        'majors': _majorController.text,
        'educationStartDate': _startTimeController.text,
        'educationEndDate': _endTimeController.text,
        'educationDescribe': _descriptionController.text
      });

      if (response.statusCode == 200) {
        //Start SnackBar
        CustomSnackbar.show(
          context,
          title: 'Cập nhật thành công!',
          message:
              'Bạn đã cập nhật thành công cho cấp độ $levelShow tại trường $schoolNameShow',
          type: SnackbarType.success,
        );
        Provider.of<CardProfileProvider>(context, listen: false)
            .fetchCurrentUser(current_user_id);

        Navigator.pop(context);
      }
    } catch (e) {
      CustomSnackbar.show(
        context,
        title: 'Cập nhật thất bại',
        message: 'Vui lòng thử lại',
        type: SnackbarType.failure,
      );
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _startTimeController.dispose();
    _majorController.dispose();
    _endTimeController.dispose();
    _schoolNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffafafd),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackIcon(),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Text(
                    'Trường học',
                    style: AppText.titleHeader(fontSize: 20),
                  ),
                ),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Cấp độ giáo dục',
                    style: TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                widget.isMe
                    ? Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(left: 15, right: 10),
                        child: DropdownButton<String>(
                          value: levelValue,
                          borderRadius: BorderRadius.circular(12),
                          underline: const SizedBox(),
                          items: const [
                            DropdownMenuItem<String>(
                                value: "Không muốn trả lời",
                                child: Text("Không muốn trả lời")),
                            DropdownMenuItem<String>(
                                value: "Cấp 2", child: Text("Cấp 2")),
                            DropdownMenuItem<String>(
                                value: "Cấp 3", child: Text("Cấp 3")),
                            DropdownMenuItem<String>(
                                value: "Đại Học", child: Text("Đại Học")),
                            DropdownMenuItem<String>(
                                value: "Cao Đẳng", child: Text("Cao Đẳng")),
                          ],
                          onChanged: (value) {
                            if (value == "Không muốn trả lời" ||
                                value == "Cấp 2" ||
                                value == "Cấp 3") {
                              _majorController.clear();
                            }
                            setState(() {
                              if (value !=
                                  widget.educations[widget.eduIndex].level) {
                                levelValue = value!;
                                isChange = true;
                              } else {
                                levelValue = value!;
                                if (_majorController.text ==
                                    widget.educations[widget.eduIndex].majors) {
                                  isChange = false;
                                }
                              }
                            });
                          },
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: InfoProfile(
                            text: levelValue,
                            svgPath: 'assets/svgs/level_edu_b.svg')),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Tên trường',
                    style: TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: widget.isMe
                      ? TextFormField(
                          controller: _schoolNameController,
                          maxLength: 90,
                          maxLines: null,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                EdgeInsets.only(top: 12, bottom: 12, left: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          style:
                              const TextStyle(fontFamily: 'Loventine-Regular'),
                          onChanged: (value) {
                            if (value !=
                                widget.educations[widget.eduIndex].schoolName) {
                              setState(() {
                                isChange = true;
                              });
                            } else {
                              setState(() {
                                isChange = false;
                              });
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (checkText(value!)) {
                              return "Văn bản chứa từ không phù hợp!";
                            } else {
                              return null;
                            }
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: InfoProfile(
                              text: _schoolNameController.text,
                              svgPath: 'assets/svgs/school_b.svg')),
                ),
                const Divider(
                  color: AppColor.borderButton,
                ),
                levelValue == 'Đại Học' || levelValue == 'Cao Đẳng'
                    ? Container(
                        margin: const EdgeInsets.only(left: 20, bottom: 10),
                        child: const Text(
                          'Chuyên ngành',
                          style: TextStyle(
                            fontFamily: 'Loventine-Bold',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : const SizedBox(),
                widget.isMe
                    ? AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        height:
                            levelValue == 'Đại Học' || levelValue == 'Cao Đẳng'
                                ? 75
                                : 0,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextFormField(
                          controller: _majorController,
                          maxLength: 90,
                          maxLines: null,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding:
                                EdgeInsets.only(top: 12, bottom: 12, left: 15),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                          ),
                          style:
                              const TextStyle(fontFamily: 'Loventine-Regular'),
                          onChanged: (value) {
                            if (value !=
                                widget.educations[widget.eduIndex].majors) {
                              setState(() {
                                isChange = true;
                              });
                            } else {
                              setState(() {
                                isChange = false;
                              });
                            }
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (checkText(value!)) {
                              return "Văn bản chứa từ không phù hợp!";
                            }
                          },
                        ))
                    : levelValue == 'Đại Học' || levelValue == 'Cao Đẳng'
                        ? Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                              bottom: 20,
                            ),
                            child: InfoProfile(
                                text: _majorController.text,
                                svgPath: 'assets/svgs/book-1_b.svg'))
                        : const SizedBox(),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              'Ngày bắt đầu',
                              style: TextStyle(
                                fontFamily: 'Loventine-Bold',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: widget.isMe
                                  ? TextFormField(
                                      controller: _startTimeController,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        prefixIcon: IconButton(
                                            onPressed: () {
                                              customDatePicker(
                                                context,
                                                _startTimeController,
                                                initialDate: initStartDate,
                                                onDateSelected: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      if (DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(value) !=
                                                          widget
                                                              .educations[widget
                                                                  .eduIndex]
                                                              .educationStartDate) {
                                                        isChange = true;
                                                      } else {
                                                        isChange = false;
                                                      }
                                                    });
                                                  }
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.calendar_month_rounded)),
                                      ),
                                      style: const TextStyle(
                                          fontFamily: 'Loventine-Regular'),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        RegExp regex =
                                            RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
                                        if (regex.hasMatch(value!) == false &&
                                            value.isNotEmpty) {
                                          return "Nhập định dạng dd/MM/yyyy";
                                        } else {
                                          if (_startTimeController
                                                  .text.isNotEmpty &&
                                              _endTimeController
                                                  .text.isNotEmpty) {
                                            DateTime start =
                                                DateFormat('dd/MM/yyyy').parse(
                                                    _startTimeController.text);
                                            DateTime end =
                                                DateFormat('dd/MM/yyyy').parse(
                                                    _endTimeController.text);
                                            if (end.isAfter(start)) {
                                              return null;
                                            } else {
                                              return "Ngày bắt đầu bé hơn \nngày kết thúc";
                                            }
                                          }
                                        }
                                      },
                                      onChanged: (value) {
                                        RegExp regex =
                                            RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
                                        if (regex.hasMatch(value) == true &&
                                            value.isNotEmpty) {
                                          DateTime change =
                                              DateFormat('dd/MM/yyyy')
                                                  .parse(value);
                                          DateTime init = DateFormat(
                                                  'dd/MM/yyyy')
                                              .parse(widget
                                                  .educations[widget.eduIndex]
                                                  .educationStartDate);
                                          if (change == init) {
                                            setState(() {
                                              isChange = false;
                                            });
                                          } else {
                                            setState(() {
                                              isChange = true;
                                            });
                                          }
                                        }
                                      },
                                    )
                                  : (_startTimeController.text == '')
                                      ? Text(
                                          "Không có thông tin",
                                          style: AppText.describeText(),
                                        )
                                      : Text(
                                          _startTimeController.text,
                                          style: AppText.contentRegular(),
                                        )),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 20),
                            child: const Text(
                              'Ngày kết thúc',
                              style: TextStyle(
                                fontFamily: 'Loventine-Bold',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: widget.isMe
                                  ? TextFormField(
                                      controller: _endTimeController,
                                      decoration: InputDecoration(
                                        fillColor: Colors.white,
                                        filled: true,
                                        contentPadding: const EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        prefixIcon: IconButton(
                                            onPressed: () {
                                              customDatePicker(
                                                context,
                                                _endTimeController,
                                                initialDate: initEndDate,
                                                onDateSelected: (value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      if (DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(value) !=
                                                          widget
                                                              .educations[widget
                                                                  .eduIndex]
                                                              .educationEndDate) {
                                                        isChange = true;
                                                      } else {
                                                        isChange = false;
                                                      }
                                                    });
                                                  }
                                                },
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.calendar_month_rounded)),
                                      ),
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      validator: (value) {
                                        RegExp regex =
                                            RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
                                        if (regex.hasMatch(value!) == false &&
                                            value.isNotEmpty) {
                                          return "Nhập định dạng dd/MM/yyyy";
                                        } else {
                                          if (_startTimeController
                                                  .text.isNotEmpty &&
                                              _endTimeController
                                                  .text.isNotEmpty) {
                                            DateTime start =
                                                DateFormat('dd/MM/yyyy').parse(
                                                    _startTimeController.text);
                                            DateTime end =
                                                DateFormat('dd/MM/yyyy').parse(
                                                    _endTimeController.text);
                                            if (end.isAfter(start)) {
                                              return null;
                                            } else {
                                              return "Ngày kết thúc lớn hơn \nngày bắt đầu";
                                            }
                                          }
                                        }
                                      },
                                      onChanged: (value) {
                                        RegExp regex =
                                            RegExp(r'^\d{1,2}/\d{1,2}/\d{4}$');
                                        if (regex.hasMatch(value) == true &&
                                            value.isNotEmpty) {
                                          DateTime change =
                                              DateFormat('dd/MM/yyyy')
                                                  .parse(value);
                                          DateTime init = DateFormat(
                                                  'dd/MM/yyyy')
                                              .parse(widget
                                                  .educations[widget.eduIndex]
                                                  .educationEndDate);
                                          if (change == init) {
                                            setState(() {
                                              isChange = false;
                                            });
                                          } else {
                                            setState(() {
                                              isChange = true;
                                            });
                                          }
                                        }
                                      },
                                    )
                                  : (_endTimeController.text == '')
                                      ? Text(
                                          "Không có thông tin",
                                          style: AppText.describeText(),
                                        )
                                      : Text(
                                          _endTimeController.text,
                                          style: AppText.contentRegular(),
                                        )),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Mô tả',
                    style: TextStyle(
                      fontFamily: 'Loventine-Bold',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: widget.isMe
                        ? TextFormField(
                            controller: _descriptionController,
                            maxLines: 5,
                            decoration: const InputDecoration(
                              hintText: 'Viết thông tin bổ sung tại đây',
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 15),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            style: const TextStyle(
                                fontFamily: 'Loventine-Regular'),
                            onChanged: (value) {
                              if (value !=
                                  widget.educations[widget.eduIndex]
                                      .educationDescribe) {
                                setState(() {
                                  isChange = true;
                                });
                              } else {
                                setState(() {
                                  isChange = false;
                                });
                              }
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (checkText(value!)) {
                                return "Văn bản chứa từ không phù hợp!";
                              }
                            },
                          )
                        : (_descriptionController.text == '')
                            ? Text(
                                "Không có mô tả",
                                style: AppText.describeText(),
                              )
                            : InfoProfile(
                                text: _descriptionController.text,
                                svgPath: 'assets/svgs/edit-2.svg')),
                const SizedBox(height: 30),
                widget.isMe
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: ActionButton(
                              text: 'Cập nhật trường học',
                              isChange: isChange,
                              isLoading: isLoading,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  updateEducation();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          const SizedBox(width: 30, height: 30),
                          GestureDetector(
                            onTap: (() async {
                              setState(() {
                                _isLoading = true;
                              });
                              deleteEducation();
                            }),
                            child: _isLoading
                                ? Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.grey,
                                    ),
                                    child: Lottie.asset(
                                      'assets/lotties/load_button.json',
                                      width: 100,
                                    ),
                                  )
                                : Container(
                                    width: 70,
                                    height: 50,
                                    child:
                                        Image.asset("assets/images/delete.png"),
                                  ),
                          )
                        ],
                      )
                    : const SizedBox(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
