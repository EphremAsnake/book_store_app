import 'dart:io';

import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
          // ignore: use_build_context_synchronously
          executionMethod(context, true, response.data);
          return;
        }
        logger.e('getApi $apiUrl ---->>>>  ${response.data}');
        // ignore: use_build_context_synchronously
        executionMethod(context, false, {'status': null});
      } on dio_instance.DioException catch (e) {
        logger.e('Dio Error     $apiUrl ---->>>>${e.response}');
        // ignore: use_build_context_synchronously
        executionMethod(context, false, {'status': null});

        if (e.response != null) {
        } else {}
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
