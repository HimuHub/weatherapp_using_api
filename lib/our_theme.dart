import 'package:flutter/material.dart';

class CustomThemes {
  static final lightTheme = ThemeData(
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.grey[800],
    iconTheme: IconThemeData(color: Colors.grey[600]),
  );
  static final darkTheme = ThemeData(
    cardColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
  );
}
