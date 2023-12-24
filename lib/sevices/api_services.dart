import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:velocity/consts/strings.dart';
import 'package:velocity/models/current_weather_model.dart';

class ApiService {
  Future<http.Response> getData(String searchText) async {
    String url = '$link&q=$searchText&days=7';

    print('API Request URL: $url');
    try {
      http.Response response = await http.get(Uri.parse(url));
      return response;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
