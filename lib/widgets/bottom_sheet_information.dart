import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:loventine_flutter/config.dart';
import 'package:loventine_flutter/modules/profile/services/service.dart';
import 'package:loventine_flutter/pages/auth/widgets/upload_avatar.dart';
import 'package:loventine_flutter/providers/chat/socket_provider.dart';
import 'package:loventine_flutter/providers/information_provider.dart';
import 'package:loventine_flutter/providers/page/message_page/message_page_provider.dart';
import 'package:loventine_flutter/values/app_color.dart';
import 'package:loventine_flutter/widgets/button/spring_button.dart';
import 'package:loventine_flutter/widgets/fluttermoji/fluttermojiController.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

const colorTextDescription = Color(0xFF6A7B88);
const colorTextBold = Color(0xff020202);

void showBottomSheetInformations(BuildContext context) {
  final pageIndexNotifier = ValueNotifier(0);

  WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
        backgroundColor: const Color(0xFFFAFAFC),
        pageTitle: const Text(
          "Ngày sinh của bạn là",
          style: TextStyle(
              fontSize: 30,
              fontFamily: "Loventine-Semibold",
              color: colorTextBold),
        ),
        isTopBarVisibleWhenScrolled: false,
        heroImage: const SizedBox(),
        heroImageHeight: 25,
        child: TextFieldBirthDay(
          next: () {
            pageIndexNotifier.value = pageIndexNotifier.value + 1;
          },
        ));
  }

  WoltModalSheetPage page2(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
        backgroundColor: const Color(0xFFFAFAFC),
        stickyActionBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
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
        forceMaxHeight: true,
        pageTitle: const Text(
          "Bạn là",
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
        child: const ChooseSex());
  }

  WoltModalSheetPage page3(
      BuildContext modalSheetContext, TextTheme textTheme) {
    return WoltModalSheetPage.withSingleChild(
        backgroundColor: const Color(0xFFFAFAFC),
        pageTitle: const Text(
          "Thêm ảnh đại diện",
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
        child: const ChooseAvatar());
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
      ];
    },
    onModalDismissedWithBarrierTap: () {
      Navigator.of(context).pop();
    },
    minPageHeight: 0.4,
    maxPageHeight: 0.9,
  );
}

class TextFieldBirthDay extends StatefulWidget {
  final Function() next;
  const TextFieldBirthDay({super.key, required this.next});

  @override
  State<TextFieldBirthDay> createState() => _TextFieldBirthDayState();
}

