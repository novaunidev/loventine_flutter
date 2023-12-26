// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/modules/profile/widgets/info_profile.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/app_text.dart';
import 'package:loventine_flutter/widgets/back_icon.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_date_picker.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import '../../../providers/page/message_page/message_page_provider.dart';
import 'package:provider/provider.dart';
import 'package:loventine_flutter/models/profile/user_work.dart';
import 'package:loventine_flutter/config.dart';

class WorkEditWidget extends StatefulWidget {
  final bool isMe;
  const WorkEditWidget(
      {super.key,
      required this.workIndex,
      required this.works,
      required this.isMe});
  final int workIndex;
  final List<UserWork> works;

  @override
  State<WorkEditWidget> createState() => _WorkEditWidgetState();
}

class _WorkEditWidgetState extends State<WorkEditWidget> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  late String current_user_id;
  late bool _isLoading = false;
  late String workId = widget.works[widget.workIndex].id;
  late String companyShow = widget.works[widget.workIndex].company;
  late String positionShow = widget.works[widget.workIndex].position;
  final dio = Dio();
  bool isChange = false;
  DateTime initStartDate = DateTime.now();
  DateTime initEndDate = DateTime.now();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    print("❗Đang lấy data ở Work_Edit");
    _companyController.text = widget.works[widget.workIndex].company;
    _roleController.text = widget.works[widget.workIndex].position;
    _endTimeController.text = widget.works[widget.workIndex].workEndDate;
    _startTimeController.text = widget.works[widget.workIndex].workStartDate;
    _descriptionController.text = widget.works[widget.workIndex].workDescribe;
    if (widget.works[widget.workIndex].workStartDate != "") {
      initStartDate = DateFormat('dd/MM/yyyy')
          .parse(widget.works[widget.workIndex].workStartDate);
    }
    if (widget.works[widget.workIndex].workEndDate != "") {
      initEndDate = DateFormat('dd/MM/yyyy')
          .parse(widget.works[widget.workIndex].workEndDate);
    }
    current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

//Delete
  Future<void> deleteWorkExperience() async {
    try {
      Response response = await dio.delete("$baseUrl/work/deleteWork/$workId");
      print(response.data);
      if (response.statusCode == 200) {
        CustomSnackbar.show(
          context,
          title: 'Xóa thành công',
          message: 'Bạn xóa chức vụ $positionShow tại công ty $companyShow',
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
  Future<void> updateWorkExperience() async {
    try {
      var response = await dio.put("$baseUrl/work/updateWork/$workId", data: {
        'company': _companyController.text,
        'position': _roleController.text,
        'workEndDate': _endTimeController.text,
        'workStartDate': _startTimeController.text,
        'workDescribe': _descriptionController.text
      });

      if (response.statusCode == 200) {
        CustomSnackbar.show(
          context,
          title: 'Cập nhật thành công!',
          message:
              'Bạn đã cập nhật thành công cho chức vụ $positionShow tại công ty $companyShow',
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

      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _roleController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _companyController.dispose();
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
                  child: Text('Kinh nghiệm làm việc',
                      style: AppText.titleHeader()),
                ),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Chức vụ',
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
                            controller: _roleController,
                            maxLength: 30,
                            decoration: const InputDecoration(
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
                              fontFamily: 'Loventine-Regular',
                            ),
                            onChanged: (value) {
                              if (value !=
                                  widget.works[widget.workIndex].position) {
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
                        : InfoProfile(
                            text: _roleController.text,
                            svgPath: 'assets/svgs/bag-2.svg')),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Công ty',
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
                            controller: _companyController,
                            maxLines: null,
                            maxLength: 90,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Điền tên công ty";
                              } else {
                                if (checkText(value)) {
                                  return "Văn bản chứa từ không phù hợp!";
                                } else {
                                  return null;
                                }
                              }
                            },
                            decoration: const InputDecoration(
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
                              fontFamily: 'Loventine-Regular',
                            ),
                            onChanged: (value) {
                              if (value !=
                                  widget.works[widget.workIndex].company) {
                                setState(() {
                                  isChange = true;
                                });
                              } else {
                                setState(() {
                                  isChange = false;
                                });
                              }
                            },
                          )
                        : InfoProfile(
                            text: _companyController.text,
                            svgPath: 'assets/svgs/building-3.svg')),
                const Divider(
                  color: AppColor.borderButton,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                                              .works[widget
                                                                  .workIndex]
                                                              .workStartDate) {
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
                                      style: TextStyle(
                                        fontFamily: 'Loventine-Regular',
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
                                              return "Ngày bắt đầu bé hơn \nngày kết thúc";
                                            }
                                          }
                                        }
                                      },
                                      onChanged: (value) {
                                        DateTime change =
                                            DateFormat('dd/MM/yyyy')
                                                .parse(value);
                                        DateTime init = DateFormat('dd/MM/yyyy')
                                            .parse(widget
                                                .works[widget.workIndex]
                                                .workStartDate);
                                        if (change == init) {
                                          setState(() {
                                            isChange = false;
                                          });
                                        } else {
                                          setState(() {
                                            isChange = true;
                                          });
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
                                        contentPadding: const EdgeInsets.only(
                                            top: 12, bottom: 12),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        fillColor: Colors.white,
                                        filled: true,
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
                                                              .works[widget
                                                                  .workIndex]
                                                              .workEndDate) {
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
                                        fontFamily: 'Loventine-Regular',
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
                                        DateTime change =
                                            DateFormat('dd/MM/yyyy')
                                                .parse(value);
                                        DateTime init = DateFormat('dd/MM/yyyy')
                                            .parse(widget
                                                .works[widget.workIndex]
                                                .workEndDate);
                                        if (change == init) {
                                          setState(() {
                                            isChange = false;
                                          });
                                        } else {
                                          setState(() {
                                            isChange = true;
                                          });
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
                              fontFamily: 'Loventine-Regular',
                            ),
                            onChanged: (value) {
                              if (value !=
                                  widget.works[widget.workIndex].workDescribe) {
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
                              } else {
                                return null;
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
                              text: 'Cập nhật công việc',
                              isChange: isChange,
                              isLoading: _isLoading,
                              onTap: () async {
                                if (_formKey.currentState!.validate()) {
                                  updateWorkExperience();
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 30),
                          const SizedBox(width: 30, height: 30),
                          GestureDetector(
                            onTap: (() async {
                              setState(() {
                                deleteWorkExperience();
                                _isLoading = true;
                              });
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
                          ),
                        ],
                      )
                    : SizedBox(),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
