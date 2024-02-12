import 'package:book_store/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import 'src/pages/home/logic.dart';

void main() {
  Get.put(HomeLogic());
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
