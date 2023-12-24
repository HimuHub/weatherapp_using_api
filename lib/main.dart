import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:velocity/screen/home.dart';
import 'package:velocity/our_theme.dart';

void main() {
  runApp(GetMaterialApp(
      theme: CustomThemes.lightTheme,
      darkTheme: CustomThemes.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      title: 'weather app',
      home: Home()));
}
