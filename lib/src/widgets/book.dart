import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../models/book.dart';
import '../pages/navigations/home/logic.dart';

class BookWidget extends StatefulWidget {
  final BookModel bookModel;
  const BookWidget({
    super.key,
    required this.bookModel,
  });

  @override
  State<BookWidget> createState() => _BookWidgetState();
}

class _BookWidgetState extends State<BookWidget> {
 final HomeLogic homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      width: 150.w,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:
                      CachedNetworkImageProvider(widget.bookModel.thumbnailUrl),
                  fit: BoxFit.contain,
                ),
                //color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              // child: Text(
              //   controller
              //       .allCategoriesList[
              //           itemIndex]
              //       .text!,
              //   style: TextStyle(
              //       color: Colors.white),
              // ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(widget.bookModel.name,
          textAlign: TextAlign.center,
              style:  TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,fontSize: 12.sp)),
          Text('\$${homeController.getPriceByName(widget.bookModel.pricecategories)}',
              style: const TextStyle(color: Colors.black))
        ],
      ),
    );
  }
}
