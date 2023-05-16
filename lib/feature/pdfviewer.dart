import 'package:flutter/material.dart';

class PDFViewer extends StatelessWidget {
  final String path;
  PDFViewer({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(

      child: PDFViewer(
       
         path: path,
        ),
    );
  }
}