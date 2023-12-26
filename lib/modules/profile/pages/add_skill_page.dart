import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';

import 'package:loventine_flutter/models/profile/user_skill.dart';
import 'package:loventine_flutter/modules/profile/widgets/check_text.dart';

import 'package:loventine_flutter/values/app_color.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:provider/provider.dart';

import '/../models/work.dart';
import '/../data/work_data.dart';
import 'package:dio/dio.dart';

import '/../providers/authentication.dart';

class AddSkill extends StatefulWidget {
  final List<String> skillNames;
  static const routeName = '/search-filter';
  const AddSkill({Key? key, required this.skillNames}) : super(key: key);

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  late List<Work> works;
  late String login;
  late bool _isLoading = false;
  Dio dio = Dio();
  List<String> options = [
    'Thất tình',
    'Tán tỉnh',
    'Bất an',
    'Ghen tuông',
    'Buồn',
    'Vui',
    'Tổn thương',
    'Giận dữ',
    'Chia tay',
  ];
  List<String> values = [];
  int number = 0;
  List<UserSkill> _skills = [];
  bool isShowError = false;
  final TextEditingController skillCtl = TextEditingController();

  @override
  void initState() {
    super.initState();

    print('Init Search Filter Pages');

    login = Provider.of<Authentication>(context, listen: false).userIdLogined;

    for (String skillName in widget.skillNames) {
      options.remove(skillName);
    }

    works = allWork;
    skillCtl.addListener(_onTextChanged);
  }

  onDelete(index) {
    setState(() {
      values.removeAt(index);
    });
  }

  void _onTextChanged() {
    if (skillCtl.text.length > 15) {
      setState(() {
        values.add(skillCtl.text);
      });
      skillCtl.clear();
    }
    setState(() {
      number = skillCtl.text.length;
    });
  }

  //
  Future<void> addSkill() async {
    bool check = false;
    for (String value in values) {
      if (checkText(value)) {
        check = true;
      }
    }
    if (check) {
      setState(() {
        isShowError = true;
      });
    } else {
      for (String value in values) {
        _skills.add(UserSkill(id: "null", skillName: value));
      }
      Navigator.pop(context, _skills);
    }
  }

  //

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Text(
                  'Thêm kỹ năng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontFamily: 'Loventine-Extrabold',
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: const Color(0xffF2F2F3),
                          borderRadius: BorderRadius.circular(15)),
                      child: TagEditor(
                        length: values.length,
                        controller: skillCtl,
                        minTextFieldWidth: values.length == 3 ? 10 : 50,
                        delimiters: [','],
                        hasAddButton: false,
                        maxLines: 2,
                        inputDecoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: values.isNotEmpty
                                ? ""
                                : 'Thêm kỹ năng sở trường của bạn\nĐược phân cách bởi dấu phẩy',
                            hintStyle: const TextStyle(fontSize: 14)),
                        onTagChanged: (newValue) {
                          setState(() {
                            values.add(newValue);
                          });
                        },
                        tagBuilder: (context, index) => _Chip(
                          index: index,
                          label: values[index],
                          onDeleted: onDelete,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        AnimatedContainer(
                          height: isShowError ? 20 : 0,
                          duration: const Duration(milliseconds: 50),
                          child: const Text(
                            "Thẻ tiêu đề chứa từ không phù hợp",
                            style: TextStyle(
                                color: Color.fromARGB(255, 216, 28, 14)),
                          ),
                        ),
                        const Spacer(),
                        Text(
                          "$number/15",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              options.isEmpty
                  ? const SizedBox()
                  : ChipsChoice<String>.multiple(
                      wrapped: true,
                      value: values,
                      onChanged: (val) {
                        setState(() {
                          print(values);
                          values = val;
                          print(val);
                          if (val.length == 3) {
                            skillCtl.clear();
                          }
                        });
                      },
                      choiceItems: C2Choice.listFrom<String, String>(
                        source: options,
                        value: (i, v) => v,
                        label: (i, v) => v,
                        tooltip: (i, v) => v,
                      ),
                      choiceCheckmark: true,
                      choiceStyle: C2ChipStyle.when(
                        enabled: C2ChipStyle(
                          backgroundColor: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          backgroundOpacity: 1,
                          borderColor: const Color(0xffF2F2F3),
                          borderStyle: BorderStyle.solid,
                          borderWidth: 1.5,
                          borderOpacity: 1,
                          foregroundStyle: const TextStyle(
                              fontSize: 15, fontFamily: "Loventine-Regular"),
                        ),
                        selected: C2ChipStyle(
                          backgroundColor: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          backgroundOpacity: 1,
                          borderColor: AppColor.mainColor,
                          checkmarkColor: AppColor.mainColor,
                          foregroundColor: AppColor.mainColor,
                          borderStyle: BorderStyle.solid,
                          borderWidth: 1,
                          borderOpacity: 1,
                          foregroundStyle: const TextStyle(
                              fontSize: 15, fontFamily: "Loventine-Regular"),
                        ),
                      )),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 56),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        primary: AppColor.mainColor,
                        onPrimary: Colors.white),
                    onPressed: (() async {
                      addSkill();
                    }),
                    child: _isLoading
                        ? Image.asset(
                            'assets/images/load.gif',
                            height: 50,
                          )
                        : const Text(
                            'Thêm kỹ năng',
                            style: TextStyle(
                              fontFamily: 'Loventine-Semibold',
                              //height: 26,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8, top: 3, bottom: 3),
      label: Text(label),
      labelStyle:
          const TextStyle(fontSize: 15, fontFamily: "Loventine-Regular"),
      side: const BorderSide(color: Color(0xffececed)),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      deleteIcon: Image.asset(
        "assets/images/sm_right_icon.png",
        width: 18,
        height: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
