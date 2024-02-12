import 'package:book_store/src/models/book.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../../widgets/book.dart';
import '../../widgets/bottomButton.dart';
import '../home/logic.dart';
import '../purchase/subscription.dart';

class BookDetails extends StatefulWidget {
  BookModel bookModel;
  BookDetails({super.key, required this.bookModel});

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  final controller = Get.put(HomeLogic());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
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
                        color: Colors.black,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(45),
                        )),
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width * 0.7,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(45))),
                      )),
                  Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(45),
                            )),
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.06),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 200.h,
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          widget.bookModel.thumbnailUrl),
                                      fit: BoxFit.cover,
                                    ),
                                    //color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // widget.bookModel.name,
                                      'The Book Title Name',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17.sp),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      widget.bookModel.author,
                                      style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          fontSize: 16.sp),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.35 + 10,
                    left: 45,
                    right: 45,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width -
                          50, // Adjust width as needed
                      height: MediaQuery.of(context).size.height *
                          0.3, // Adjust height as needed
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Description',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: SingleChildScrollView(
                                child: Text(
                                  widget.bookModel.description,
                                  softWrap: true,
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
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
                        color: Colors.black,
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: TextButton(
                    onPressed: () async {},
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      elevation: 5,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Subscribe to Unlock All Books',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Only \$${widget.bookModel.price}',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'We Recommend',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 220.h,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection:
                      Axis.horizontal, // Make the list horizontal scrollable
                  children: List.generate(
                    controller.allBooks.length - 1,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: InkWell(
                        //borderRadius: BorderRadius.circular(12.0),
                        splashColor: Colors.grey,
                        onTap: () {
                          setState(() {
                            widget.bookModel = controller.allBooks[index];
                          });
                          // print('object');
                          // Get.to(BookDetails(
                          //   bookModel: controller.allBooks[index],
                          // ));
                        },
                        child:
                            widget.bookModel.id == controller.allBooks[index].id
                                ? const SizedBox()
                                : BookWidget(
                                    bookModel: controller.allBooks[index],
                                  ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          )),
          Positioned(
            bottom: 15.w,
            left: 15.w,
            right: 15.w,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5.r),
                    splashColor: Colors.green,
                    onTap: () async {
                      Get.to(SubscriptionPage(
                        bookModel: widget.bookModel,
                      ));
                    },
                    child: const MyCustomBottomBar(
                      title: 'Subscribe',
                      secline: '\$2.99/Month',
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
                      // Get.to(PurchasePage(
                      //   bookModel: widget.bookModel,
                      // ));
                    },
                    child: MyCustomBottomBar(
                      title: 'Buy this book for',
                      secline: '\$${widget.bookModel.price}',
                      disable: false,
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
