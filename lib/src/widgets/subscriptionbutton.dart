import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class SubscriptionButton extends StatefulWidget {
  const SubscriptionButton(
      {Key? key, required this.title, required this.disable, this.secline, this.yearpermonth})
      : super(key: key);

  final String? title;
  final String? secline;
  final String? yearpermonth;
  final bool? disable;

  @override
  SubscriptionButtonState createState() => SubscriptionButtonState();
}

class SubscriptionButtonState extends State<SubscriptionButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Container(
          height: 55.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    spreadRadius: -18,
                    blurRadius: 30,
                    offset: const Offset(30, 0))
              ]),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${widget.title}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                        color: Colors.white),
                  ),
                  if (widget.secline != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${widget.secline}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Colors.white),
                        ),
                        if (widget.yearpermonth != null)
                        Text(
                          '${widget.yearpermonth}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.sp,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
