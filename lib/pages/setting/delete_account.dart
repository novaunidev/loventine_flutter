import 'package:flutter/material.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const textColor = Color(0xFF000000);
}

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({Key? key}) : super(key: key);

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0))),
        elevation: 0.0,
        leading: const SizedBox(height: 0),
        backgroundColor: Colors.white);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: Container(
        width: mediaQuery.size.width,
        height: !isLandscape
            ? (mediaQuery.size.height - mediaQuery.padding.top) / 2
            : (mediaQuery.size.height - mediaQuery.padding.top),
        color: Colors.white,
        child: Container(
          margin: const EdgeInsets.fromLTRB(29, 0, 24, 29),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !isLandscape
                  ? const SizedBox(height: 25)
                  : const SizedBox(height: 0),
              const Text(
                'Bạn muốn xóa tài khoản?',
                style: TextStyle(
                    fontFamily: 'DMSans',
                    color: Color(0xFF150B3D),
                    fontSize: 16,
                    wordSpacing: 2,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 11),
              RichText(
                  text: const TextSpan(
                    text:
                        'Bạn có chắc chắn muốn xóa tài khoản này,\nbạn không thể khôi phục lại được tài khoản khi đã xóa',
                    style: TextStyle(
                        fontFamily: 'DMSans',
                        color: Color(0xFF524B6B),
                        fontSize: 12,
                        wordSpacing: 2,
                        fontWeight: FontWeight.w400),
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 29),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(317, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    primary: const Color(0xFFEC1C24),
                    onPrimary: Colors.white),
                child: const FittedBox(
                  child: Text(
                    'XÓA',
                    style: TextStyle(
                        //height: 26,
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {
                  print('Event: delete account');
                },
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    minimumSize: const Size(317, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    primary: const Color(0xFFF5F7FA),
                    onPrimary: Colors.white),
                child: const FittedBox(
                  child: Text(
                    'HOÀN TÁC',
                    style: TextStyle(
                        //height: 26,
                        letterSpacing: 2,
                        color: Color(0XFF243656),
                        fontSize: 16,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {
                  print('Event: undo delete account');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
