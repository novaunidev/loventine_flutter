import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';

class ColorInPage {
  static const blackColor = Color(0xFF0D0D26);
  static const backgroudColor = Color(0xFFF9F9F9);
  static const textColor = Color(0xFF000000);
  static const backgroundAppBar = Color(0xFF356899);
  static const buttonColor = Color(0xFF537fa8);
}

class NoSavings extends StatefulWidget {
  const NoSavings({Key? key}) : super(key: key);

  @override
  State<NoSavings> createState() => _NoSavingsState();
}

class _NoSavingsState extends State<NoSavings> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      backgroundColor: ColorInPage.backgroudColor,
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.fromLTRB(70, 80, 70, 80),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Danh sách lưu rỗng',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF150B3D),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                    style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xFF524B6B),
                        wordSpacing: 2),
                    text:
                        'Bạn chưa lưu bất kỳ công việc nào, vui lòng tìm nó trong tìm kiếm để lưu công việc'),
              ),
              Image.asset('assets/images/no_savings.png'),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    shadowColor: Colors.transparent,
                    minimumSize: Size(mediaQuery.size.width - 81 * 2, 56),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    primary: const Color(0xFFEC1C24),
                    onPrimary: Colors.white),
                child: const FittedBox(
                  child: Text(
                    'TÌM CÔNG VIỆC',
                    style: TextStyle(
                        letterSpacing: 0,
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'DMSans',
                        fontWeight: FontWeight.w700),
                  ),
                ),
                onPressed: () {
                  print('Event: Change language');
                },
              ),
              if (!isLandscape)
                const SizedBox(
                  height: 32,
                ),
            ],
          ),
        ),
      )),
    );
  }
}
