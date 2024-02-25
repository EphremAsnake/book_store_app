import 'package:book_store/src/models/book.dart';
import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:resize/resize.dart';

import '../controller/downloadcontroller.dart';
import '../pages/view/pdfview.dart';
import 'downloadalert.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton(
      {Key? key,
      required this.title,
      required this.disable,
      required this.bookModel})
      : super(key: key);

  final String? title;
  final BookModel bookModel;
  final bool? disable;

  @override
  DownloadButtonState createState() => DownloadButtonState();
}

class DownloadButtonState extends State<DownloadButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isDownloading = false;
  bool _isCompleted = false;
  late Ticker _ticker;
  double _progress = 0.0;
  double iconSize = 200;
  double circularSize = 35.h;
  final iconColor = Colors.green;
  final circularBgColor = Colors.white;
  final circularColor = Colors.green;
  late final DownloadedBooksController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<DownloadedBooksController>();
    _ticker = Ticker((elapsed) {
      setState(() {
        _progress = _animationController.value;
      });
    });
    _ticker.start();
    _animationController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isCompleted = true;
        });
      }
    });
  }

  void _onDownloadPressed() {
    setState(() {
      _isDownloading = true;
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _ticker.stop();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.isBookDownloaded(widget.bookModel.id.toString())
            ? Get.to(BookView(
                filepath:
                    controller.getBookPath(widget.bookModel.id.toString()),
                booktitle: widget.bookModel.name))
            : DownloadAlert.show(
                context: context,
                url: widget.bookModel.pdfUrl,
                name: widget.bookModel.name,
                image: widget.bookModel.thumbnailUrl,
                id: widget.bookModel.id.toString(),
              ).then((result) {
                if (result != null) {
                  controller.addDownloadedBook(
                      widget.bookModel.id.toString(),
                      result,
                      widget.bookModel.name,
                      widget.bookModel.thumbnailUrl,
                      widget.bookModel.author,
                      widget.bookModel.locked);
                }
              });
      },
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          color: Colors.transparent,
          child: Container(
            height: 55.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppColors.primarycolor2,
                borderRadius: BorderRadius.circular(10),
                
                ),
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
                            controller.isBookDownloaded(
                                    widget.bookModel.id.toString())
                                ? Text(
                                    'Open',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16.sp,
                                        color: Colors.white),
                                  )
                                : _isDownloading
                                    ? AnimatedBuilder(
                                        animation: _animation,
                                        builder: (context, child) {
                                          return Stack(
                                            alignment: Alignment.center,
                                            children: [
                                              SizedBox(
                                                height: circularSize,
                                                width: circularSize,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 10,
                                                  color: circularColor,
                                                  backgroundColor:
                                                      circularBgColor,
                                                  value: _animation.value,
                                                ),
                                              ),
                                              Text(
                                                '${(_progress * 100).round()}%',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color:
                                                        Colors.cyan.shade600),
                                              ),
                                            ],
                                          );
                                        },
                                      )
                                    : Text(
                                        '${widget.title}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.sp,
                                            color: Colors.white),
                                      ),
                            // GestureDetector(
                            //     onTap: _onDownloadPressed,
                            //     child: Icon(
                            //       Icons.download,
                            //       size: iconSize,
                            //       color: iconColor,
                            //     )),
                            // Text(
                            //   '${widget.title}',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 16.sp,
                            //       color: Colors.white),
                            // ),
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
      ),
    );
  }
}
