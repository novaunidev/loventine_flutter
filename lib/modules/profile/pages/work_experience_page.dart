// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_date_picker.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import 'package:intl/intl.dart';
import 'package:loventine_flutter/config.dart';
import '../../../providers/page/message_page/message_page_provider.dart';
import 'package:provider/provider.dart';

class WorkExperiencePage extends StatefulWidget {
  const WorkExperiencePage({super.key});

  @override
  State<WorkExperiencePage> createState() => _WorkExperiencePageState();
}

class _WorkExperiencePageState extends State<WorkExperiencePage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final dio = Dio();
  late String current_user_id;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
  }

  //Khi gọi tới hàm này nó sẽ tự động load lại dữ liệu

  //end load

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> addWorkExperience() async {
    try {
      var response =
          await dio.post("$baseUrl/work/createWork/$current_user_id", data: {
        'company': _companyController.text,
        'position': _roleController.text,
        'workEndDate': _endTimeController.text,
        'workStartDate': _startTimeController.text,
        'workDescribe': _descriptionController.text
      });

      if (response.statusCode == 200) {
        CustomSnackbar.show(
          context,
          title: 'Thêm thành công',
          type: SnackbarType.success,
        );

        Provider.of<CardProfileProvider>(context, listen: false)
            .fetchCurrentUser(current_user_id);

        Navigator.pop(context);
      }
    } catch (e) {
      CustomSnackbar.show(
        context,
        title: 'Thêm thất bại',
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
    _roleController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    _companyController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Kinh nghiệm làm việc',
                    style: TextStyle(
                      fontFamily: 'Loventine-Black',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
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
                  child: TextFormField(
                    controller: _roleController,
                    maxLength: 30,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.only(top: 12, bottom: 12, left: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    style: const TextStyle(
                      fontFamily: 'Loventine-Regular',
                    ),
                    validator: (value) {
                      if (checkText(value!)) {
                        return "Văn bản chứa từ không phù hợp!";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Công ty',
                    style: TextStyle(
                      fontFamily: 'Loventine-Regular',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _companyController,
                    maxLength: 90,
                    maxLines: null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
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
                      contentPadding:
                          EdgeInsets.only(top: 12, bottom: 12, left: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Loventine-Regular',
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
                                fontFamily: 'Loventine-Regular',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _startTimeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      customDatePicker(
                                          context, _startTimeController);
                                    },
                                    icon: const Icon(
                                        Icons.calendar_month_rounded)),
                                contentPadding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                  if (_startTimeController.text.isNotEmpty &&
                                      _endTimeController.text.isNotEmpty) {
                                    DateTime start = DateFormat('dd/MM/yyyy')
                                        .parse(_startTimeController.text);
                                    DateTime end = DateFormat('dd/MM/yyyy')
                                        .parse(_endTimeController.text);
                                    if (end.isAfter(start)) {
                                      return null;
                                    } else {
                                      return "Ngày bắt đầu bé hơn \nngày kết thúc";
                                    }
                                  }
                                }
                              },
                            ),
                          ),
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
                                fontFamily: 'Loventine-Regular',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _endTimeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      customDatePicker(
                                          context, _endTimeController);
                                    },
                                    icon: const Icon(
                                        Icons.calendar_month_rounded)),
                                contentPadding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
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
                                  if (_startTimeController.text.isNotEmpty &&
                                      _endTimeController.text.isNotEmpty) {
                                    DateTime start = DateFormat('dd/MM/yyyy')
                                        .parse(_startTimeController.text);
                                    DateTime end = DateFormat('dd/MM/yyyy')
                                        .parse(_endTimeController.text);
                                    if (end.isAfter(start)) {
                                      return null;
                                    } else {
                                      return "Ngày kết thúc lớn hơn \nngày bắt đầu";
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Mô tả',
                    style: TextStyle(
                      fontFamily: 'Loventine-Regular',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _descriptionController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      hintText: 'Viết thông tin bổ sung tại đây',
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.only(top: 12, bottom: 12, left: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    style: const TextStyle(
                      fontFamily: 'Loventine-Regular',
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (checkText(value!)) {
                        return "Văn bản chứa từ không phù hợp!";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                //
                Center(
                  child: ActionButton(
                    text: 'Thêm công việc',
                    isChange: true,
                    isLoading: isLoading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });

                        addWorkExperience();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
