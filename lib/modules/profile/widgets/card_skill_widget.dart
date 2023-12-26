import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/modules/profile/pages/skill_page.dart';
import 'package:loventine_flutter/models/profile/user_skill.dart';

import '../../../values/app_color.dart';

class CardSkillWidget extends StatelessWidget {
  final bool isMe;
  final List<UserSkill> skills;
  const CardSkillWidget({super.key, this.isMe = false, required this.skills});

  @override
  Widget build(BuildContext context) {
    // List skills = [
    //   'Tán tỉnh',
    //   'Tư vấn tâm lý',
    //   'Lắng nghe',
    //   'Tâm sự',
    //   'Duy trì quan hệ',
    // ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 25,
          left: 25,
          bottom: 15,
        ),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset(
                    'assets/images/ic_skill.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Kĩ năng',
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: 'Loventine-Black',
                      fontWeight: FontWeight.bold,
                      color: Color(0xff141d39)),
                ),
                isMe
                    ? Expanded(
                        child: Align(
                          alignment: const Alignment(1, 0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => SkillPage(skills: skills),
                              ),
                            ),
                            child: SizedBox(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                "assets/svgs/edit-2.svg",
                                fit: BoxFit.cover,
                                color: AppColor.mainColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              height: 1,
              color: const Color.fromRGBO(222, 225, 231, 1),
            ),
            const SizedBox(height: 25),
            skills.isEmpty
                ? Text(
                    "Không có dữ liệu",
                    style: TextStyle(fontFamily: 'Loventine-Regular'),
                  )
                : SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        skills.length,
                        (index) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xFFF5F5F6),
                          ),
                          child: Text(
                            skills[index].skillName,
                            style: TextStyle(
                              color: Color.fromRGBO(82, 75, 107, 1),
                              fontFamily: 'Loventine-Regular',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
