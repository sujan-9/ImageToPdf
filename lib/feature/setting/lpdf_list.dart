import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/pdf.dart';

class PDFList extends ConsumerWidget {
  const PDFList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PdfModel path = PdfModel();
   var path1 = path.createFolder('ImageToPdfConverter').toString();
   var finename = path.file().toString();
    return  Scaffold(
      body: Center(
        child: Text('$finename.pdf'),
      )
    );
  }
}