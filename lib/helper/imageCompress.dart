import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';





//compress images function for images taken from camera
 Future<File> compressFile({required File? file}) async {
      final filePath = file!.path;
    
      // Create output file path
      // eg:- "Volume/VM/abcd_out.jpeg"
      final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
      final splitted = filePath.substring(0, (lastIndex));
      final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
      var result = await FlutterImageCompress.compressAndGetFile(
        file.path,
        outPath,
        quality: 80,
      );
      final compfile =File(result!.path);
      return compfile;
    }


 //compress images function for images taken from gallery
    Future<String> compressGalleryImages(File file, String name) async {
  final directory = await getTemporaryDirectory();
  final targetPath = "${directory.path}/$name";

  final compressedFile = await FlutterImageCompress.compressAndGetFile(
    file.path,
    targetPath,
    quality: 80, // Adjust the quality value as desired
  );

  return compressedFile?.path ?? '';
}