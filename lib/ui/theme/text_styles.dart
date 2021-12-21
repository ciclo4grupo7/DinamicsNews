import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static String? get fontFamily => GoogleFonts.openSans().fontFamily;
  //static String? get fontFamily => GoogleFonts.yanoneKaffeesatz().fontFamily;

  // Google font
  static TextStyle get defaultFontStyle => GoogleFonts.openSans();

  // if we need to change a style

  // Headline 1
  static TextStyle get headline1 => GoogleFonts.openSans(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        color: Colors.lightBlueAccent,
      );
  // Headline 2
  static TextStyle get headline2 => GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      );
  // Headline 3
  static TextStyle get headline3 => GoogleFonts.openSans(
        fontSize: 14.0,
        fontWeight: FontWeight.w700,
      );
  // Bodytext 1
  static TextStyle get bodytext1 => GoogleFonts.roboto(
        fontSize: 16.0,
        color: Colors.black,
      );
  // Caption
  static TextStyle get caption => GoogleFonts.openSans(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      );

  static TextTheme get textTheme => TextTheme(
        headline1: headline1,
        headline2: headline2,
        headline3: headline3,
        bodyText1: bodytext1,
        caption: caption,
      );
}
