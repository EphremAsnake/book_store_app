import 'dart:io';

import 'package:book_store/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookView extends StatelessWidget {
  final String filepath;
  final String booktitle;
  const BookView({Key? key, required this.filepath, required this.booktitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primarycolor2,
        appBar: AppBar(
            backgroundColor: AppColors.primarycolor2,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              booktitle,
              style: TextStyle(color: Colors.white),
            )),
        body: SfPdfViewer.file(
            enableTextSelection: false,
            scrollDirection: PdfScrollDirection.horizontal,
            pageLayoutMode: PdfPageLayoutMode.single,
            File(filepath)));
  }
}
