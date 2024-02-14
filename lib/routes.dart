import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/pages/bookdetails/bookdetails.dart';
import 'src/pages/navigations/bottom_navigation.dart';
import 'src/pages/navigations/home/homepage.dart';
import 'src/pages/splashscrenn/splashscreen.dart';

routes() => [
      GetPage(name: "/homepage", page: () => const HomePage()),
      GetPage(name: "/splash", page: () => const SplashScreen()),
      GetPage(name: "/navigationPage", page: () => const NavigationPage()),
    ];

class PageRoutes {
  static const String homepage = '/homepage';
  static const String splash = '/splash';
  static const String navigationPage = '/navigationPage';

  Map<String, WidgetBuilder> routes() {
    return {
      homepage: (context) => const HomePage(),
      splash: (context) => const SplashScreen(),
      navigationPage: (context) => const NavigationPage(),
    };
  }
}
