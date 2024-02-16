import 'dart:io';

import 'package:book_store/src/models/book.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../controller/appconfigs.dart';
import '../../controller/subscriptionController.dart';
import '../../utils/constants/strings.dart';
import '../../widgets/subscriptionbutton.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import 'components/status.dart';

class SubscriptionPage extends StatefulWidget {
  // final BookModel bookModel;
  const SubscriptionPage({
    super.key,
  });

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  final appconfigsController = Get.put(AppConfigController());
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  late List<String> _productIds;
  bool gotproducts = false;
  List<ProductDetails> _products = [];
  final SubscriptionStatus subscriptionStatus = Get.put(SubscriptionStatus());

  Future<void> initStoreInfo() async {
    await _inAppPurchase.isAvailable();

    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_productIds.toSet());

    setState(() {
      _products = productDetailsResponse.productDetails;
      gotproducts = true;
    });
  }

  String monthlySubscriptionID = '';
  String yearlySubscriptionID = '';

  String monthlySubscriptionText = '';
  String yearlySubscriptionText = '';

  String subscriptiongeneraltext = '';

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      monthlySubscriptionID = appconfigsController.appConfig.value!
          .androidSettings.subscriptionSettings.monthSubscriptionId;

      monthlySubscriptionText = appconfigsController.appConfig.value!
          .androidSettings.subscriptionSettings.monthSubscriptionText;

      yearlySubscriptionID = appconfigsController.appConfig.value!
          .androidSettings.subscriptionSettings.yearSubscriptionId;

      yearlySubscriptionText = appconfigsController.appConfig.value!
          .androidSettings.subscriptionSettings.yearSubscriptionText;

      subscriptiongeneraltext = appconfigsController.appConfig.value!
          .androidSettings.subscriptionSettings.generalSubscriptionText;
    } else if (Platform.isIOS) {
      monthlySubscriptionID = appconfigsController.appConfig.value!.iosSettings
          .subscriptionSettings.monthSubscriptionId;

      monthlySubscriptionText = appconfigsController.appConfig.value!
          .iosSettings.subscriptionSettings.monthSubscriptionText;

      yearlySubscriptionText = appconfigsController.appConfig.value!.iosSettings
          .subscriptionSettings.yearSubscriptionText;

      yearlySubscriptionID = appconfigsController
          .appConfig.value!.iosSettings.subscriptionSettings.yearSubscriptionId;

      subscriptiongeneraltext = appconfigsController.appConfig.value!
          .androidSettings.subscriptionSettings.generalSubscriptionText;
    }

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() {
          return Stack(children: [
            SingleChildScrollView(
                //physics: const BouncingScrollPhysics(),
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: AppColors.primarycolor2,
                          borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50))),
                      height: MediaQuery.of(context).size.height * 0.4,
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.053,
                        right: 20,
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 35,
                          ),
                          color: Colors.white,
                        )),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.17,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                subscriptionStatus.isMonthly.value
                                    ? LanguageConstant
                                        .youareSubscribedtoMonthlypackage
                                    : subscriptionStatus.isYearly.value
                                        ? LanguageConstant
                                            .youareSubscribedtoYearlypackage
                                        : subscriptiongeneraltext,
                                // 'Unlock Unlimited Reading: Dive into a World of Books with our Monthly and Yearly Subscriptions!',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                        ))
                  ],
                ),
                _products.isNotEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _products.length,
                              itemBuilder: ((context, index) {
                                return SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      splashColor: Colors.green,
                                      onTap: () async {
                                        subscriptionController.showProgress();
                                        late PurchaseParam purchaseParam;
                                        if (Platform.isAndroid) {
                                          purchaseParam =
                                              GooglePlayPurchaseParam(
                                                  productDetails:
                                                      _products[index],
                                                  changeSubscriptionParam:
                                                      null);
                                        } else {
                                          purchaseParam = PurchaseParam(
                                            productDetails: _products[index],
                                          );
                                        }

                                        InAppPurchase.instance.buyNonConsumable(
                                          purchaseParam: purchaseParam,
                                        );
                                      },
                                      child: SubscriptionButton(
                                        title: _products[index].id ==
                                                monthlySubscriptionID
                                            ? '${_products[index].price}${monthlySubscriptionText}'
                                            : _products[index].id ==
                                                    yearlySubscriptionID
                                                ? '${_products[index].price}${yearlySubscriptionText}'
                                                : '',
                                        secline: _products[index].id ==
                                                monthlySubscriptionID
                                            ? ''
                                            : _products[index].id ==
                                                    yearlySubscriptionID
                                                ? ''
                                                : '',
                                        disable: false,
                                      ),
                                    ),
                                  ),
                                );
                              })),

                          const SizedBox(
                            height: 20,
                          ),
                          
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                child: const Text(
                                  'Restore Purchase',
                                  style: TextStyle(color: AppColors.primarycolor2,),
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // InkWell(
                              //   onTap: () {

                              //   },
                              //   splashColor: Colors.green,
                              //   child: const Text(
                              //       'Privacy Policy',
                              //       style: TextStyle(color: Colors.black),
                              //     ),
                              // ),
                              const SizedBox(),
                              TextButton(
                                child: const Text(
                                  'Privacy Policy',
                                  style: TextStyle(color: AppColors.primarycolor2,),
                                ),
                                onPressed: () {},
                              ),
                              TextButton(
                                child: const Text(
                                  'Terms of Service',
                                  style: TextStyle(color: AppColors.primarycolor2,),
                                ),
                                onPressed: () {},
                              ),
                              const SizedBox(),
                            ],
                          )
                        ],
                      )
                    : const Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.black,
                        )),
                      )
              ],
            )),
          ]);
        }));
  }
}
