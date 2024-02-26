import 'dart:ffi';
import 'dart:io';

import 'package:book_store/src/models/book.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:resize/resize.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';

import '../../controller/appconfigs.dart';
import '../../widgets/book.dart';
import '../../widgets/bottomButton.dart';
import '../../widgets/downloadbutton.dart';
import '../inapppurchase/purchase/bookpurchase.dart';
import '../navigations/home/logic.dart';
import '../inapppurchase/subscription/components/status.dart';
import '../inapppurchase/subscription/subscription.dart';

// ignore: must_be_immutable
class BookDetails extends StatefulWidget {
  BookModel bookModel;
  BookDetails({super.key, required this.bookModel});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final controller = Get.put(HomeLogic());
  final appconfigsController = Get.put(AppConfigController());
  //final purchaseController = Get.put(PurchasedBooksController());
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;

  List<ProductDetails> _products = [];

  late List<String> _productIds;
  bool gotproducts = false;
  String monthlySubscriptionID = '';
  String purchasethisbookID = '';

  //!for individual purchase
  List<ProductDetails> _productspurchase = [];
  late List<String> _productIdspurchase;
  bool gotproductspurchase = false;
  final InAppPurchase _inAppPurchasepurchase = InAppPurchase.instance;
  //Logger logger = Logger();
  Future<void> initStoreInfopurchase() async {
    await _inAppPurchasepurchase.isAvailable();

    ProductDetailsResponse productDetailsResponsepurchase =
        await _inAppPurchase.queryProductDetails(_productIdspurchase.toSet());

    setState(() {
      _productspurchase = productDetailsResponsepurchase.productDetails;

      // logger.e(_productspurchase[0].description);
      // logger.e(widget.bookModel.categories[0]);
      //logger.e(homeController.getproductByName(widget.bookModel.pricecategories));
      gotproductspurchase = true;
    });
  }

  Future<void> initStoreInfo() async {
    await _inAppPurchase.isAvailable();

    ProductDetailsResponse productDetailsResponse =
        await _inAppPurchase.queryProductDetails(_productIds.toSet());

    setState(() {
      _products = productDetailsResponse.productDetails;
      //logger.e(_products[0].description);
      gotproducts = true;
    });
  }

