
import 'dart:io';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



final pdfPathProvider = Provider((ref) => PdfModel().createFolder(''));
final filenameProvider = StateProvider<String>((ref) => PdfModel().file());
//final renameFileProvider = StateProvider<String>((ref) => '');

  

class PdfModel {

  
 
  String file (){
   // DateTime now = DateTime.now();
//String  name ='PDF-File${now.hour}:${now.minute}:${now.second}}';
 DateTime now = DateTime.now();
    String time = DateFormat('hh_mm_ss').format(now);
    String name = 'PDF-File$time';
// String name = 'PDF-File${Random().nextInt(100)}';

    return name;

  }

// String pdffile(){

// }
  

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
