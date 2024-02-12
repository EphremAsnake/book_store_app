import 'package:book_store/src/models/book.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';
import '../../widgets/bottomButton.dart';
import '../../widgets/subscriptionbutton.dart';

class SubscriptionPage extends StatefulWidget {
  final BookModel bookModel;
  const SubscriptionPage({super.key, required this.bookModel});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
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
                      child: const Center(
                          child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          'Unlock Unlimited Reading: Dive into a World of Books with our Monthly and Yearly Subscriptions!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      )))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.green,
                  onTap: () async {},
                  child: const SubscriptionButton(
                    title: '1 Month',
                    secline: '\$2.99/month',
                    disable: false,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  splashColor: Colors.green,
                  onTap: () async {},
                  child: const SubscriptionButton(
                    title: '1 Year',
                    yearpermonth: '\$1.99/month',
                    secline: '\$12.99/year',
                    disable: false,
                  ),
                ),
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
                      style: TextStyle(color: Colors.black),
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
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                  TextButton(
                    child: const Text(
                      'Terms of Service',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                  const SizedBox(),
                ],
              )
            ],
          )),
        ]));
  }
}
