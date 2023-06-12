




import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class Cropper{

Future<File> cropImage(
 File pickedFile,
) async {
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
       // compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.red,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false),
          // IOSUiSettings(
          //   title: 'Cropper',
          // ),
         
        ],
      );
      if(croppedFile!=null){
        File file = File(croppedFile.path);
      return file;
      }
      else{
        return pickedFile;
      }
     
     
      }
      
      else{
        return pickedFile;
      }
    }
}
  
