import 'package:flutter/material.dart';
import './fluttermojiCustomizer.dart';

/// Defines the configuration of the overall visual [theme] for a [FluttermojiCustomizer]
/// and the widgets within it.
///
/// The [FluttermojiCustomizer]'s `theme` property can be used to configure the appearance
/// of the entire widget.
///
/// You can set the attributes of this class to make the customizer look more in
/// line with your app's own theme and style.
///
/// See more:
/// * [FluttermojiThemeData.standard] which is applied by default to the widgets.
class FluttermojiThemeData {
  final TextStyle labelTextStyle;
  final Color primaryBgColor;
  final Color secondaryBgColor;
  final Decoration selectedTileDecoration;
  final Decoration? unselectedTileDecoration;
  final Color iconColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Decoration boxDecoration;
  final ScrollPhysics scrollPhysics;
  final EdgeInsetsGeometry tilePadding;
  final EdgeInsetsGeometry tileMargin;

  FluttermojiThemeData({
    TextStyle? labelTextStyle,
    Color? primaryBgColor,
    Color? secondaryBgColor,
    Decoration? selectedTileDecoration,
    Decoration? unselectedTileDecoration,
    Color? iconColor,
    Color? selectedIconColor,
    Color? unselectedIconColor,
    Decoration? boxDecoration,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? tilePadding,
    EdgeInsetsGeometry? tileMargin,
  })  : this.primaryBgColor = primaryBgColor ?? const Color(0xFFFFFFFF),
        this.secondaryBgColor = secondaryBgColor ?? const Color(0xFFF1F1F1),
        this.iconColor = iconColor ?? const Color(0xFF9C9C9C),
        this.selectedIconColor = selectedIconColor ?? const Color(0xFF424242),
        this.unselectedIconColor =
            unselectedIconColor ?? const Color(0xFF9C9C9C),
        this.selectedTileDecoration = selectedTileDecoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(
                color: Color.fromARGB(255, 255, 36, 237),
                width: 2.0,
              ),
            ),
        this.unselectedTileDecoration = unselectedTileDecoration,
        this.boxDecoration = boxDecoration ??
            BoxDecoration(borderRadius: BorderRadius.circular(18)),
        this.labelTextStyle = labelTextStyle ??
            const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
        this.scrollPhysics = scrollPhysics ?? const ClampingScrollPhysics(),
        this.tileMargin = const EdgeInsets.all(2.0),
        this.tilePadding = const EdgeInsets.all(2.0);

  FluttermojiThemeData copyWith({
    TextStyle? labelTextStyle,
    Color? primaryBgColor,
    Color? secondaryBgColor,
    Decoration? selectedTileDecoration,
    Decoration? unselectedTileDecoration,
    Color? iconColor,
    Color? selectedIconColor,
    Decoration? boxDecoration,
    ScrollPhysics? scrollPhysics,
    EdgeInsetsGeometry? tilePadding,
    EdgeInsetsGeometry? tileMargin,
  }) {
    return FluttermojiThemeData(
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      primaryBgColor: primaryBgColor ?? this.primaryBgColor,
      secondaryBgColor: secondaryBgColor ?? this.secondaryBgColor,
      selectedTileDecoration:
          selectedTileDecoration ?? this.selectedTileDecoration,
      unselectedTileDecoration:
          unselectedTileDecoration ?? this.unselectedTileDecoration,
      iconColor: iconColor ?? this.iconColor,
      selectedIconColor: selectedIconColor ?? this.selectedIconColor,
      boxDecoration: boxDecoration ?? this.boxDecoration,
      scrollPhysics: scrollPhysics ?? this.scrollPhysics,
      tilePadding: tilePadding ?? this.tilePadding,
      tileMargin: tileMargin ?? this.tileMargin,
    );
  }

  static FluttermojiThemeData standard = FluttermojiThemeData(
    primaryBgColor: const Color(0xFFFFFFFF),
    secondaryBgColor: const Color(0xFFF1F1F1),
    iconColor: const Color(0xFF9C9C9C),
    selectedIconColor: const Color(0xFF424242),
    selectedTileDecoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: Color.fromARGB(255, 80, 0, 62),
        width: 2.0,
      ),
    ),
    unselectedTileDecoration: null,
    boxDecoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
    labelTextStyle:
        const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
    scrollPhysics: const ClampingScrollPhysics(),
    tileMargin: const EdgeInsets.all(2.0),
    tilePadding: const EdgeInsets.all(2.0),
  );
}
