import 'package:flutter/material.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFF9F9F9);
  // static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF150B3D);
  static const Color inputFoucusColor = Color(0xFF150B3D);
  static const Color iconColor = Color(0xFF95969D);
}

class LanguageContent {
  String imgURL;
  String name;
  bool isSelected;

  LanguageContent(
      {required this.imgURL, required this.name, required this.isSelected});
}

class SetLanguage extends StatefulWidget {
  const SetLanguage({Key? key}) : super(key: key);

  @override
  State<SetLanguage> createState() => _SetLanguageState();
}

class _SetLanguageState extends State<SetLanguage> {
  late List<LanguageContent> languages;
  late List<bool> isCurrentSelected;
  late int amountCurrentSelected = 0;
  late String query = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountCurrentSelected = 0;
    isCurrentSelected = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false,
    ];
    languages = [
      LanguageContent(
          imgURL: 'assets/images/arabic.png',
          name: 'Arabic',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/vietnam.png',
          name: 'Việt Nam',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/malaysian.png',
          name: 'Malaysian',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/english.png',
          name: 'English',
          isSelected: true),
      LanguageContent(
          imgURL: 'assets/images/french.png',
          name: 'French',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/german.png',
          name: 'German',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/hindi.png', name: 'Hindi', isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/italian.png',
          name: 'Italian',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/japan.png',
          name: 'Janpanese',
          isSelected: false),
      LanguageContent(
          imgURL: 'assets/images/korean.png',
          name: 'Korean',
          isSelected: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    final PreferredSizeWidget appBar = AppBar(
        elevation: 0.0,
        backgroundColor: ColorInPage.backgroudColor,
        leading: Container(
          margin: const EdgeInsets.fromLTRB(24, 0, 0, 0),
          child: IconButton(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            alignment: Alignment.centerLeft,
            onPressed: () {
              print('Exit set language page');
              Navigator.pop(context);
            },
            icon: const Image(image: AssetImage('assets/images/arrow.png')),
          ),
        ));
    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      appBar: appBar,
      body: SingleChildScrollView(
          child: Container(
              margin: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Thay đổi ngôn ngữ',
                      style: TextStyle(
                          color: Color(0xFF150B3D),
                          fontSize: 20,
                          wordSpacing: 3,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    TextField(
                        onChanged: (value) {
                          setState(() {
                            query = value;
                          });
                        },
                        cursorColor: ColorInPage.inputFoucusColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Image(
                              width: 15.64,
                              height: 16.02,
                              image: AssetImage('assets/images/Search.png')),
                          border: const OutlineInputBorder(),
                          hintText: 'Tìm kiếm ngôn ngữ',
                          hintStyle: const TextStyle(
                              fontSize: 15.0,
                              color: Color(0xFFE4E5E7),
                              fontWeight: FontWeight.w400),
                          isDense: true, // important line
                          contentPadding:
                              const EdgeInsets.fromLTRB(54, 15, 26, 14),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        )),
                    const SizedBox(
                      height: 24,
                    ),
                    for (int index = 0; index < languages.length; index++)
                      if ((query == '') ||
                          (languages[index]
                              .name
                              .toLowerCase()
                              .contains(query.toLowerCase()))) ...[
                        ListTile(
                            onTap: () {
                              setState(() {
                                bool res = false;
                                print(
                                    '$amountCurrentSelected ${isCurrentSelected[index]}');
                                if ((!isCurrentSelected[index]) &&
                                    (amountCurrentSelected < 1)) {
                                  // make keyboard down
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  res = true;
                                  amountCurrentSelected++;
                                }
                                if (isCurrentSelected[index] == true) {
                                  amountCurrentSelected--;
                                }
                                isCurrentSelected[index] = res;
                              });
                            },
                            selected: isCurrentSelected[index],
                            selectedTileColor: Color(0xFFA993FF),
                            tileColor: Colors.white,
                            shape: !isCurrentSelected[index]
                                ? const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)))
                                : const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                            leading: Image(
                                width: 30,
                                height: 26,
                                image: AssetImage(languages[index].imgURL)),
                            title: !isCurrentSelected[index]
                                ? Text(
                                    languages[index].name,
                                    style: const TextStyle(
                                        color: Color(0xFF150B3D),
                                        fontFamily: 'DMSans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )
                                : Text(
                                    languages[index].name,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'DMSans',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                            trailing: (languages[index].isSelected)
                                ? const Image(
                                    width: 8,
                                    height: 16,
                                    image: AssetImage('assets/images/tick.png'))
                                : null),
                        const SizedBox(height: 8)
                      ],
                    const SizedBox(height: 80),
                  ]))),
      floatingActionButton: Visibility(
          visible: !keyboardIsOpen,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                elevation: 0.0,
                shadowColor: Colors.transparent,
                minimumSize: const Size(213, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                primary: const Color(0xFFEC1C24),
                onPrimary: Colors.white),
            child: const FittedBox(
              child: Text(
                'THAY ĐỔI',
                style: TextStyle(
                    //height: 26,
                    letterSpacing: 2,
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w700),
              ),
            ),
            onPressed: () {
              print('Event: Change language');
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