class _TextFieldBirthDayState extends State<TextFieldBirthDay> {
  final dayCtl = TextEditingController();
  final monthCtl = TextEditingController();
  final yearCtl = TextEditingController();
  bool _isUserInputMonth = true;
  bool _isUserInputYear = true;
  bool isComplete = false;
  int year = DateTime.now().year;
  int year1 = 0;
  int year2 = 0;
  int year3 = 0;
  int year4 = 0;
  final defaultPinTheme = const PinTheme(
    width: 22,
    height: 35,
    textStyle: TextStyle(
      fontSize: 17,
      color: Color.fromRGBO(70, 69, 66, 1),
    ),
    decoration: BoxDecoration(
      color: Colors.transparent,
      border: Border(
        bottom: BorderSide(
          color: colorTextDescription,
          width: 2,
        ),
      ),
    ),
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    year1 = year ~/ 1000;
    year2 = (year % 1000) ~/ 100;
    year3 = (year % 100) ~/ 10;
    year4 = year % 10;
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Pinput(
              length: 2,
              defaultPinTheme: defaultPinTheme,
              controller: dayCtl,
              preFilledWidget: const Text(
                'D',
                style: TextStyle(
                  color: colorTextDescription,
                ),
              ),
              closeKeyboardWhenCompleted: false,
              onChanged: (value) {
                if (value.length == 1 && int.parse(value[0]) > 3) {
                  dayCtl.text = "";
                } else {
                  if (value.startsWith("3")) {
                    if (value.length == 2 && int.parse(value[1]) > 1) {
                      dayCtl.text = "3";
                    }
                  }
                }
              },
              onCompleted: (value) {
                if (value.length == 2) {
                  FocusScope.of(context).nextFocus();
                }
                if (dayCtl.text.isNotEmpty &&
                    monthCtl.text.isNotEmpty &&
                    yearCtl.text.isNotEmpty) {
                  setState(() {
                    isComplete = true;
                  });
                } else {
                  setState(() {
                    isComplete = false;
                  });
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "/",
                style: TextStyle(fontSize: 22, color: colorTextDescription),
              ),
            ),
            Pinput(
              length: 2,
              defaultPinTheme: defaultPinTheme,
              controller: monthCtl,
              closeKeyboardWhenCompleted: false,
              preFilledWidget: const Text(
                'M',
                style: TextStyle(
                  color: colorTextDescription,
                ),
              ),
              onChanged: (value) {
                if (!_isUserInputMonth) {
                  _isUserInputMonth = true;
                  return;
                }

                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                } else {
                  if (value.length == 1 && int.parse(value[0]) > 1) {
                    _isUserInputMonth = false;
                    monthCtl.text = "";
                  } else {
                    if (value.startsWith("1")) {
                      if (value.length == 2 && int.parse(value[1]) > 2) {
                        _isUserInputMonth = false;
                        monthCtl.text = "1";
                      }
                    }
                  }
                }
              },
              onCompleted: (value) {
                if (value.length == 2) {
                  FocusScope.of(context).nextFocus();
                }
                if (dayCtl.text.isNotEmpty &&
                    monthCtl.text.isNotEmpty &&
                    yearCtl.text.isNotEmpty) {
                  setState(() {
                    isComplete = true;
                  });
                } else {
                  setState(() {
                    isComplete = false;
                  });
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "/",
                style: TextStyle(fontSize: 22, color: colorTextDescription),
              ),
            ),
            Pinput(
              length: 4,
              defaultPinTheme: defaultPinTheme,
              controller: yearCtl,
              preFilledWidget: const Text(
                'Y',
                style: TextStyle(
                  color: colorTextDescription,
                ),
              ),
              onCompleted: (value) {
                if (dayCtl.text.isNotEmpty &&
                    monthCtl.text.isNotEmpty &&
                    yearCtl.text.isNotEmpty) {
                  setState(() {
                    isComplete = true;
                  });
                } else {
                  setState(() {
                    isComplete = false;
                  });
                }
              },
              onChanged: (value) {
                if (!_isUserInputYear) {
                  _isUserInputYear = true;
                  return;
                }

                if (value.isEmpty) {
                  FocusScope.of(context).previousFocus();
                } else {
                  if (value.length == 1 && int.parse(value[0]) > year1) {
                    _isUserInputYear = false;
                    yearCtl.text = "";
                  } else {
                    if (value.startsWith("$year1")) {
                      if (value.length == 2 && int.parse(value[1]) > year2) {
                        _isUserInputYear = false;
                        yearCtl.text = "$year1";
                      } else {
                        if (value.length == 3 && int.parse(value[2]) > year3) {
                          _isUserInputYear = false;
                          yearCtl.text = "$year1$year2";
                        } else {
                          if (value.startsWith("2")) {
                            if (value.length == 4 &&
                                int.parse(value[3]) > year4) {
                              _isUserInputYear = false;
                              yearCtl.text = "$year1$year2$year3";
                            }
                          }
                        }
                      }
                    }
                  }
                }
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "Ngày sinh của bạn sẽ được công khai",
          style: TextStyle(fontSize: 13, color: colorTextDescription),
        ),
        const SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  primary: isComplete ? AppColor.mainColor : Colors.grey,
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
                if (isComplete) {
                  widget.next();
                  Provider.of<InformationProvider>(context, listen: false)
                      .setBirthday(
                          "${dayCtl.text}/${monthCtl.text}/${yearCtl.text}");
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  await Future.wait([
                    pref.remove('fluttermojiSelectedOptions'),
                    pref.remove('fluttermoji'),
                  ]);
                }
              }),
        ),
      ],
    );
  }
}

class ChooseSex extends StatefulWidget {
  const ChooseSex({super.key});

  @override
  State<ChooseSex> createState() => _ChooseSexState();
}

