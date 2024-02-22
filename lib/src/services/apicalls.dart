import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/strings.dart';
import '../widgets/customdialog.dart';

getMethod(BuildContext context, String apiUrl, Function executionMethod) async {
  dio_instance.Response response;
  dio_instance.Dio dio = dio_instance.Dio();
  var logger = Logger();

  // if (addAuthHeader && Get.find<ApiLogic>().storageBox.hasData('authToken')) {
  //   setCustomHeader(dio, 'Authorization',
  //       'Bearer ${Get.find<ApiLogic>().storageBox.read('authToken')}');
  // }
  // log('Get Method Api $apiUrl ---->>>>');
  // log('queryData $queryData ---->>>>');

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //! Get.find<ApiLogic>().changeInternetCheckerState(true);
      try {
        response = await dio.get(apiUrl);

        if (response.statusCode == 200) {
          logger.d('getApi $apiUrl ---->>>>  ${response.data}');
          saveToLocalStorageConfigs(apiUrl, response.data);
          // ignore: use_build_context_synchronously
          executionMethod(context, true, response.data);
          return;
        } else {
          String storeddata = await getFromStorageConfigs(apiUrl);
          if (storeddata != "") {
            List<dynamic> parseddata = json.decode(storeddata);
            // ignore: use_build_context_synchronously
            executionMethod(context, true, parseddata);
            return;
          } else {
            logger.e('getApi $apiUrl ---->>>>  ${response.data}');
            // ignore: use_build_context_synchronously
            executionMethod(context, false, {'status': null});
          }
        }
      } on dio_instance.DioException catch (e) {
        String storeddata = await getFromStorageConfigs(apiUrl);
        logger.e('stored data value $storeddata');
        if (storeddata != "") {
          List<dynamic> parseddata = json.decode(storeddata);
          // ignore: use_build_context_synchronously
          executionMethod(context, true, parseddata);
          return;
        } else {
          //! List<dynamic> parsedconfigdata = json.decode(storedconfigdata);
          logger.e('Dio Error     $apiUrl ---->>>>${e.response}');
          // ignore: use_build_context_synchronously
          executionMethod(context, false, []);

          if (e.response != null) {
          } else {}
        }
      }
    }
  } on SocketException catch (_) {
    //!Get.find<GeneralController>().updateFormLoaderController(false);
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.failed,
            titleColor: AppColors.primaryColor,
            descriptions: LanguageConstant.internetNotConnected,
            text: LanguageConstant.ok,
            functionCall: () {
              Navigator.pop(context);
            },
          );
        });
    //!Get.find<ApiLogic>().changeInternetCheckerState(false);
  }
}

Future<void> useLocalDataBoth(key) async {
  String storedconfigdata = await getFromStorageConfigs(key);
  List<dynamic> parsedconfigdata = json.decode(storedconfigdata);
  //appConfig.value = AppSettings.fromJson(parsedconfigdata);
}

void saveToLocalStorageConfigs(key, data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonData = json.encode(data); // Convert to JSON string
  await prefs.setString(key, jsonData);
}

Future<String> getFromStorageConfigs(key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedData = prefs.getString(key);
  return storedData ?? "da";
}
