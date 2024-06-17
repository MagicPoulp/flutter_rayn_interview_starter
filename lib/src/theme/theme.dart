import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// we could use a generic color theme using ColorScheme
// but since the key names are not good (bodyMedium, tertiary),
// we prefer a custom list of colors
// moreover, colors in the colorScheme could have hidden modifications as we found

// colors were found using Gimp
class MyColorTheme {
  static const Color appBar = Color(0xFF2196f3);
  static const Color redButton = Color(0xFFf44336);
  static const Color blueButton = Color(0xFF2196f3);
  static const Color blueTextNoWinner = Color(0xFF2196f3);
  static const Color redTextWinner = Color(0xFFf44336);
  static const Color closeToBlack = Color(0xFF202020);
  static const Color closeToWhiteBackground = Color(0xFFfafafa);
  static const Color gridBorder = Color(0xFF9e9e9e);
}

class MyTextTheme {
  // for the app bar
  static TextStyle appBarText = GoogleFonts.roboto(
    textStyle: const TextStyle(color: MyColorTheme.closeToWhiteBackground, letterSpacing: .5, fontSize: 28),
  );
  // for buttons
  static TextStyle buttonsText = GoogleFonts.lato(
    textStyle: const TextStyle(color: MyColorTheme.closeToWhiteBackground, fontSize: 15, fontWeight: FontWeight.bold),
  );
  // blue text no winner
  static TextStyle blueTextNoWinner = GoogleFonts.lato(
    textStyle: const TextStyle(
    color: MyColorTheme.blueTextNoWinner, fontSize: 15),
  );
  // red text winner
  static TextStyle redTextWinner = GoogleFonts.lato(
    textStyle: const TextStyle(
        color: MyColorTheme.redTextWinner, fontSize: 22),
  );
  // black text
  static TextStyle closeToBlackText =  GoogleFonts.lato(
    textStyle: const TextStyle(color: MyColorTheme.closeToBlack, fontSize: 15),
  );
  // bold black text
  static TextStyle closeToBlackTextBold =  GoogleFonts.lato(
    textStyle: const TextStyle(color: MyColorTheme.closeToBlack, fontSize: 15, fontWeight: FontWeight.bold),
  );
}
