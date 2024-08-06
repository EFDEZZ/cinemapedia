
import 'package:flutter/material.dart';

// List<Color> colors = [
//   Colors.blue,
//   Colors.red,
//   Colors.yellow,
//   Colors.purple,
//   Colors.green,
//   Colors.pink,
//   Colors.orangeAccent,
//   Colors.indigo
// ];


class AppTheme{
  
  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF2862F5)
  );

}