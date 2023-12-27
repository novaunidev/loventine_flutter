import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/providers/verify_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:provider/provider.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import 'id_card_recognition/controllers/extract_data_controller.dart';

const colorTextDescription = Color(0xFF6A7B88);
const colorTextBold = Color(0xff020202);

ExtractDataController extractDataController = Get.put(ExtractDataController());

final cloudinary = CloudinaryPublic('dkkdavbbq', 'mtrkthmf', cache: false);
void buildWindowsModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Xác minh danh tính không khả dụng trên Windows',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Loventine-Bold',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Hãy tải ứng dụng Loventine trên Android hoặc iOS để xác minh danh tính của bạn.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Loventine-Regular',
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  primary: AppColor.mainColor,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Tải ứng dụng',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Loventine-Bold',
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void showBottomSheetIdentityVerify(BuildContext context) {
  const double _pagePadding = 30;
  final pageIndexNotifier = ValueNotifier(0);
  Widget buildRow(String imageAsset, String title, String subtitle) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              imageAsset,
              height: 35,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Bold",
                        color: colorTextBold),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: colorTextDescription),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      backgroundColor: const Color(0xFFFAFAFC),
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(_pagePadding),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(213, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                primary: AppColor.mainColor,
                onPrimary: Colors.white),
            child: const FittedBox(
              child: Text(
                'Tiếp',
                style: TextStyle(
                  fontFamily: 'Loventine-Semibold',
                  //height: 26,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            onPressed: () {
              pageIndexNotifier.value = pageIndexNotifier.value + 1;
            }),
      ),
      pageTitle: const Text(
        "Xác minh danh tính",
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Loventine-Semibold",
            color: colorTextBold),
      ),
      isTopBarVisibleWhenScrolled: false,
      forceMaxHeight: true,
      heroImage: const SizedBox(),
      heroImageHeight: 25,
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 150),
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Huy hiệu đã xác minh ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: colorTextDescription,
                      ),
                    ),
                    WidgetSpan(
                      child: Image.asset(
                        "assets/images/verified.png",
                        width:
                            20, // Điều chỉnh kích thước hình ảnh theo ý của bạn
                        height: 20,
                      ),
                    ),
                    const TextSpan(
                      text:
                          " cho biết rằng Loventine đã xác minh tài khoản của bạn là thật và trùng khớp với thông tin trên trang cá nhân, giúp tạo niềm tin và uy tín với cộng đồng người dùng Loventine",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: colorTextDescription,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buildRow(
                "assets/images/verified.png",
                "Xác minh để Tạo Uy tín",
                "Nâng cao độ tin cậy của hồ sơ Loventine với huy hiệu xác minh màu xanh, mở cửa giao tiếp an toàn trong cộng đồng",
              ),
              buildRow(
                "assets/images/verified.png",
                "Huy hiệu xác minh, Định danh Đáng tin",
                "Đánh dấu sự minh bạch và xác thực của bạn trên Loventine, tách biệt hồ sơ từ đám đông với huy hiệu xác minh",
              ),
              buildRow(
                "assets/images/verified.png",
                "Kết nối Chất lượng với Huy hiệu",
                "Khẳng định sự nghiêm túc và chuyên nghiệp trên Loventine, chứng minh bạn là thành viên đáng tin cậy với huy hiệu xác minh",
              ),
            ],
          )),
    );
  }

  WoltModalSheetPage page2(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      backgroundColor: const Color(0xFFFAFAFC),
      pageTitle: const Text(
        "Chọn loại giấy tờ để xác minh danh tính của bạn",
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Loventine-Semibold",
            color: colorTextBold),
      ),
      isTopBarVisibleWhenScrolled: false,
      heroImage: const SizedBox(),
      heroImageHeight: 25,
      backButton: IconButton(
        onPressed: () {
          pageIndexNotifier.value = pageIndexNotifier.value - 1;
        },
        icon: Image.asset(
          "assets/images/searchResult_left.png",
          height: 15,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Column(
            children: [
              const Text(
                "Bạn cần cung cấp giấy tờ tùy thân chứa tên, ảnh và ngày sinh của bạn một cách rõ ràng và đầy đủ. Giấy tờ này là thông tin bảo mật và sẽ không hiển thị ở bất kỳ đâu.",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Loventine-Regular",
                    color: colorTextDescription),
              ),
              const SizedBox(
                height: 20,
              ),
              ChooseIdentity(
                next: () {
                  pageIndexNotifier.value = pageIndexNotifier.value + 1;
                },
              ),
            ],
          )),
    );
  }

  Widget tip(String title) {
    return Row(
      children: [
        Image.asset(
          "assets/images/icons8-tick.png",
          height: 20,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
              fontSize: 15,
              fontFamily: "Loventine-Regular",
              color: colorTextDescription),
        ),
      ],
    );
  }

  WoltModalSheetPage page3(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      backgroundColor: const Color(0xFFFAFAFC),
      pageTitle: const Text(
        "Chỉ cần chụp mặt trước giấy tờ tùy thân",
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Loventine-Semibold",
            color: colorTextBold),
      ),
      isTopBarVisibleWhenScrolled: false,
      heroImage: const SizedBox(),
      heroImageHeight: 25,
      backButton: IconButton(
        onPressed: () {
          pageIndexNotifier.value = pageIndexNotifier.value - 1;
        },
        icon: Image.asset(
          "assets/images/searchResult_left.png",
          height: 15,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 30),
          child: Column(
            children: [
              const Text(
                "Dùng camera trên điện thoại để chụp rõ thông tin trên giấy tờ tùy thân của bạn. Hệ thống thông minh của Loventine sẽ nhận diện các thông tin của bạn.",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Loventine-Regular",
                    color: colorTextDescription),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                  child: Lottie.asset("assets/lotties/scan_id_card.json",
                      height: 150)),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Tip cho một bức ảnh chất lượng",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Loventine-Semibold",
                    color: Color(0xff020202)),
              ),
              const SizedBox(
                height: 10,
              ),
              tip("Chọn khu vực đủ sáng "),
              const SizedBox(
                height: 10,
              ),
              tip("Đặt giấy tờ tùy thân lên mặt phẳng"),
              const SizedBox(
                height: 10,
              ),
              tip("Sử dụng phông nền tương phản"),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        primary: AppColor.mainColor,
                        onPrimary: Colors.white),
                    child: const FittedBox(
                      child: Text(
                        'Tiếp',
                        style: TextStyle(
                          fontFamily: 'Loventine-Semibold',
                          //height: 26,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      await extractDataController.getImage();
                      pageIndexNotifier.value = pageIndexNotifier.value + 1;
                    }),
              ),
            ],
          )),
    );
  }

  WoltModalSheetPage page4(
      BuildContext modalSheetContext, TextTheme textTheme) {
    String identity = "";
    return WoltModalSheetPage.withSingleChild(
      backgroundColor: const Color(0xFFFAFAFC),
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(_pagePadding),
        child: Column(
          children: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    primary: AppColor.mainColor,
                    onPrimary: Colors.white),
                child: const FittedBox(
                  child: Text(
                    'Tiếp',
                    style: TextStyle(
                      fontFamily: 'Loventine-Semibold',
                      //height: 26,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
                onPressed: () async {
                  identity = Provider.of<VerifyProvider>(context, listen: false)
                      .identity;

                  identity == "cccd"
                      ? await extractDataController.scanFile()
                      : await extractDataController.processImage();

                  if (extractDataController.idSerialNumber.value == '' ||
                      extractDataController.idBirthdate.value == '' ||
                      extractDataController.idAddress.value == '' ||
                      extractDataController.idName.value == '') {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Một số thông tin chưa nhận dạng được, vui lòng điều chỉnh lại",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Nhận dạng thành công",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                  pageIndexNotifier.value = pageIndexNotifier.value + 1;
                }),
            const SizedBox(
              height: 5,
            ),
            TextButton(
              onPressed: () async {
                await extractDataController.getImage();
              },
              child: const Text(
                'Chụp lại',
                style: TextStyle(
                  fontFamily: 'Loventine-Semibold',
                  //height: 26,
                  color: colorTextBold,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
      isTopBarVisibleWhenScrolled: false,
      heroImage: const SizedBox(),
      heroImageHeight: 25,
      forceMaxHeight: true,
      child: Obx(
        () => Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, _pagePadding, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Thông tin này có dễ đọc không?',
                  style: TextStyle(
                    fontFamily: 'Loventine-Semibold',
                    //height: 26,
                    color: colorTextBold,
                    fontSize: 16,
                  ),
                ),
                const Text(
                  "Hãy chắc chắn rằng mọi thông tin của bạn đều hiển thị rõ nét trong ảnh, nếu không chúng tôi có thể sẽ không chấp nhận giấy tờ tùy thân của bạn",
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: "Loventine-Regular",
                      color: colorTextDescription),
                ),
                extractDataController.imagePaths.isEmpty
                    ? SizedBox()
                    : Image.file(
                        File(extractDataController.imagePaths.last),
                      ),
              ],
            )),
      ),
    );
  }

  WoltModalSheetPage page5(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      backgroundColor: const Color(0xFFFAFAFC),
      forceMaxHeight: true,
      pageTitle: const Text(
        "Xác nhận thông tin trên giấy tờ tùy thân của bạn",
        style: TextStyle(
            fontSize: 30,
            fontFamily: "Loventine-Semibold",
            color: colorTextBold),
      ),
      isTopBarVisibleWhenScrolled: false,
      heroImage: const SizedBox(),
      heroImageHeight: 25,
      backButton: IconButton(
        onPressed: () {
          pageIndexNotifier.value = pageIndexNotifier.value - 1;
        },
        icon: Image.asset(
          "assets/images/searchResult_left.png",
          height: 15,
        ),
      ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Column(
            children: [
              const Text(
                "Vui lòng kiểm tra lại thông tin trên giấy tờ tùy thân của bạn, nếu không đúng hãy chỉnh sửa lại, sau khi nhận được thông tin xác minh tài khoản của bạn, hệ thống sẽ tiến hành xác minh trong vòng một tuần và gửi kết quả cho bạn",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Loventine-Regular",
                    color: colorTextDescription),
              ),
              const SizedBox(
                height: 20,
              ),
              Information(
                next: () {
                  pageIndexNotifier.value = pageIndexNotifier.value + 1;
                },
              ),
            ],
          )),
    );
  }

  WoltModalSheetPage page6(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
      backgroundColor: const Color(0xFFFAFAFC),
      stickyActionBar: Padding(
        padding: const EdgeInsets.all(_pagePadding),
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(213, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                primary: AppColor.mainColor,
                onPrimary: Colors.white),
            child: const FittedBox(
              child: Text(
                'Hoàn tất',
                style: TextStyle(
                  fontFamily: 'Loventine-Semibold',
                  //height: 26,
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      isTopBarVisibleWhenScrolled: false,
      forceMaxHeight: true,
      heroImage: const SizedBox(),
      heroImageHeight: 25,
      // backButton: Padding(
      //   padding: const EdgeInsets.only(top: 15, left: 20),
      //   child: InkWell(
      //     onTap: () {
      //       pageIndexNotifier.value = pageIndexNotifier.value - 1;
      //     },
      //     child: Image.asset(
      //       "assets/images/searchResult_left.png",
      //       height: 15,
      //     ),
      //   ),
      // ),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
          child: Column(
            children: [
              Lottie.asset("assets/lotties/done_send_verify.json", height: 300),
              RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text:
                          "Bạn sẽ nhận được biểu tượng xác minh màu xanh dương ",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: Color(0xFF333236),
                      ),
                    ),
                    WidgetSpan(
                      child: Image.asset(
                        "assets/images/verified.png",
                        width:
                            20, // Điều chỉnh kích thước hình ảnh theo ý của bạn
                        height: 20,
                      ),
                    ),
                    const TextSpan(
                      text:
                          " kèm theo tên của bạn khi danh tính của bạn được chứng thực.",
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: "Loventine-Regular",
                        color: Color(0xFF333236),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Quá trình này thông thường mất khoảng 48 giờ. Chúng tôi sẽ gửi thông báo cho bạn qua Loventine khi việc này hoàn tất.",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: "Loventine-Regular",
                    color: Color(0xFF333236)),
              ),
            ],
          )),
    );
  }

  WoltModalSheet.show<void>(
    pageIndexNotifier: pageIndexNotifier,
    context: context,
    pageListBuilder: (modalSheetContext) {
      final textTheme = Theme.of(context).textTheme;
      return [
        page1(modalSheetContext, textTheme),
        page2(modalSheetContext, textTheme),
        page3(modalSheetContext, textTheme),
        page4(modalSheetContext, textTheme),
        page5(modalSheetContext, textTheme),
        page6(modalSheetContext, textTheme),
      ];
    },
    onModalDismissedWithBarrierTap: () {
      Navigator.of(context).pop();
    },
    minPageHeight: 0.4,
    maxPageHeight: 0.95,
  );
}

