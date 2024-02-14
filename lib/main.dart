import 'package:book_store/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:resize/resize.dart';

import 'src/controller/appconfigs.dart';
import 'src/controller/downloadcontroller.dart';
import 'src/pages/navigations/home/logic.dart';

Future<void> main() async {
  Get.put(HomeLogic());
  Get.put(DownloadedBooksController());
  Get.put(AppConfigController());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> restorepurchase() async {
    await InAppPurchase.instance.restorePurchases();
  }

  @override
  void initState() {
    super.initState();
    restorepurchase();
  }

  @override
  Widget build(BuildContext context) {
    return Resize(
        allowtextScaling: true,
        size: const Size(375, 812),
        builder: () {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'E-Book',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            getPages: routes(),
            //home: const HomePage(),
            initialRoute: PageRoutes.splash,
          );
        });
  }
}
