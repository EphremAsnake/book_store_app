import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/appconfigs.dart';
import '../pages/navigations/home/logic.dart';
import '../services/apicalls.dart';
import '../services/repos/functions.dart';
import '../utils/constants/urls.dart';

class AppConfigController extends GetxController {
  final Dio _dio = Dio();
  final Rx<AppSettings?> appConfig = Rx<AppSettings?>(null);
  final RxBool appConfigFetched = RxBool(false);

  // @override
  // void onInit() {
  //   super.onInit();
  //   //fetchData();
  // }

  Future<void> fetchData(BuildContext context) async {
    final HomeLogic homeController = Get.find();
    String storedconfigdata = await getFromStorageConfigs();
    try {
      final response = await _dio.get(ApiUrls.configs);
      if (response.statusCode == 200) {
        appConfig.value = AppSettings.fromJson(response.data);
        
        homeController.allCategoriesList.clear();
        for (var element in Platform.isAndroid
            ? appConfig.value!.androidSettings.categories
            : appConfig.value!.iosSettings.categories) {
          homeController.allCategoriesList.add(Tab(text: element.name));
        }

        

        // ignore: use_build_context_synchronously
        getMethod(context, ApiUrls.bookslist, getBooksList);

        homeController.setPriceCategories(Platform.isAndroid
            ? appConfig.value!.androidSettings.priceRange
            : appConfig.value!.iosSettings.priceRange);

        
        saveToLocalStorageConfigs(response.data);
      } else {
        if (storedconfigdata != "") {
          await useLocalDataBoth();
        }
      }
      appConfigFetched.value = true;
      //print(appConfig.value!.androidSettings.aboutApp);
    } catch (e) {
      if (storedconfigdata != "") {
        await useLocalDataBoth();
      }
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
