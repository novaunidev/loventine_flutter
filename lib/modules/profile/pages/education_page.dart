// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_date_picker.dart';
import '../../../providers/page/message_page/message_page_provider.dart';
import 'package:provider/provider.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';
import 'package:loventine_flutter/config.dart';

import '../../../widgets/custom_snackbar.dart';

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _schoolNameController = TextEditingController();
  final TextEditingController _majorController = TextEditingController();

  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dio = Dio();
  late String current_user_id;
  String levelValue = "Không muốn trả lời";
  bool isLoading = false;

//Start
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //end load
  @override
  void initState() {
    super.initState();

    current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
  }

  Future<void> addEducation() async {
    try {
      var response = await dio
          .post("$baseUrl/education/createEducation/$current_user_id", data: {
        'level': levelValue,
        'schoolName': _schoolNameController.text,
        'majors': _majorController.text,
        'educationStartDate': _startTimeController.text,
        'educationEndDate': _endTimeController.text,
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
                    'Thêm trường học',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Loventine-Extrabold',
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'Cấp độ giáo dục',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Loventine-Bold',
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.only(left: 20),
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
                      setState(() {
                        levelValue = value!;
                        if (value == "Không muốn trả lời" ||
                            value == "Cấp 2" ||
                            value == "Cấp 3") {
                          _majorController.clear();
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
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
                  child: TextFormField(
                    controller: _schoolNameController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.only(top: 12, bottom: 12, left: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    style: const TextStyle(fontFamily: 'Loventine-Regular'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Điền tên trường";
                      } else {
                        if (checkText(value)) {
                          return "Văn bản chứa từ không phù hợp!";
                        } else {
                          return null;
                        }
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
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
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  height: levelValue == 'Đại Học' || levelValue == 'Cao Đẳng'
                      ? 75
                      : 0,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    controller: _majorController,
                    decoration: const InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.only(top: 12, bottom: 12, left: 15),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    style: const TextStyle(fontFamily: 'Loventine-Regular'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (checkText(value!)) {
                        return "Văn bản chứa từ không phù hợp!";
                      }
                    },
                  ),
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
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: TextFormField(
                              controller: _startTimeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      customDatePicker(
                                        context,
                                        _startTimeController,
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
                                  if (_startTimeController.text.isNotEmpty &&
                                      _endTimeController.text.isNotEmpty) {
                                    DateTime start = DateFormat('dd/MM/yyyy')
                                        .parse(_startTimeController.text);
                                    DateTime end = DateFormat('dd/MM/yyyy')
                                        .parse(_endTimeController.text);
                                    print(start);
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
                              controller: _endTimeController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.only(top: 12, bottom: 12),
                                border: const OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                prefixIcon: IconButton(
                                    onPressed: () {
                                      customDatePicker(
                                        context,
                                        _endTimeController,
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
                    style: const TextStyle(fontFamily: 'Loventine-Regular'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (checkText(value!)) {
                        return "Văn bản chứa từ không phù hợp!";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 30),
                //
                Center(
                  child: ActionButton(
                    text: 'Thêm trường học',
                    isChange: true,
                    isLoading: isLoading,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        addEducation();
                      }
                    },
                  ),
                ),

                const SizedBox(height: 30),

                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
