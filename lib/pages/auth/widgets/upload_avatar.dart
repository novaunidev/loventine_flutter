import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:loventine_flutter/widgets/fluttermoji/fluttermoji.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadAvatar extends StatefulWidget {
  UploadAvatar({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _UploadAvatarState createState() => _UploadAvatarState();
}

class _UploadAvatarState extends State<UploadAvatar> {
  Future<void> clearSharedPreferencesData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await Future.wait([
      pref.remove('fluttermojiSelectedOptions'),
      pref.remove('fluttermoji'),
    ]);
    print("❗Đã xóa dữ liệu");
  }

  @override
  void initState() {
    // TODO: implement initState
    clearSharedPreferencesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 50, 30, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Thêm ảnh hồ sơ",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 23,
                      fontWeight: FontWeight.bold),
                ),
                const Text(
                    "Thêm ảnh hồ sơ để bạn bè biết đó là bạn. Mọi người sẽ có thể nhìn thấy hình ảnh của bạn.",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          FluttermojiCircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 100,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(8.0),
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: const Color(0xffE7407D),
                  ),
                  child: InkWell(
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          'attributeicons/brush-3.svg',
                          color: Colors.white,
                        ),
                        const Expanded(
                          child: Text(
                            "Tạo avatar của riêng bạn",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => NewPage()));
                    },
                  )),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const Text(
        "Made by NOVA UNIVERSE SOFTWARE Co., Ltd",
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w700, color: Colors.grey),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            'Hủy',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        actions: [
          FluttermojiSaveWidget(),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  scaffoldWidth: min(600, _width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                      boxDecoration: BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