class _ChooseSexState extends State<ChooseSex> {
  int sex = 1;
  Widget buttonSex(Function onPressed, String text) => Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SpringButton(
        AnimatedContainer(
          duration: const Duration(milliseconds: 125),
          width: 230,
          height: 50,
          curve: Curves.decelerate,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: sex == 1 && text == "Không muốn trả lời"
                    ? AppColor.mainColor
                    : sex == 2 && text == "Nam"
                        ? AppColor.mainColor
                        : sex == 3 && text == "Nữ"
                            ? AppColor.mainColor
                            : sex == 4 && text == "Đồng tính nam"
                                ? AppColor.mainColor
                                : sex == 5 && text == "Đồng tính nữ"
                                    ? AppColor.mainColor
                                    : sex == 6 && text == "Song tính"
                                        ? AppColor.mainColor
                                        : sex == 7 && text == "Chuyển giới"
                                            ? AppColor.mainColor
                                            : Colors.grey,
              )),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Loventine-Semibold',
                //height: 26,
                color: sex == 1 && text == "Không muốn trả lời"
                    ? AppColor.mainColor
                    : sex == 2 && text == "Nam"
                        ? AppColor.mainColor
                        : sex == 3 && text == "Nữ"
                            ? AppColor.mainColor
                            : sex == 4 && text == "Đồng tính nam"
                                ? AppColor.mainColor
                                : sex == 5 && text == "Đồng tính nữ"
                                    ? AppColor.mainColor
                                    : sex == 6 && text == "Song tính"
                                        ? AppColor.mainColor
                                        : sex == 7 && text == "Chuyển giới"
                                            ? AppColor.mainColor
                                            : Colors.grey,
                fontSize: 16,
              ),
            ),
          ),
        ),
        useCache: false,
        onTap: () async {
          onPressed();
        },
      ));
  @override
  Widget build(BuildContext context) {
    final informationProvider =
        Provider.of<InformationProvider>(context, listen: false);
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        buttonSex(() {
          setState(() {
            sex = 1;
          });
          informationProvider.setSex(1);
        }, "Không muốn trả lời"),
        buttonSex(() {
          setState(() {
            sex = 2;
          });
          informationProvider.setSex(2);
        }, "Nam"),
        buttonSex(() {
          setState(() {
            sex = 3;
          });
          informationProvider.setSex(3);
        }, "Nữ"),
        buttonSex(() {
          setState(() {
            sex = 4;
          });
          informationProvider.setSex(4);
        }, "Đồng tính nam"),
        buttonSex(() {
          setState(() {
            sex = 5;
          });
          informationProvider.setSex(5);
        }, "Đồng tính nữ"),
        buttonSex(() {
          setState(() {
            sex = 6;
          });
          informationProvider.setSex(6);
        }, "Song tính"),
        buttonSex(() {
          setState(() {
            sex = 7;
          });
          informationProvider.setSex(7);
        }, "Chuyển giới"),
      ],
    );
  }
}

class ChooseAvatar extends StatefulWidget {
  const ChooseAvatar({super.key});

  @override
  State<ChooseAvatar> createState() => _ChooseAvatarState();
}

class _ChooseAvatarState extends State<ChooseAvatar> {
  bool avatarOpt = true;
  File avatar = File("");
  bool isLoading = false;
  setAvatar() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String svg = pref.getString('fluttermoji') ?? "";
    final file = await svgToPng(svg, context);
    Directory tempDir = await getTemporaryDirectory();
    String uuid = const Uuid().v4();
    String tempPath = '${tempDir.path}/$uuid.png';