enum Option { cccd, cmnd, gplx }

class ChooseIdentity extends StatefulWidget {
  final Function() next;
  const ChooseIdentity({super.key, required this.next});

  @override
  State<ChooseIdentity> createState() => _ChooseIdentityState();
}

class _ChooseIdentityState extends State<ChooseIdentity> {
  Option? _site = Option.values[0];
  int choose = 1;
  bool checkbox = true;
  Widget diveder() {
    return Container(
      height: 1,
      color: const Color(0xFFF9F9FB),
    );
  }

  Widget itemchoose(String title, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () async {
          setState(() {
            _site = Option.values[index];
          });
          await Provider.of<VerifyProvider>(context, listen: false)
              .setIndentity(index);
        },
        child: Row(
          children: [
            Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontFamily: "Loventine-Semibold",
                  color: Color(0xff020202)),
            ),
            const Spacer(),
            Checkbox(
              value: _site == Option.values[index],
              onChanged: (bool? value) async {
                setState(() {
                  _site = value != null && value == true
                      ? Option.values[index]
                      : null;
                });
                setState(() {
                  checkbox = value!;
                });
                await Provider.of<VerifyProvider>(context, listen: false)
                    .setIndentity(index);
              },
              shape: const CircleBorder(),
              activeColor: AppColor.mainColor,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            itemchoose("Căn cước công dân", 0),
            diveder(),
            itemchoose("Chứng minh nhân dân", 1),
            diveder(),
            itemchoose("Giấy phép lái xe", 2),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Giấy tờ tùy thân của bạn sẽ được hệ thống bảo vệ an toàn và xóa đi sau khi chúng tôi đã xác nhận được danh tính của bạn.",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Loventine-Regular",
                  color: colorTextDescription),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: checkbox ? AppColor.mainColor : Colors.grey,
                      onPrimary: Colors.white),
                  child: const FittedBox(
                    child: Text(
                      'Tiếp',
                      style: TextStyle(
                        fontFamily: 'Loventine-Semibold',
                        //height: 26,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onPressed: () {
                    checkbox ? widget.next() : {};
                  }),
            ),
          ],
        ));
  }
}

