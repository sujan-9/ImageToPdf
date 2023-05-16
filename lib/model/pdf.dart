
import 'dart:io';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';



final pdfPathProvider = Provider((ref) => PdfModel().createFolder(''));

class PdfModel {

  
  String file (){
  String  name ='PDF-File${Random().nextInt(100000)}';
    return name;

  }


  Future<String> createFolder(String folderName) async {
    //Get this App Document Directory
    final Directory appDocDir = Directory("storage/emulated/0");
    //App Document Directory + folder name
    final Directory appDocDirFolder =
        Directory('${appDocDir.path}/$folderName/');
        SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('path', appDocDirFolder.path);
   

    if (await appDocDirFolder.exists()) {
      //if folder already exists return path
      return appDocDirFolder.path;
    } else {
      //if folder not exists create folder and then return its path
      final Directory appDocDirNewFolder =
          await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }}
