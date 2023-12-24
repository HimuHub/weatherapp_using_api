import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:velocity/models/current_weather_model.dart';
import 'package:velocity/sevices/api_services.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  String searchText = 'auto:ip';
  ApiService apiService = ApiService();
  List<CurrentWeatherData> currentweatherdataList = [];
  bool loading = false;
  var isDark = false.obs;
  final _textFieldController = TextEditingController();

  @override
  void onInit() {
    currentweatherData();
    update();

    super.onInit();
  }

  void changeTheme() {
    isDark.value = !isDark.value;

    Get.changeThemeMode(isDark.value ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  changeThemeIcon() {
    return isDark.value ? Icons.nightlight_round : Icons.wb_sunny;
  }

  currentweatherData() async {
    try {
      loading = true;
      update();

      http.Response result = await apiService.getData(searchText);

      if (result.statusCode == 200) {
        Map<String, dynamic> datalist = jsonDecode(result.body);

        currentweatherdataList.clear();

        currentweatherdataList.add(CurrentWeatherData.fromJson(datalist));

        loading = false;
      }
      update();
    } catch (e) {
      print('Exception: $e');
      loading = false;
      update();
    }
  }

  _showTextInputDialog() async {
    return await Get.defaultDialog(
      title: 'Search Location',
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: TextField(
          controller: _textFieldController,
          decoration: InputDecoration(hintText: 'Search by city'),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (_textFieldController.text.isEmpty) {
              return;
            }
            Get.back(result: _textFieldController.text);
          },
          child: Text('yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(result: null);
          },
          child: Text('no'),
        )
      ],
    );
  }

  void searchWeather() async {
    _textFieldController.clear();
    var result = await _showTextInputDialog();

    if (result != null && result.isNotEmpty) {
      searchText = result;
      currentweatherData();
    }
  }

  void currentLocation() async {
    searchText = 'auto:ip';
    currentweatherdataList.clear();
    update();

    await currentweatherData();

    update();
  }
}
