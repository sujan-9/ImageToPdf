import 'dart:io';

import 'package:share_plus/share_plus.dart';





 void sharePDFFile(String filePath, ) {
  String subject = 'Sharing PDF file';
  final file = File(filePath);
  if (file.existsSync()) {
   // final bytes = file.readAsBytesSync();
    Share.shareFiles([filePath],
        subject: subject,
        mimeTypes: ['application/pdf'],
        text: 'Sharing PDF file');
  } else {
    print('File not found: $filePath');
  }
}