  final HomeLogic homeController = Get.find();

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      purchasethisbookID = monthlySubscriptionID = appconfigsController
          .appConfig
          .value!
          .androidSettings
          .subscriptionSettings
          .monthSubscriptionId;
    } else if (Platform.isIOS) {
      monthlySubscriptionID = appconfigsController.appConfig.value!.iosSettings
          .subscriptionSettings.monthSubscriptionId;
    }

    _productIds = [monthlySubscriptionID];
    _productIdspurchase = [
      homeController.getproductByName(widget.bookModel.pricecategories)
    ];

    initStoreInfo();
    initStoreInfopurchase();
  }

  @override
  Widget build(BuildContext context) {
    // String descriptiontext = widget.bookModel.description;
    // double heightSize = MediaQuery.of(context).size.height * 0.6;
    // int siz = descriptiontext.length;
    // if (siz < 200) {
    //   heightSize = MediaQuery.of(context).size.height * 0.42;
    // } else {
    //   heightSize = MediaQuery.of(context).size.height * 0.55;
    // }

    return GetBuilder<PurchasedBooksController>(builder: (purchaseController) {
      return GetBuilder<SubscriptionStatus>(builder: (subscriptionStatus) {
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              notificationPredicate: (_) => false,
              iconTheme: const IconThemeData(color: AppColors.primarycolor2),
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              //physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 260.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.bookModel.thumbnailUrl),
                          fit: BoxFit.cover,
                        ),
                        //color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.bookModel.name,
                      //'The Book Title Name',
                      style: TextStyle(
                          color: AppColors.primarycolor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.sp),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Text(
                      widget.bookModel.author,
                      style: TextStyle(
                          color: AppColors.primarycolor2,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp),
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    Container(
                      height: 70.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                            color: Colors.grey.withOpacity(0.5), width: 1),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Spacer(),
                              Text(widget.bookModel.pageCount.toString(),
                                  style: TextStyle(
                                      color: AppColors.primarycolor2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp)),
                              Text(
                                'Pages',
                                style: TextStyle(
                                    color: AppColors.primarycolor2
                                        .withOpacity(0.5)),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Spacer(),
                              Text(widget.bookModel.language,
                                  style: TextStyle(
                                      color: AppColors.primarycolor2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp)),
                              Text(
                                'Language',
                                style: TextStyle(
                                    color: AppColors.primarycolor2
                                        .withOpacity(0.5)),
                              ),
                              const Spacer(),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Spacer(),
                              Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(widget.bookModel.publishedDate),
                                  style: TextStyle(
                                      color: AppColors.primarycolor2,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.sp)),
                              Text(
                                'Published',
                                style: TextStyle(
                                    color: AppColors.primarycolor2
                                        .withOpacity(0.5)),
                              ),
                              const Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    !widget.bookModel.locked ||
                            subscriptionStatus.isMonthly.value ||
                            subscriptionStatus.isYearly.value ||
                            purchaseController
                                .isBookPurchased(widget.bookModel.id)
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2,
                                child: DownloadButton(
                                  title: 'Download',
                                  disable: false,
                                  bookModel: widget.bookModel,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    !widget.bookModel.locked ||
                            subscriptionStatus.isMonthly.value ||
                            subscriptionStatus.isYearly.value ||
                            purchaseController
                                .isBookPurchased(widget.bookModel.id)
                        ? const SizedBox()
                        : Container(
                            padding: const EdgeInsets.only(
                                bottom: 0, left: 0, right: 0, top: 0),
                            color: Colors.white,
                            child: Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5.r),
                                    splashColor: Colors.green,
                                    onTap: () async {
                                      final box = GetStorage();
                                      box.write(
                                          'onWaybookID', widget.bookModel.id);
                                      if (gotproductspurchase) {
                                        late PurchaseParam purchaseParam;
                                        if (Platform.isAndroid) {
                                          purchaseParam =
                                              GooglePlayPurchaseParam(
                                                  productDetails:
                                                      _productspurchase[0],
                                                  changeSubscriptionParam:
                                                      null);
                                        } else {
                                          purchaseParam = PurchaseParam(
                                            productDetails:
                                                _productspurchase[0],
                                          );
                                        }

                                        InAppPurchase.instance.buyNonConsumable(
                                          purchaseParam: purchaseParam,
                                        );
                                      } else {
                                        initStoreInfopurchase();
                                      }
                                      // Get.to(PurchasePage(
                                      //   bookModel: widget.bookModel,
                                      // ));
                                    },
                                    child: MyCustomBottomBar(
                                      title: 'Buy this book',
                                      secline:
                                          'for \$${controller.getPriceByName(widget.bookModel.pricecategories)}',
                                      disable: false,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(5.r),
                                    splashColor: Colors.green,
                                    onTap: () async {
                                      if (gotproducts) {
                                        late PurchaseParam purchaseParam;
                                        if (Platform.isAndroid) {
                                          purchaseParam =
                                              GooglePlayPurchaseParam(
                                                  productDetails: _products[0],
                                                  changeSubscriptionParam:
                                                      null);
                                        } else {
                                          purchaseParam = PurchaseParam(
                                            productDetails: _products[0],
                                          );
                                        }

                                        InAppPurchase.instance.buyNonConsumable(
                                          purchaseParam: purchaseParam,
                                        );
                                      } else {
                                        initStoreInfo();
                                      }
                                      // Get.to(const SubscriptionPage(
                                      //     //bookModel: widget.bookModel,
                                      //     ));
                                    },
                                    child: const MyCustomBottomBar(
                                      first: true,
                                      title: 'Subscribe',
                                      secline: '\$2.99/Month',
                                      disable: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: TextStyle(
                              color: AppColors.primarycolor2,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.bookModel.description,
                      softWrap: true,
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.8),
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(
                      height: 5,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ));
      });
    });
  }
}
