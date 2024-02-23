import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/appconfigs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final configController = Get.find<AppConfigController>();

  @override
  void initState() {
    super.initState();
    configController.fetchData(context);
    configController.appConfigFetched.listen((value) {
      if (value) {
        Get.offAllNamed('/navigationPage');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
