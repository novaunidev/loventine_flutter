import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/modules/profile/pages/education_page.dart';
import 'package:loventine_flutter/models/profile/user_education.dart';
import 'package:loventine_flutter/widgets/custom_page_route/custom_page_route.dart';
import '../../../values/app_color.dart';
import '/modules/profile/widgets/education_edit_widget.dart';

class CardStudyWidget extends StatelessWidget {
  final bool isMe;
  final List<UserEducation> educations;
  const CardStudyWidget(
      {super.key, this.isMe = false, required this.educations});

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
                    'assets/images/ic_education.png',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 15),
                const Text(
                  'Học vấn',
                  style: TextStyle(
                    fontFamily: 'Loventine-Black',
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isMe
                    ? Expanded(
                        child: Align(
                          alignment: const Alignment(1, 0),
                          child: InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => const EducationPage(),
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

            //
            if (educations.isEmpty) ...[
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
                physics:
                    const NeverScrollableScrollPhysics(), //dòng này vô hiệu hóa kéo để tránh kéo nhằm
                itemCount: educations.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      if (!isMe) {
                        appNavigate(
                            context,
                            EducationEditWidget(
                                eduIndex: index,
                                educations: educations,
                                isMe: isMe));
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
                            Text(
                              educations[index].level,
                              style: const TextStyle(
                                fontFamily: 'Loventine-Extrabold',
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            isMe
                                ? Expanded(
                                    child: Align(
                                      alignment: const Alignment(1, 0),
                                      child: InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => EducationEditWidget(
                                              eduIndex: index,
                                              educations: educations,
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
                                    ),
                                  )
                                : const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 10),
                        educations[index].schoolName.isEmpty
                            ? SizedBox()
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      educations[index].schoolName,
                                      style: const TextStyle(
                                        fontFamily: 'Loventine-Regular',
                                        color: Color.fromRGBO(82, 75, 107, 1),
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        educations[index].educationStartDate.isNotEmpty &&
                                educations[index].educationEndDate.isNotEmpty
                            ? Row(
                                children: [
                                  const Text(
                                    "Thời gian: ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'Loventine-Extrabold',
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(82, 75, 107, 1),
                                        fontSize: 16),
                                  ),
                                  Text(
                                    "${educations[index].educationStartDate} - ${educations[index].educationEndDate}",
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(
                                      color: Color.fromRGBO(82, 75, 107, 1),
                                      fontSize: 16,
                                      fontFamily: 'Loventine-Regular',
                                    ),
                                  )
                                ],
                              )
                            : educations[index].educationStartDate.isNotEmpty ||
                                    educations[index]
                                        .educationEndDate
                                        .isNotEmpty
                                ? Row(
                                    children: [
                                      const Text(
                                        "Thời gian: ",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'Loventine-Extrabold',
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(82, 75, 107, 1),
                                            fontSize: 16),
                                      ),
                                      Text(
                                        educations[index]
                                                .educationStartDate
                                                .isNotEmpty
                                            ? educations[index]
                                                .educationStartDate
                                            : educations[index]
                                                .educationEndDate,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          color: Color.fromRGBO(82, 75, 107, 1),
                                          fontSize: 16,
                                          fontFamily: 'Loventine-Regular',
                                        ),
                                      )
                                    ],
                                  )
                                : SizedBox(),
                      ],
                    ),
                  );
                },
              ),
            ]

            ///
          ],
        ),
      ),
    );
  }
}
