



import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import 'model/pdf.dart';

//to be implemented;

class PdfViewerScreen extends StatelessWidget {
 

  const PdfViewerScreen({Key? key}) : super(key: key);

 

  @override
  Widget build(BuildContext context) {
   PdfModel path = PdfModel();
   var path1 = path.createFolder('ImageToPdfConverter').toString();
   var finename = path.file().toString();
   //print('$path1$finename.pdf');
   
    
    
    return Scaffold(
      appBar: AppBar(title: Text('$path1$finename.pdf'),),
      body: PDFView(
        filePath:  path1,
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
