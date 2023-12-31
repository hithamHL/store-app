import 'package:flutter/material.dart';
import 'package:store_app/theme/app_theme.dart';
import 'package:store_app/ui/products_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: appTheme,
      home: Directionality(
          textDirection: TextDirection.rtl,
          child: const ProductsScreen()),
    );
  }
}


