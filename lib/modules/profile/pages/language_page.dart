import 'package:flutter/material.dart';

import 'package:loventine_flutter/modules/profile/pages/search_language_page.dart';
import 'package:loventine_flutter/modules/profile/widgets/button_save_widget.dart';
import 'package:loventine_flutter/models/profile/user_language.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loventine_flutter/config.dart';

class LanguagePage extends StatefulWidget {
  final List<UserLanguage> languages;

  const LanguagePage({
    super.key,
    required this.languages,
  });

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  final dio = Dio();
  //Delete
  Future<void> deleteLanguage(String idDelete, int index) async {
    try {
      Response response =
          await dio.delete("$baseUrl/language/deleteLanguage/$idDelete");
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          widget.languages.removeAt(index);
        });
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
                          children: [
                            Text(
                              "Xóa thành công",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Spacer(),
                            Text(
                              "Bạn xóa thành công",
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
      print(e);
    }
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
              onPressed: () => Navigator.of(context).pop(),
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
                    'Ngôn ngữ',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const SearchLanguagePage(),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Thêm',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Wrap(
                runSpacing: 10,
                children: List.generate(
                  widget.languages.length,
                  (index) => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            height: 30,
                            width: 30,
                            child: widget.languages[index].languageName ==
                                    "English"
                                ? Image.asset('assets/images/english.png')
                                : widget.languages[index].languageName ==
                                        "Việt Nam"
                                    ? Image.asset('assets/images/vietnam.png')
                                    : widget.languages[index].languageName ==
                                            "Italy"
                                        ? Image.asset(
                                            'assets/images/italian.png')
                                        : widget.languages[index]
                                                    .languageName ==
                                                "French"
                                            ? Image.asset(
                                                'assets/images/french.png')
                                            : Container()),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.languages[index].languageName,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            bool? value = await showModalBottomSheet<bool>(
                              isDismissible: false,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Text(
                                        'Xoá ngôn ngữ ${widget.languages[index].languageName}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Bạn có muốn xoá ngôn ngữ ${widget.languages[index].languageName} không ?',
                                        style: const TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                            Colors.red,
                                          ),
                                        ),
                                        child: const Center(
                                            child: Text('CHẮC CHẮN')),
                                        onPressed: () {
                                          deleteLanguage(
                                              widget.languages[index].id,
                                              index);
                                        },
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFFF5F7FA),
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

                            if (value! == true) {
                              setState(() {
                                widget.languages.removeAt(index);
                              });
                            }
                          },
                          icon: Image.asset('assets/images/delete_account.png'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Align(
              child: ButtonSaveWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