    avatar = File(tempPath);
    await avatar.writeAsBytes(file);
  }

  Future<Uint8List> svgToPng(String svgString, BuildContext context) async {
    final pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), context);

    final image = await pictureInfo.picture.toImage(300, 300);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }

    final pngBytes = byteData.buffer.asUint8List();

    return pngBytes;
  }

  uploadCloudinary(String path, String name, String userId) async {
    String uuid = const Uuid().v4();
    final responseCloudinary = await cloudinary.upload(
        file: path,
        //fileBytes: file.readAsBytesSync(),
        resourceType: CloudinaryResourceType.image,
        folder: "avatar",
        fileName: uuid,
        progressCallback: (count, total) {
          print('Uploading image from file with progress: $count/$total');
        });

    if (responseCloudinary.isSuccessful) {
      final response = await Dio().put(
        "$urlUsers/$userId",
        data: {
          "avatarUrl": responseCloudinary.secureUrl,
        },
      );
      if (response.statusCode == 204) {
        await Provider.of<MessagePageProvider>(context, listen: false)
            .setAvatarUrl(
                responseCloudinary.secureUrl!, responseCloudinary.publicId!);
      }
    }
  }

  updateUser() async {
    setState(() {
      isLoading = true;
    });
    String userID = Provider.of<MessagePageProvider>(context, listen: false)
        .current_user_id;
    if (avatarOpt) {
      await setAvatar();
      await uploadCloudinary(avatar.path, "avatar.png", userID);
    } else {
      XFile pickedFile =
          Provider.of<InformationProvider>(context, listen: false).pickedFile;
      await uploadCloudinary(pickedFile.path, pickedFile.name, userID);
    }

    String birthday =
        Provider.of<InformationProvider>(context, listen: false).birthday;
    String sex = Provider.of<InformationProvider>(context, listen: false).sex;

    final url = '$urlUsers/$userID';
    try {
      var response =
          await Dio().put(url, data: {'birthday': birthday, 'sex': sex});
      if (response.statusCode == 204) {
        //   CustomSnackbar.show(
        //     context,
        //     title: 'Cập nhật thành công',
        //     type: SnackbarType.success,
        //   );
        //   Navigator.pop(context);
        // } else {
        //   CustomSnackbar.show(
        //     context,
        //     title: 'Cập nhật thất bại',
        //     type: SnackbarType.failure,
        //   );
        Navigator.pop(context);
      }
    } catch (error) {
      // CustomSnackbar.show(
      //     context,
      //     title: 'Cập nhật thất bại',
      //     type: SnackbarType.failure,
      //   );
      //   Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Thêm ảnh đại diện vào hồ sơ của bạn để bạn bè biết đó là bạn. Mọi người có thể nhìn thấy hình ảnh của bạn",
          style: TextStyle(
            fontFamily: "Loventine-Regular",
            color: colorTextDescription,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: ClipOval(
              child: avatarOpt
                  ? buildGetX(context)
                  : Consumer<InformationProvider>(
                      builder: (context, value, child) => Image.file(
                        File(value.pickedFile.path),
                        fit: BoxFit.cover,
                      ),
                    )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
          child: Column(
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.white,
                      onPrimary: Colors.white,
                      elevation: 0),
                  child: const FittedBox(
                    child: Text(
                      'Tạo avatar của riêng bạn',
                      style: TextStyle(
                        fontFamily: 'Loventine-Semibold',
                        //height: 26,
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await Get.put(FluttermojiController());
                    setState(() {
                      avatarOpt = true;
                    });
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const NewPage())));
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.blue,
                      onPrimary: Colors.white,
                      elevation: 0),
                  child: const FittedBox(
                    child: Text(
                      'Thêm ảnh',
                      style: TextStyle(
                        fontFamily: 'Loventine-Semibold',
                        //height: 26,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      builder: (context) {
                        return SingleChildScrollView(
                          child:
                              Container(height: 100, child: const AddAvatar()),
                        );
                      },
                    ).then((value) {
                      setState(() {
                        avatarOpt = false;
                      });
                    });
                  }),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(isLoading ? 70 : double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: AppColor.mainColor,
                      onPrimary: Colors.white,
                      elevation: 0),
                  child: isLoading
                      ? Lottie.asset(
                          'assets/lotties/load_button.json',
                          width: 40,
                        )
                      : const Text(
                          'Hoàn tất',
                          style: TextStyle(
                            fontFamily: 'Loventine-Semibold',
                            //height: 26,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                  onPressed: () {
                    updateUser();
                  }),
            ],
          ),
        ),
      ],
    );
  }
}

class AddAvatar extends StatelessWidget {
  const AddAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final informationProvider =
        Provider.of<InformationProvider>(context, listen: false);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
        ),
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.end,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Chụp ảnh từ camera'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.camera, imageQuality: 12);
                  if (pickedFile != null) {
                    informationProvider.setPickedFile(pickedFile);
                  }
                } catch (e) {
                  print(e);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Chọn ảnh từ thư viện'),
              onTap: () async {
                Navigator.pop(context);
                try {
                  final pickedFile = await ImagePicker()
                      .pickImage(source: ImageSource.gallery, imageQuality: 12);
                  if (pickedFile != null) {
                    informationProvider.setPickedFile(pickedFile);
                  }
                } catch (e) {
                  print(e);
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

GetX<FluttermojiController> buildGetX(BuildContext context) {
  Future<Uint8List> svgToPng(String svgString, BuildContext context) async {
    final pictureInfo =
        await vg.loadPicture(SvgStringLoader(svgString), context);

    final image = await pictureInfo.picture.toImage(300, 300);
    final byteData = await image.toByteData(format: ImageByteFormat.png);

    if (byteData == null) {
      throw Exception('Unable to convert SVG to PNG');
    }

    final pngBytes = byteData.buffer.asUint8List();

    return pngBytes;
  }

  return GetX<FluttermojiController>(
      init: FluttermojiController(),
      autoRemove: false,
      builder: (controller) {
        if (controller.fluttermoji.value.isEmpty) {
          return const CupertinoActivityIndicator();
        }

        return FutureBuilder<Uint8List>(
          future: svgToPng(controller.fluttermoji.value, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CupertinoActivityIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData) {
              return const Text('No data');
            }
            // ImageSaver.saveImage(Uint8List.fromList(snapshot.data!), "oke");

            return SvgPicture.string(
              controller.fluttermoji.value,
              height: 75 * 1.6,
              semanticsLabel: "Your Fluttermoji",
              placeholderBuilder: (context) => const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          },
        );
      });
}
