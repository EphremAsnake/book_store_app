import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appconfigs.dart';
import '../utils/constants/urls.dart';

class AppConfigController extends GetxController {
  final Dio _dio = Dio();
  final Rx<AppSettings?> appConfig = Rx<AppSettings?>(null);
  final RxBool appConfigFetched = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await _dio.get(ApiUrls.configs);
      if (response.statusCode == 200) {
        appConfig.value = AppSettings.fromJson(response.data);
        saveToLocalStorageConfigs(response.data);
      } else {
        await useLocalDataBoth();
      }
      appConfigFetched.value = true;
      //print(appConfig.value!.androidSettings.aboutApp);
    } catch (e) {
      await useLocalDataBoth();
      appConfigFetched.value = true;
      debugPrint('Error fetching data: $e');
    }
  }

  Future<void> useLocalDataBoth() async {
    String storedconfigdata = await getFromStorageConfigs();
    Map<String, dynamic> parsedconfigdata = json.decode(storedconfigdata);
    appConfig.value = AppSettings.fromJson(parsedconfigdata);
  }

  void saveToLocalStorageConfigs(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = json.encode(data); // Convert to JSON string
    await prefs.setString('config_data', jsonData);
  }

  Future<String> getFromStorageConfigs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('config_data');
    return storedData ?? "";
  }
}
