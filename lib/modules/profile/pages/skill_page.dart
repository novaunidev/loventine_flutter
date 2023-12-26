import 'package:flutter/material.dart';
import 'package:loventine_flutter/models/profile/user_skill.dart';
import 'package:loventine_flutter/providers/page/message_page/card_profile_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/widgets/button/action_button.dart';
import 'package:loventine_flutter/widgets/custom_snackbar.dart';
import 'package:provider/provider.dart';
import '/modules/profile/pages/add_skill_page.dart';
import 'package:dio/dio.dart';
import 'package:loventine_flutter/config.dart';

class SkillPage extends StatefulWidget {
  final List<UserSkill> skills;

  const SkillPage({
    super.key,
    required this.skills,
  });

  @override
  State<SkillPage> createState() => _SkillPageState();
}

class _SkillPageState extends State<SkillPage> {
  late String current_user_id;
  // late String workId = widget.works[widget.workIndex].id;
  // late String companyShow = widget.works[widget.workIndex].company;
  // late String positionShow = widget.works[widget.workIndex].position;

  final dio = Dio();
  List<UserSkill> _skills = [];
  List<String> _skillsRemove = [];
  List<String> _skillsAdd = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _skills = List.from(widget.skills);
    current_user_id = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
  }

  void showSnackbar(bool isSuccess) {
    CustomSnackbar.show(
      context,
      type: isSuccess ? SnackbarType.success : SnackbarType.failure,
      title: isSuccess ? "Thông báo" : "Lỗi",
      message: isSuccess ? "Bạn đã lưu thành công" : "Vui lòng thử lại",
    );
  }

  Future<void> saveSkill() async {
    try {
      if (_skillsRemove.isNotEmpty) {
        var responseDelete = await dio.delete("$baseUrl/skill/deleteSkill",
            data: {"skillIds": _skillsRemove});
        if (responseDelete.statusCode == 200) {
          if (_skillsAdd.isNotEmpty) {
            var responseAdd = await dio.post(
                "$baseUrl/skill/createSkill/$current_user_id",
                data: {"skills": _skillsAdd});
            if (responseAdd.statusCode == 200) {
              Navigator.pop(context);
              Provider.of<CardProfileProvider>(context, listen: false)
                  .fetchCurrentUser(current_user_id);
              //Start SnackBar
              showSnackbar(true);
              //End SnackBar
            } else {
              Navigator.pop(context);
              showSnackbar(false);
            }
          } else {
            Navigator.pop(context);
            Provider.of<CardProfileProvider>(context, listen: false)
                .fetchCurrentUser(current_user_id);
            //Start SnackBar
            showSnackbar(true);
          }
        } else {
          Navigator.pop(context);
          showSnackbar(false);
        }
      } else {
        if (_skillsAdd.isNotEmpty) {
          var responseAdd = await dio.post(
              "$baseUrl/skill/createSkill/$current_user_id",
              data: {"skills": _skillsAdd});
          if (responseAdd.statusCode == 200) {
            Navigator.pop(context);
            Provider.of<CardProfileProvider>(context, listen: false)
                .fetchCurrentUser(current_user_id);
            //Start SnackBar
            showSnackbar(true);
            //End SnackBar
          } else {
            Navigator.pop(context);
            showSnackbar(false);
          }
        }
      }
    } catch (e) {
      print(e);
    }
  }

  //Delete
  Future<void> deleteSkill(String idDelete, int index) async {
    setState(() {
      if (_skills[index].id != "null") {
        _skillsRemove.add(_skills[index].id);
      } else {
        _skillsAdd.remove(_skills[index].skillName);
      }
      _skills.removeAt(index);
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Kỹ năng',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Loventine-Extrabold',
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('Event icon filter onTap');
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (context) => AddSkill()));
                      navigateToAddSkill(context);
                    },
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Thêm',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Loventine-Bold',
                            fontSize: 18,
                            color: Color(0xFF7551FF),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF3F13E4).withOpacity(0.2),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add,
                              color: Color(0xFF3F13E4),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 35),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ListView.builder(
                  itemCount: _skills.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: 30,
                          //   width: 30,
                          //   child: Image.asset(
                          //     widget.skills[index].imgCountry,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              _skills[index].skillName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Loventine-Regular',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              showModalBottomSheet<bool>(
                                isDismissible: true,
                                context: context,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(25.0),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 30.0,
                                      right: 30,
                                      top: 30,
                                      bottom: 20,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Xoá kỹ năng ${_skills[index].skillName}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          'Bạn có muốn xoá kỹ năng ${_skills[index].skillName} không ?',
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(
                                              Colors.red,
                                            ),
                                          ),
                                          child: const Center(
                                              child: Text('CHẮC CHẮN')),
                                          onPressed: () {
                                            deleteSkill(
                                                _skills[index].id, index);
                                          },
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              'HOÀN TÁC',
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          onPressed: () =>
                                              Navigator.pop(context, false),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            icon:
                                Image.asset('assets/images/delete_account.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ActionButton(
        text: 'Lưu',
        isChange: !(_skillsAdd.isEmpty && _skillsRemove.isEmpty),
        isLoading: isLoading,
        onTap: () async {
          setState(() {
            isLoading = true;
          });
          saveSkill();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void navigateToAddSkill(BuildContext ctxRoot) async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        context: ctxRoot,
        builder: (ctx) {
          final List<String> skillNames = [];
          for (int i = 0; i < _skills.length; i++) {
            skillNames.add(_skills[i].skillName);
          }
          return AddSkill(
            skillNames: skillNames,
          );
        }).then((value) {
      if (value != null) {
        setState(() {
          _skills.addAll(value);
          for (UserSkill skill in value) {
            _skillsAdd.add(skill.skillName);
          }
        });
      }
    });
  }
}
