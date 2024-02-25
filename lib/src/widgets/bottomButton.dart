import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:resize/resize.dart';

class MyCustomBottomBar extends StatefulWidget {
  const MyCustomBottomBar(
      {Key? key,
      required this.title,
      this.first,
      required this.disable,
      this.secline})
      : super(key: key);

  final String? title;
  final String? secline;
  final bool? disable;
  final bool? first;

  @override
  MyCustomBottomBarState createState() => MyCustomBottomBarState();
}

class MyCustomBottomBarState extends State<MyCustomBottomBar> {
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
              color:
                  widget.first != null ? Colors.white : AppColors.primarycolor2,
              borderRadius: BorderRadius.circular(10),
              border: widget.first != null
                  ? Border.all(width: 2, color: AppColors.primarycolor2)
                  : null,
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(0.7),
                    spreadRadius: -18,
                    blurRadius: 30,
                    offset: const Offset(30, 0))
              ]),
          child: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${widget.title}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                                color: widget.first != null
                                    ? AppColors.primarycolor2
                                    : Colors.white),
                          ),
                          if (widget.secline != null)
                            Text(
                              '${widget.secline}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.sp,
                                  color: Colors.green),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              widget.disable!
                  ? Container(
                      color: Colors.white.withOpacity(0.5),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
