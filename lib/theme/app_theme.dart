
// Instantiate new  theme data
import 'package:flutter/material.dart';

final ThemeData appTheme = _appTheme();

//Define Base theme for app
ThemeData _appTheme() {
// We'll just overwrite whatever's already there using ThemeData.light()
  final ThemeData base = ThemeData.light();

  // Make changes to light() theme
  return base.copyWith(
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