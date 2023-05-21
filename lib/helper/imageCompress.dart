// import 'dart:io';

// import 'package:flutter_image_compress/flutter_image_compress.dart';




//   Future<File> compressFile({required File? file}) async {
//   if (file == null) {
//     throw ArgumentError('File must not be null');
//   }

//   final filePath = file.path;

//   // Create output file path
//   // eg:- "Volume/VM/abcd_out.jpeg"
//   // print(filePath);
//   // final lastIndex = filePath.lastIndexOf(RegExp(r'.jpg|.jpeg|.png'));
//   // print(lastIndex);
//   // final splitted = filePath.substring(0, lastIndex);
//   // print(splitted);
//   // final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
//   // print(outPath);

//   final result = await FlutterImageCompress.compressAndGetFile(
//     file.path,
//     file.path,
//     quality: 70,
//   );
// print(result);
//   if (result == null) {
//     throw Exception('Failed to compress image');
//   }

//    File filepath = File(result.path);
//    print(filepath);
//      return filepath;
// }