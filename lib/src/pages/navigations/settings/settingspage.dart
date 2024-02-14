import 'dart:io';

import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../controller/appconfigs.dart';
import '../../../controller/downloadcontroller.dart';
import '../../../widgets/downloadeditem.dart';
import '../../../widgets/downloadsgroup.dart';
import '../../view/pdfview.dart';
import 'components/babstrap_settings_screen.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final PageController _pageController = PageController(initialPage: 1);
  late List<DownloadedBook> downloadedBooks;
  final bookDownloaderController = Get.put(DownloadedBooksController());
  final appconfigsController = Get.put(AppConfigController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    downloadedBooks = bookDownloaderController.getAllDownloadedBooks();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        _pageController.animateToPage(1,
            duration: const Duration(milliseconds: 500), curve: Curves.ease);
      },
      child: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        // image: const DecorationImage(
                        //     alignment: Alignment.topCenter,
                        //     fit: BoxFit.cover,
                        //     image: AssetImage(
                        //       'assets/images/back2.jpg',
                        //     ))
                      ),
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  MediaQuery.of(context).size.height * 0.08),
                          child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.1,
                              child:
                                  Image.asset("assets/images/splashlogo.png")),
                        ),
                      ),
                      // child: Padding(
                      //   padding: EdgeInsets.only(top: 0),
                      //   child: SmallUserCard(
                      //       cardColor: AppColors.primaryColor.withOpacity(0.8),
                      //       userName: "User Name",
                      //       userProfilePic:
                      //           const AssetImage("assets/images/splash_logo.png"),
                      //       onTap: () {}),

                      // ),
                    )),
                Positioned(
                    top: MediaQuery.of(context).size.height * 0.2,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: PageView(
                          controller: _pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50))),
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: ListView(
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _pageController.animateToPage(
                                                      1,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease);
                                                },
                                                child: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'About',
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox()
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            Platform.isAndroid? appconfigsController
                                                    .appConfig
                                                    .value
                                                    ?.androidSettings
                                                    .aboutApp ??
                                                'Loading...':appconfigsController
                                                    .appConfig
                                                    .value
                                                    ?.iosSettings
                                                    .aboutApp ??
                                                'Loading...',
                                          ),
                                          const SizedBox(
                                            height: 50,
                                          )
                                        ],
                                      ),
                                    ))),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50))),
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: ListView(
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          SettingsGroup(
                                            items: [
                                              SettingsItem(
                                                onTap: () {},
                                                icons:
                                                    CupertinoIcons.heart_fill,
                                                iconStyle: IconStyle(
                                                    backgroundColor:
                                                        Colors.pink),
                                                title: 'Favorites',
                                                subtitle: "Your Favorite Books",
                                              ),
                                              SettingsItem(
                                                onTap: () {
                                                  _pageController.animateToPage(
                                                      2,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease);
                                                },
                                                icons: Icons
                                                    .file_download_outlined,
                                                iconStyle: IconStyle(
                                                  backgroundColor: Colors.green,
                                                ),
                                                title: 'Downloads',
                                                subtitle:
                                                    "books you downloaded",
                                              ),
                                              SettingsItem(
                                                onTap: () {
                                                  _launchURL(Platform.isAndroid
                                                      ? appconfigsController
                                                          .appConfig
                                                          .value!
                                                          .androidSettings
                                                          .subscriptionSettings
                                                          .termOfUseUrl
                                                      : appconfigsController
                                                          .appConfig
                                                          .value!
                                                          .iosSettings
                                                          .subscriptionSettings
                                                          .termOfUseUrl);
                                                },
                                                icons: CupertinoIcons
                                                    .profile_circled,
                                                iconStyle: IconStyle(
                                                    backgroundColor:
                                                        Colors.orange),
                                                title: 'Terms and Conditions',
                                                subtitleMaxLine: 1,
                                                subtitle:
                                                    "Terms and Conditions while using TenaFirst Pharma",
                                              ),
                                              SettingsItem(
                                                onTap: () {
                                                  _launchURL(Platform.isAndroid
                                                      ? appconfigsController
                                                          .appConfig
                                                          .value!
                                                          .androidSettings
                                                          .subscriptionSettings
                                                          .privacyPolicyUrl
                                                      : appconfigsController
                                                          .appConfig
                                                          .value!
                                                          .iosSettings
                                                          .subscriptionSettings
                                                          .privacyPolicyUrl);
                                                },
                                                icons: Icons.privacy_tip,
                                                iconStyle: IconStyle(
                                                  backgroundColor:
                                                      Colors.purple,
                                                ),
                                                title: 'Privacy Policy',
                                                subtitle: "Privacy Policy",
                                              ),
                                              SettingsItem(
                                                onTap: () {
                                                  _pageController.animateToPage(
                                                      0,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease);
                                                },
                                                icons: Icons.info_rounded,
                                                iconStyle: IconStyle(
                                                  backgroundColor:
                                                      Colors.blueGrey,
                                                ),
                                                title: 'About',
                                                subtitle: "About Us",
                                              ),
                                            ],
                                          ),
                                          // You can add a settings title

                                          const SizedBox(
                                            height: 50,
                                          )
                                        ],
                                      ),
                                    ))),
                            Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50))),
                                child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20.h),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 10, 10),
                                      child: ListView(
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  _pageController.animateToPage(
                                                      1,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.ease);
                                                },
                                                child: const Icon(
                                                  Icons.arrow_back,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Text(
                                                'DownLoads',
                                                style: TextStyle(
                                                    fontSize: 18.sp,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox()
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount: downloadedBooks.length,
                                              itemBuilder: (context, index) {
                                                DownloadedBook book =
                                                    downloadedBooks[index];
                                                return DownloadsGroup(
                                                  items: [
                                                    DownloadedItem(
                                                      onTap: () {
                                                        Get.to(BookView(
                                                            filepath: book.path,
                                                            booktitle:
                                                                book.name));
                                                      },
                                                      title: book.name,
                                                      author: book.author,
                                                      imageUrl:
                                                          book.thumbnailUrl,
                                                    ),
                                                  ],
                                                );
                                              }),
                                          // DownloadsGroup(
                                          //   items: [
                                          //     DownloadedItem(
                                          //       onTap: () {},
                                          //       title: downloadedBooks.length.toString(),
                                          //       author: "Your Favorite Books",
                                          //       imageUrl:
                                          //           'https://marketplace.canva.com/EAFPHUaBrFc/1/0/1003w/canva-black-and-white-modern-alone-story-book-cover-QHBKwQnsgzs.jpg',
                                          //     ),
                                          //     DownloadedItem(
                                          //       onTap: () {},
                                          //       title: 'Favorites',
                                          //       author: "Your Favorite Books",
                                          //       imageUrl:
                                          //           'https://marketplace.canva.com/EAFPHUaBrFc/1/0/1003w/canva-black-and-white-modern-alone-story-book-cover-QHBKwQnsgzs.jpg',
                                          //     ),
                                          //   ],
                                          // ),
                                          // You can add a settings title

                                          const SizedBox(
                                            height: 50,
                                          )
                                        ],
                                      ),
                                    ))),
                          ],
                        )))
              ]))
        ]),
      ),
    );
  }

  Future<void> _launchURL(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
}
