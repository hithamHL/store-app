
// Instantiate new  theme data
import 'package:flutter/material.dart';

final ThemeData appTheme = _appTheme();

//Define Base theme for app
ThemeData _appTheme() {
// We'll just overwrite whatever's already there using ThemeData.light()
  final ThemeData base = ThemeData.light();

  // Make changes to light() theme
  return base.copyWith(
    textTheme: _buildShrineTextTheme(base.textTheme),
    useMaterial3: true,
    colorScheme: base.colorScheme.copyWith(

      primary: const Color.fromARGB(255, 62, 184, 111),
      onPrimary: Colors.white,
      secondary: const Color.fromARGB(255, 89, 115, 222),
      onSecondary: Colors.white,
      background: const Color.fromARGB(255, 245, 245, 245),
      onBackground: Colors.black,
    ),
  );



}

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      .copyWith(
    headlineSmall: base.headlineSmall!.copyWith(
      fontWeight: FontWeight.w500,
    ),
    titleLarge: base.titleLarge!.copyWith(

      fontFamily:"Montserrat-Arabic-Bold",
      color: Color.fromARGB(255, 62, 62, 104),
    ),
    bodySmall: base.bodySmall!.copyWith(
      fontFamily: "Montserrat-Arabic-Regular",
      color: Colors.black,
      fontSize: 12

    ),
    titleMedium: base.titleMedium!.copyWith(
      fontFamily: "Montserrat-Arabic-Medium",
      color: Color.fromARGB(255, 62, 62, 104),
      fontSize: 16.0,
    ),
    titleSmall: base.titleSmall!.copyWith(
      fontFamily: "Montserrat-Arabic-Medium",
      color: Colors.black,
      fontSize: 12.0,
    ),


    bodyLarge: base.bodyLarge!.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16.0,
    ),

  )
      .apply(
    fontFamily: 'Montserrat',
  );
}