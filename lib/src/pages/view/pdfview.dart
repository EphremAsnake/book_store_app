import 'dart:io';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookView extends StatelessWidget {
  final String filepath;
  final String booktitle;
  const BookView({Key? key, required this.filepath, required this.booktitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title:  Text(booktitle)),
        body: SfPdfViewer.file(
            enableTextSelection: false,
            scrollDirection: PdfScrollDirection.horizontal,
            pageLayoutMode: PdfPageLayoutMode.single,
            File(filepath)));
  }
}
