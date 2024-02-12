import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'src/pages/bookdetails/bookdetails.dart';
import 'src/pages/home/homepage.dart';
import 'src/pages/splashscrenn/splashscreen.dart';

routes() => [
      GetPage(name: "/homepage", page: () => const HomePage()),
      GetPage(name: "/splash", page: () => const SplashScreen()),
      //  GetPage(name: "/bookdetail", page: () => const BookDetails()),
      
    ];

class PageRoutes {
  static const String homepage = '/homepage';
  static const String splash = '/splash';
  // static const String userHome = '/userHome';

  Map<String, WidgetBuilder> routes() {
    return {
      homepage: (context) => const HomePage(),
      splash: (context) => const SplashScreen(),
      // userHome: (context) => const UserHomePage(),
    };
  }
}
