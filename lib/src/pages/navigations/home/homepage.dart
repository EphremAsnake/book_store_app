import 'dart:async';
import 'dart:io';

import 'package:book_store/src/pages/bookdetails/bookdetails.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:book_store/src/utils/constants/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:resize/resize.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

import '../../../controller/appconfigs.dart';
import '../../../controller/downloadcontroller.dart';
import '../../../services/apicalls.dart';
import '../../../services/repos/functions.dart';
import '../../../widgets/book.dart';
import '../../searchbooks/searchpage.dart';
import '../../inapppurchase/subscription/IAPservices.dart';
import 'component/silverappbar.dart';
import 'logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(HomeLogic());
  final configController = Get.put(AppConfigController());
  final storageController = Get.find<DownloadedBooksController>();
  late StreamSubscription<List<PurchaseDetails>> _iapSubscription;

  @override
  void initState() {
    super.initState();

    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;

    _iapSubscription = purchaseUpdated.listen((purchaseDetailsList) {
      IAPService(
              monthlyProductId: Platform.isAndroid
                  ? configController.appConfig.value!.androidSettings
                      .subscriptionSettings.monthSubscriptionId
                  : configController.appConfig.value!.iosSettings
                      .subscriptionSettings.monthSubscriptionId,
              yearlyProductId: Platform.isAndroid
                  ? configController.appConfig.value!.androidSettings
                      .subscriptionSettings.yearSubscriptionId
                  : configController.appConfig.value!.iosSettings
                      .subscriptionSettings.yearSubscriptionId)
          .listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _iapSubscription.cancel();
    }, onError: (error) {
      _iapSubscription.cancel();
    }) as StreamSubscription<List<PurchaseDetails>>;

    //!Check Subscription Availability
    IAPService(
            monthlyProductId: Platform.isAndroid
                ? configController.appConfig.value!.androidSettings
                    .subscriptionSettings.monthSubscriptionId
                : configController.appConfig.value!.iosSettings
                    .subscriptionSettings.monthSubscriptionId,
            yearlyProductId: Platform.isAndroid
                ? configController.appConfig.value!.androidSettings
                    .subscriptionSettings.yearSubscriptionId
                : configController.appConfig.value!.iosSettings
                    .subscriptionSettings.yearSubscriptionId)
        .checkSubscriptionAvailabilty();

    controller.reference = this;
    controller.tabController = TabController(
        length: controller.allCategoriesList.length,
        vsync: controller.reference!);

    controller.update();
    storageController.loadDownloadedBooks();

    //getMethod(context, ApiUrls.categories, getCategoriesList);

    // getMethod(context, ApiUrls.bookslist, getBooksList);

    if (controller.allCategoriesList.isNotEmpty) {
      controller.tabController!.addListener(() {
        if (controller.tabController!.indexIsChanging) {
          String selectedCategory = controller
                  .allCategoriesList[controller.tabController!.index].text ??
              'All';
          controller.filterBooksByCategory(selectedCategory);
        }
      });
    }
  }

  TextEditingController searchcontroller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _iapSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    //final HomeLogic controller = Get.find();
    return Obx(
      () => PopScope(
          canPop: false,
          onPopInvoked: (didPop) {},
          child: DefaultTabController(
            length: controller.allCategoriesList.length,
            child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  notificationPredicate: (_) => false,
                  backgroundColor: AppColors.primarycolor2,
                  title: InkWell(
                    onTap: () {
                      // print(GetStorage().read('onWaybookID'));
                    },
                    child: Text(
                      'The Best Books For You!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.h,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  centerTitle: true,
                ),
                body: NestedScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          expandedHeight:
                              MediaQuery.of(context).size.height * 0.1,
                          backgroundColor: Colors.transparent,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.primarycolor2,
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Text('Search for your favorite books',
                                      //     style: TextStyle(
                                      //         color: Colors.grey,
                                      //         fontSize: 20.h,
                                      //         fontWeight: FontWeight.w300)),
                                      //!Search Field
                                      Padding(
                                        padding: EdgeInsets.only(
                                            right: 20.0, top: 10.h),
                                        child: TextFormField(
                                          onTap: () {
                                            Get.to(const SearchPage());
                                            // Get.toNamed(
                                            //     PageRoutes.searchConsultant);
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            contentPadding:
                                                const EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                            prefixIcon: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Colors.red,
                                                )
                                              ],
                                            ),
                                            hintText: "Search here",
                                            hintStyle: const TextStyle(
                                                fontSize: 14,
                                                color: Color(0xffA3A7AA)),
                                            fillColor: Colors.white,
                                            filled: true,
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.transparent)),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.white)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                borderSide: const BorderSide(
                                                    color: Colors.red)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ),
                        ),
                        controller.allCategoriesList.isNotEmpty
                            ? SliverPadding(
                                padding: const EdgeInsets.only(
                                  top: 10,
                                ),
                                sliver: SliverPersistentHeader(
                                  delegate: SliverAppBarDelegate(TabBar(
                                      physics: const BouncingScrollPhysics(),
                                      indicator: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              6), // Creates border
                                          color: Colors.grey),
                                      labelPadding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              20, 10, 10, 10),
                                      automaticIndicatorColorAdjustment: true,
                                      isScrollable: true,
                                      onTap: (value) {
                                        // debugPrint('da');
                                        // controller.tabController!.addListener(() {
                                        //   String selectedCategory = controller
                                        //       .allCategoriesList[
                                        //           controller.tabController!.index]
                                        //       .text!;
                                        //   controller.filterBooksByCategory(
                                        //       selectedCategory);
                                        // });
                                        // debugPrint(controller
                                        //     .allCategoriesList[
                                        //         controller.tabController!.index]
                                        //     .text!);
                                      },
                                      tabAlignment: TabAlignment.start,
                                      controller: controller.tabController,
                                      labelColor: Colors.white,
                                      unselectedLabelColor: Colors.grey,
                                      indicatorColor: Colors.transparent,
                                      dividerColor: Colors.transparent,
                                      tabs: controller.allCategoriesList)),
                                  pinned: true,
                                ),
                              )
                            : SliverToBoxAdapter(
                                child: SkeletonLoader(
                                    period: const Duration(seconds: 2),
                                    highlightColor: Colors.grey,
                                    direction: SkeletonDirection.ltr,
                                    builder: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                            padding: const EdgeInsetsDirectional
                                                .fromSTEB(20, 15, 10, 10),
                                            child: Container(
                                              height: 35,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.r)),
                                            )),
                                      ],
                                    ))),
                      ];
                    },
                    body: !controller.allcategoriesLoader.value
                        ? TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller.tabController,
                            children: List.generate(
                              controller.allCategoriesList.length,
                              (index) => GridView.count(
                                crossAxisCount: 3,
                                childAspectRatio: 0.5,
                                mainAxisSpacing: 20,
                                crossAxisSpacing: 15,
                                padding: const EdgeInsets.only(
                                    left: 20, right: 20, bottom: 60, top: 10),
                                children: List.generate(
                                  controller.filteredBooks.length,
                                  (itemIndex) => InkWell(
                                    //borderRadius: BorderRadius.circular(12.0),
                                    splashColor: Colors.grey,
                                    onTap: () {
                                      Get.to(BookDetails(
                                          bookModel: controller
                                              .filteredBooks[itemIndex]));
                                    },
                                    child: BookWidget(
                                      bookModel:
                                          controller.filteredBooks[itemIndex],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : ListView(
                            children: [
                              SkeletonLoader(
                                  period: const Duration(seconds: 2),
                                  highlightColor: Colors.grey,
                                  direction: SkeletonDirection.ltr,
                                  builder: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // Padding(
                                      //     padding: EdgeInsetsDirectional.fromSTEB(
                                      //         20, 10.h, 20, 0),
                                      //     child: Container(
                                      //       height: 45,
                                      //       width:
                                      //           MediaQuery.of(context).size.width,
                                      //       decoration: BoxDecoration(
                                      //           color: Colors.white,
                                      //           borderRadius:
                                      //               BorderRadius.circular(8.r)),
                                      //     )),
                                      // SizedBox(
                                      //   height: 25.h,
                                      // ),
                                      SizedBox(
                                        height: 630.h,
                                        child: ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Container(
                                                      height: 160.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Container(
                                                      height: 160.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10,
                                                        vertical: 10),
                                                    child: Container(
                                                      height: 160.h,
                                                      width: 100.w,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .primaryColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                      )
                                    ],
                                  )),
                            ],
                          ))),
          )),
    );
  }
}
