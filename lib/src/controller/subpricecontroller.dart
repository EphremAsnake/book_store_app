import 'dart:io';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import 'appconfigs.dart';

class SubscriptionPriceController extends GetxController {
  String monthlyPrice = "£2.88";
  String yearlyPrice = "£16.98";

  void updateMonthlyPrice(mPrice) {
    monthlyPrice = mPrice;
    update();
  }

  void updateYearlyPrice(yPrice) {
    yearlyPrice = yPrice;
    update();
  }
}

class ProductsListController extends GetxController {
  List<ProductDetails> products = [];

  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final appconfigsController = Get.put(AppConfigController());
  List<String> _productIds = [];

  @override
  void onInit() {
    _productIds = [
      Platform.isAndroid
          ? appconfigsController.appConfig.value!.androidSettings
              .subscriptionSettings.monthSubscriptionId
          : appconfigsController.appConfig.value!.iosSettings
              .subscriptionSettings.monthSubscriptionId,
      Platform.isAndroid
          ? appconfigsController.appConfig.value!.androidSettings
              .subscriptionSettings.yearSubscriptionId
          : appconfigsController.appConfig.value!.iosSettings
              .subscriptionSettings.yearSubscriptionId
    ];
    initStoreInfo();
    //fetchPrices();
    super.onInit();
  }

  Future<void> initStoreInfo() async {
    await _inAppPurchase.isAvailable();

    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_productIds.toSet());

    //setState(() {
    products = productDetailsResponse.productDetails;
    update();
    //gotproducts = true;
    //});
  }
}


// class SubscriptionPriceController extends GetxController {
//   final String monthlySubscriptionID;
//   final String yearlySubscriptionID;

//   RxDouble _monthlyPrice = 0.0.obs;
//   RxDouble _yearlyPrice = 0.0.obs;

//   final InAppPurchase _inAppPurchase = InAppPurchase.instance;

//   double get monthlyPrice => _monthlyPrice.value;
//   double get yearlyPrice => _yearlyPrice.value;

//   SubscriptionPriceController({
//     required this.monthlySubscriptionID,
//     required this.yearlySubscriptionID,
//   });

//   List<String> get productIds => [monthlySubscriptionID, yearlySubscriptionID];

//   Future<void> fetchPrices() async {
//     final Set<String> ids = productIds.toSet();
//     final ProductDetailsResponse response =
//         await _inAppPurchase.queryProductDetails(ids);
//     if (response.error != null) {
//       // Handle error
//       return;
//     }

//     for (ProductDetails product in response.productDetails) {
//       if (product.id == monthlySubscriptionID) {
//         _monthlyPrice.value = double.parse(product.price);
//       } else if (product.id == yearlySubscriptionID) {
//         _yearlyPrice.value = double.parse(product.price);
//       }
//     }
//   }

//   @override
//   void onInit() {
//     fetchPrices();
//     super.onInit();
//   }
// }
