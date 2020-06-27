import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const veryLightGreyColor = Color(0xFFE5E5E5);
const lightGreyColor = Color(0xFFE5E5E5);
const mediumGreyColor = Color(0xFFB2B2B2);
const orangeColor = Color(0xFFFF9635);
themeData (context) => ThemeData(
  primarySwatch: createMaterialColor(Color(0xFF1A1F71)),
  accentColor: Color.fromRGBO(247, 182, 0, 1),
  textTheme: GoogleFonts.quicksandTextTheme(
    Theme.of(context).textTheme,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF1A1F71), //  <-- dark color
    textTheme:
    ButtonTextTheme.primary, //  <-- this auto selects the right color
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
