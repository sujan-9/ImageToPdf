import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';




  Future<File> compressFile({required File? file}) async {
  if (file == null) {
    throw ArgumentError('File must not be null');
  }

  final filePath = file.path;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
  final splitted = filePath.substring(0, lastIndex);
  final outPath = '${splitted}_out${filePath.substring(lastIndex)}';

  final result = await FlutterImageCompress.compressAndGetFile(
    file.path,
    outPath,
    quality: 70,
  );

  if (result == null) {
    throw Exception('Failed to compress image');
  }

   File filepath = File(result.path);
     return filepath;
}