class Information extends StatefulWidget {
  final Function() next;
  const Information({super.key, required this.next});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  final idCard = TextEditingController();
  final name = TextEditingController();
  final birth = TextEditingController();
  final address = TextEditingController();

  bool isIdCard = false;
  bool isName = false;
  bool isBirth = false;
  bool isAddress = false;

  bool isLoading = false;

  String userId = "";
  String identity = "";
  String photo = "";

  Widget diveder() {
    return Container(
      height: 1,
      color: const Color(0xFFF9F9FB),
    );
  }

  Widget textField(TextEditingController controller, bool edit, String type) {
    return Row(
      children: [
        Image.asset(
          "assets/images/icons8-verify.png",
          height: 20,
          width: 20,
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextFormField(
              enabled: edit,
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                fontFamily: "Loventine-Semibold",
                color: colorTextBold,
              )),
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (type == "id") {
                isIdCard = true;
              } else if (type == "name") {
                isName = true;
              } else if (type == "birth") {
                isBirth = true;
              } else if (type == "address") {
                isAddress = true;
              }
            });
          },
          child: Image.asset(
            "assets/images/icons8-edit.png",
            height: 15,
            width: 15,
          ),
        ),
        const SizedBox(
          width: 5,
        )
      ],
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idCard.text = extractDataController.idSerialNumber.value == ''
        ? '-'
        : extractDataController.idSerialNumber.value;
    //===
    name.text = extractDataController.idName.value == ''
        ? "-"
        : extractDataController.idName.value;

    //===
    birth.text = extractDataController.idBirthdate.value == ''
        ? '-'
        : extractDataController.idBirthdate.value;
    //===
    address.text = extractDataController.idAddress.value == ''
        ? "-"
        : extractDataController.idAddress.value;
    userId = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
  }

  Future<void> creatVerify() async {
    try {
      setState(() {
        isLoading = true;
      });
      final cloudinaryFile = CloudinaryFile.fromFile(
          File(extractDataController.imagePaths.last).path,
          resourceType: CloudinaryResourceType.Image,
          folder: "verify");
      final responses = await cloudinary.uploadFile(cloudinaryFile);

      identity = Provider.of<VerifyProvider>(context, listen: false).identity;
      photo = responses.secureUrl;
      var response =
          await Dio().post("$baseUrl/verification/createVerifyRequest", data: {
        "userId": userId,
        "documentType": identity,
        "photo": photo,
        "name": name.text,
        "birthday": birth.text,
        "idCard": idCard.text,
        "permanentAddress": address.text
      });
      print(response.statusCode);
      if (response.statusCode == 200) {
        widget.next();
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            textField(idCard, isIdCard, "id"),
            diveder(),
            textField(name, isName, "name"),
            diveder(),
            textField(birth, isBirth, "birth"),
            diveder(),
            textField(address, isAddress, "address"),
            diveder(),
            Row(
              children: [
                Image.asset(
                  "assets/images/danger.png",
                  height: 15,
                  width: 15,
                ),
                const SizedBox(
                  width: 3,
                ),
                const Text(
                  "Các thông tin trên phải khớp với giấy tờ tùy thân của bạn",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Loventine-Regular",
                      color: colorTextDescription),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Thông tin tên và ngày sinh của bạn sẽ được cập nhật lên trang cá nhân sau khi xác minh tài khoản thành công. Lưu ý rằng bạn sẽ không có quyền chỉnh sửa các thông tin này sau đó.",
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: "Loventine-Regular",
                  color: colorTextDescription),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: AppColor.mainColor,
                      onPrimary: Colors.white),
                  child: FittedBox(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            'Xác nhận',
                            style: TextStyle(
                              fontFamily: 'Loventine-Semibold',
                              //height: 26,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                  ),
                  onPressed: () {
                    isLoading ? {} : creatVerify();
                  }),
            ),
          ],
        ));
  }
}
