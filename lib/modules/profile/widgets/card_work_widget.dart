import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/models/profile/user_work.dart';
import 'package:loventine_flutter/modules/profile/pages/work_experience_page.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/custom_page_route/custom_page_route.dart';
import '/modules/profile/widgets/work_edit_widget.dart';

class CardWorkWidget extends StatelessWidget {
  final bool isMe;
  final List<UserWork> works;
  const CardWorkWidget({
    super.key,
    this.isMe = false,
    required this.works,
  });

  @override
  Widget build(BuildContext context) {
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
                    'assets/images/ic_work_experience.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Công việc',
                  style: TextStyle(
                    fontFamily: 'Loventine-Black',
                    fontSize: 19,
                    color: Color(0xff141d39),
                  ),
                ),
                isMe
                    ? Expanded(
                        child: Align(
                          alignment: const Alignment(1, 0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const WorkExperiencePage(),
                              ),
                            ),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromRGBO(255, 158, 135, 0.2),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: AppColor.mainColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),

            //Start
            if (works.isEmpty) ...[
              const SizedBox(height: 20),
              Container(
                height: 1,
                color: const Color.fromRGBO(222, 225, 231, 1),
              ),
              const SizedBox(height: 25),
              const Text(
                "Không có dữ liệu",
                style: TextStyle(fontFamily: 'Loventine-Regular'),
              )
            ] else ...[
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: works.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (!isMe) {
                        appNavigate(
                            context,
                            WorkEditWidget(
                                workIndex: index, works: works, isMe: isMe));
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          height: 1,
                          color: const Color.fromRGBO(222, 225, 231, 1),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                works[index].company,
                                style: const TextStyle(
                                  fontFamily: 'Loventine-Extrabold',
                                  fontSize: 17,
                                ),
                              ),
                            ),
                            isMe
                                ? Align(
                                    alignment: const Alignment(1, 0),
                                    child: InkWell(
                                      onTap: () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => WorkEditWidget(
                                            workIndex: index,
                                            works: works,
                                            isMe: isMe,
                                          ),
                                        ),
                                      ),
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: SvgPicture.asset(
                                            "assets/svgs/edit-2.svg",
                                            fit: BoxFit.cover,
                                            color: AppColor.mainColor,
                                          )),
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        works[index].position == ""
                            ? const SizedBox()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      works[index].position,
                                      style: const TextStyle(
                                        fontFamily: 'Loventine-Regular',
                                        color: Color.fromRGBO(82, 75, 107, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        works[index].workStartDate.isNotEmpty &&
                                works[index].workEndDate.isNotEmpty
                            ? Row(
                                children: [
                                  const Text(
                                    "Thời gian: ",
                                    style: TextStyle(
                                        fontFamily: 'Loventine-Bold',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(82, 75, 107, 1),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "${works[index].workStartDate} - ${works[index].workEndDate}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      fontFamily: 'Loventine-Regular',
                                      color: Color.fromRGBO(82, 75, 107, 1),
                                      fontSize: 16,
                                    ),
                                  )
                                ],
                              )
                            : works[index].workStartDate.isNotEmpty ||
                                    works[index].workEndDate.isNotEmpty
                                ? Row(
                                    children: [
                                      const Text(
                                        "Thời gian: ",
                                        style: TextStyle(
                                            fontFamily: 'Loventine-Bold',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(82, 75, 107, 1),
                                            fontSize: 16),
                                      ),
                                      Text(
                                        works[index].workEndDate.isNotEmpty
                                            ? works[index].workEndDate
                                            : works[index].workStartDate,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontFamily: 'Loventine-Regular',
                                          color: Color.fromRGBO(82, 75, 107, 1),
                                          fontSize: 16,
                                        ),
                                      )
                                    ],
                                  )
                                : const SizedBox()
                      ],
                    ),
                  );
                },
              ),
            ]

            //end
          ],
        ),
      ),
    );
  }
}
