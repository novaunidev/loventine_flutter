import 'package:flutter/material.dart';

import 'package:loventine_flutter/modules/profile/models/language.dart';

import 'package:loventine_flutter/modules/profile/widgets/level_language_dialog.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loventine_flutter/config.dart';
import 'package:dio/dio.dart';

import 'package:provider/provider.dart';
import '../../../providers/page/message_page/message_page_provider.dart';
import '../../../providers/page/message_page/card_profile_provider.dart';

class AddLanguagePage extends StatefulWidget {
  final Language language;

  const AddLanguagePage({
    super.key,
    required this.language,
  });

  @override
  State<AddLanguagePage> createState() => _AddLanguagePageState();
}

class _AddLanguagePageState extends State<AddLanguagePage> {
  final TextEditingController _speakController = TextEditingController();
  final TextEditingController _writeController = TextEditingController();
  final dio = Dio();
  late String current_user_id;
  late bool _isLoading = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    print("❗Đang lấy data ở Add Language Page");
    current_user_id =
        await Provider.of<MessagePageProvider>(context, listen: false)
            .current_user_id;
    await Provider.of<CardProfileProvider>(context)
        .fetchCurrentUser(current_user_id);
  }

  @override
  void dispose() {
    _speakController.dispose();
    _writeController.dispose();
    super.dispose();
  }

  //Add Language
  Future<void> addLanguage() async {
    try {
      var response = await dio.post(
          "$baseUrl/language/createLanguage/$current_user_id",
          data: {'languageName': widget.language.nameCountry});

      if (response.statusCode == 200) {
        Navigator.pop(context);
        //Start SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 90,
                  decoration: const BoxDecoration(
                      color: Color(0xff0c7040),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Row(
                    children: [
                      const SizedBox(width: 48),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Thêm thành công",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              "Bạn đã thêm thành công một ngôn ngữ mới",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                    child: SvgPicture.asset(
                      "assets/images/bubbles.svg",
                      height: 48,
                      width: 40,
                      color: const Color(0xff004e32),
                    ),
                  ),
                ),
                Positioned(
                    top: -20,
                    left: 0,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/fail.svg",
                          height: 40,
                          color: const Color(0xff004e32),
                        ),
                        Positioned(
                          top: 10,
                          child: SvgPicture.asset(
                            "assets/images/close.svg",
                            height: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        );
        //End SnackBar

        // print(response.data);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 90,
                decoration: const BoxDecoration(
                    color: Color(0xff0c7040),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Row(
                  children: [
                    const SizedBox(width: 48),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Thêm thất bại",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          Spacer(),
                          Text(
                            "Vui lòng thử lại hoặc liên hệ Support!",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    "assets/images/bubbles.svg",
                    height: 48,
                    width: 40,
                    color: const Color(0xff004e32),
                  ),
                ),
              ),
              Positioned(
                  top: -20,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/images/fail.svg",
                        height: 40,
                        color: const Color(0xff004e32),
                      ),
                      Positioned(
                        top: 10,
                        child: SvgPicture.asset(
                          "assets/images/close.svg",
                          height: 16,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
            ],
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),

        //End SnackBar
      );
      print(e);
    }
  }

  //End

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 240, 239, 239),
      body: SafeArea(
        child: SingleChildScrollView(
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
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  'Thêm ngôn ngữ',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ngôn ngữ',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              widget.language.imgCountry,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              widget.language.nameCountry,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0xFFDEE1E7),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ngôn ngữ chính',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        Radio<bool>(
                          toggleable: true,
                          activeColor: Colors.red,
                          value: widget.language.isMain,
                          groupValue: true,
                          onChanged: (isMain) {
                            setState(
                              () {
                                widget.language.isMain =
                                    !widget.language.isMain;
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nói',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: _speakController,
                      onTap: () async {
                        Level level = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => const LevelLanguageDialog(),
                        );
                        setState(() {
                          _speakController.text = convertLevel(level);
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: 'Điền mức độ thông thạo của bạn',
                      ),
                    ),
                    const Divider(
                      color: Color(0xFFDEE1E7),
                    ),
                    const Text(
                      'Viết',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    TextField(
                      controller: _writeController,
                      onTap: () async {
                        Level level = await showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (_) => const LevelLanguageDialog(),
                        );
                        setState(() {
                          _writeController.text = convertLevel(level);
                        });
                      },
                      decoration: const InputDecoration(
                          hintText: 'Điền mức độ thông thạo của bạn'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Mức độ thông thạo: 0: Kém, 10: Rất tốt',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFAAA6B9),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(230, 60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        primary: const Color(0xFFEC1C24),
                        onPrimary: Colors.white),
                    child: FittedBox(
                      child: _isLoading
                          ? Image.asset(
                              'assets/images/load.gif',
                              height: 50,
                            )
                          : const Text(
                              'Thêm ngôn ngữ',
                              style: TextStyle(
                                fontFamily: 'Loventine-Semibold',
                                //height: 26,
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                    ),
                    onPressed: (() async {
                      setState(() {
                        addLanguage();
                        _isLoading = true;
                      });
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  String convertLevel(Level level) {
    String levelName = '';
    switch (level) {
      case Level.level0:
        levelName = 'Level 0';
        break;
      case Level.level1:
        levelName = 'Level 1';
        break;
      case Level.level2:
        levelName = 'Level 2';
        break;
      case Level.level3:
        levelName = 'Level 3';
        break;
      case Level.level4:
        levelName = 'Level 4';
        break;
      case Level.level5:
        levelName = 'Level 5';
        break;
      case Level.level6:
        levelName = 'Level 6';
        break;
      case Level.level7:
        levelName = 'Level 7';
        break;
      case Level.level8:
        levelName = 'Level 8';
        break;
      case Level.level9:
        levelName = 'Level 9';
        break;
      case Level.level10:
        levelName = 'Level 10';
        break;
    }

    return levelName;
  }
}
