import 'package:flutter/material.dart';

import '../../utils/handle_string.dart';

class ColorInPage {
  static const blueColor = Color(0xFF356899);
  static const blackColor = Color(0xFF0D0D26);
  static const redColor = Color(0xFFEC1C24);
  static const backgroudColor = Color(0xFFFAFAFD);
  static const pinkColor = Color(0xFFf9babd);
  static const grayShapeColor = Color(0xFFE4E5E7);
  static const grayTextColor = Color(0xFF95969D);
}

class FieldItem extends StatelessWidget {
  final String content;
  final Function deleteField;

  const FieldItem({Key? key, required this.content, required this.deleteField})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: 50,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorInPage.pinkColor,
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const SizedBox(
              width: 8,
            ),
            Text(
              HandleString.validateForLongString(content),
              style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: ColorInPage.blackColor,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              width: 8,
            ),
            InkWell(
              onTap: () => deleteField(),
              child: const Image(
                  width: 7,
                  height: 7,
                  color: ColorInPage.blueColor,
                  image: AssetImage('assets/images/CrossSmall.png')),
            ),
            const SizedBox(
              width: 8,
            ),
          ]),
    );
  }
}
