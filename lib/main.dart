import 'package:book_store/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:resize/resize.dart';

import 'src/controller/bookdownload.dart';
import 'src/pages/navigations/home/logic.dart';

Future<void> main() async {
  Get.put(HomeLogic());
  Get.put(DownloadedBooksController());
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
