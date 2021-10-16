import 'package:flutter/material.dart';
import 'package:racconder/config/racconder_theme.dart';
import 'package:racconder/dashboard/screens/home/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Racconder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TemaRacconder.textTheme,
      ),
      home: MyHomePage(title: 'Racconder'),

    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
