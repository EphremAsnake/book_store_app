
import 'package:book_store/src/models/book.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../pages/navigations/home/logic.dart';
import '../../utils/constants/strings.dart';
import '../../widgets/customdialog.dart';

Logger log = Logger();

// getCategoriesList(
//     BuildContext context, bool responseCheck, List<dynamic> response) {
//   if (responseCheck) {
//     final HomeLogic homeController = Get.find();
//     //log.e(response);
//     final parsedCategories =
//         (response).map((item) => CategoryModel.fromJson(item)).toList();
//     // homeController.categories.value =
//     //     parsedCategories.map((e) => e.name!).toList();
//     homeController.allCategoriesList.clear();
//     for (var element in parsedCategories) {
//       homeController.allCategoriesList.add(Tab(text: element.name!));
//     }

//     homeController.tabController = TabController(
//         length: homeController.allCategoriesList.length,
//         vsync: homeController.reference!);
//     homeController.update();

//     getMethod(context, ApiUrls.bookslist, getBooksList);
//     // } else {
//     //   //Get.find<GeneralController>().updateFormLoaderController(false);
//     //   showDialog(
//     //       context: context,
//     //       barrierDismissible: false,
//     //       builder: (BuildContext context) {
//     //         return CustomDialogBox(
//     //           title: LanguageConstant.failed,
//     //           titleColor: AppColors.primaryColor,
//     //           descriptions: LanguageConstant.tryAgain,
//     //           text: LanguageConstant.ok,
//     //           functionCall: () {
//     //             Navigator.pop(context);
//     //           },

//     //         );
//     //       });
//     // }
//   } else {
//     //!Get.find<GeneralController>().updateFormLoaderController(false);

//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return CustomDialogBox(
//             title: LanguageConstant.failed,
//             titleColor: AppColors.primaryColor,
//             descriptions: LanguageConstant.tryAgain,
//             text: LanguageConstant.ok,
//             functionCall: () {
//               Navigator.pop(context);
//             },
//           );
//         });reference
//   }
// }

getBooksList(BuildContext context, bool responseCheck, List<dynamic> response) {
  final HomeLogic homeController = Get.find();
  if (responseCheck) {
    // final parsedCategories =
    //     (response).map((item) => BookModel.fromJson(item)).toList();
    homeController.allBooks.clear();
    homeController.allBooks =
        response.map((json) => BookModel.fromJson(json)).toList();
    homeController.filteredBooks.value = homeController.allBooks;

    // homeController.tabController!.addListener(() {
    //   if (homeController.tabController!.indexIsChanging) {
    //     String selectedCategory = homeController
    //             .allCategoriesList[homeController.tabController!.index].text ??
    //         'All';
    //     homeController.filterBooksByCategory(selectedCategory);
    //   }
    // });
    // homeController.bookslisttabController = TabController(
    //     length: homeController.allBooks.length,
    // //     vsync: homeController.reference!);
    // homeController.tabController!.length = homeController.allBooks.length;
    //getMethod(context, ApiUrls.prices, getPriceList);
    homeController.allcategoriesLoader.value = false;

  } else {
    //!Get.find<GeneralController>().updateFormLoaderController(false);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: LanguageConstant.failed,
            titleColor: AppColors.primaryColor,
            descriptions: LanguageConstant.tryAgain,
            text: LanguageConstant.ok,
            functionCall: () {
              Navigator.pop(context);
            },
          );
        });
  }
}

// getPriceList(BuildContext context, bool responseCheck, List<dynamic> response) {
//   final HomeLogic homeController = Get.find();
//   if (responseCheck) {
//     // BookPrices bookPrices = BookPrices.fromJson(response);
//     // log.e(bookPrices.categories[0].name);
//     //List<dynamic> jsonResponse = json.decode(response);
//     // List<PriceCategory> categories =
//     //     response.map((item) => PriceCategory.fromJson(item)).toList();
//     // homeController.setPriceCategories(categories);
//     //log.e(homeController.priceCategories[1].name);
//     homeController.allcategoriesLoader.value = false;
//   } else {
//     //!Get.find<GeneralController>().updateFormLoaderController(false);

//     showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return CustomDialogBox(
//             title: LanguageConstant.failed,
//             titleColor: AppColors.primaryColor,
//             descriptions: LanguageConstant.tryAgain,
//             text: LanguageConstant.ok,
//             functionCall: () {
//               Navigator.pop(context);
//             },
//           );
//         });
//   }
// }
