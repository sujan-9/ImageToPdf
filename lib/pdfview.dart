

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewerScreen extends StatelessWidget {
  

  const PdfViewerScreen({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = "Downloads/lastdoc.pdf" ;
    return Scaffold(
      appBar: AppBar(),
      body: PDFView(
        filePath: path,
        fitEachPage: true,
        pageSnap: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        defaultPage: 0,
        // add any additional options you need
      ),
    );
  }
}
