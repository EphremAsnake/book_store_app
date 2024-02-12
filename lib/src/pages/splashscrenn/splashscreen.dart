import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Future.delayed(const Duration(seconds: 4), () {
      Get.offAllNamed('/homepage');
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
