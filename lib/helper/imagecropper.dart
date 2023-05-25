




// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';

// Future<File> cropImage(
//  File pickedFile,
// ) async {
//     if (pickedFile != null) {
//       final croppedFile = await ImageCropper().cropImage(
//         sourcePath: pickedFile.path,
//        // compressFormat: ImageCompressFormat.jpg,
//         compressQuality: 100,
//         uiSettings: [
//           AndroidUiSettings(
//               toolbarTitle: 'Cropper',
//               toolbarColor: Colors.deepOrange,
//               toolbarWidgetColor: Colors.white,
//               initAspectRatio: CropAspectRatioPreset.original,
//               lockAspectRatio: false),
//           IOSUiSettings(
//             title: 'Cropper',
//           ),
         
//         ],
//       );
//       return croppedFile as File;
     
//       }
      
//       else{
//         return pickedFile;
//       }
//     }
  
