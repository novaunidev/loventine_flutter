import 'package:flutter/material.dart';
import '../values/app_color.dart';

class AppText {
  //Describe Text
  static TextStyle describeText(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? AppColor.describetextcolor,
      fontFamily: fontFamily ?? "Loventine-Regular",
    );
  }

  //Title Header
  static TextStyle titleHeader(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 18,
      color: color ?? AppColor.blackColor,
      fontFamily: fontFamily ?? "Loventine-Bold",
    );
  }

  //Content Regular
  static TextStyle contentRegular(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? AppColor.blackColor,
      fontFamily: fontFamily ?? "Loventine-Regular",
    );
  }

  //Content Bold
  static TextStyle contentBold(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? AppColor.blackColor,
      fontFamily: fontFamily ?? "Loventine-Bold",
    );
  }

  //Content Black
  static TextStyle contentBlack(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? AppColor.blackColor,
      fontFamily: fontFamily ?? "Loventine-Black",
    );
  }

  //Content Semibold
  static TextStyle contentSemibold(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? AppColor.blackColor,
      fontFamily: fontFamily ?? "Loventine-Semibold",
    );
  }

  //Content Extrabold
  static TextStyle contentExtrabold(
      {double? fontSize, Color? color, String? fontFamily}) {
    return TextStyle(
      fontSize: fontSize ?? 15,
      color: color ?? AppColor.blackColor,
      fontFamily: fontFamily ?? "Loventine-Extrabold",
    );
  }
}

// style: AppText.titleHeader()