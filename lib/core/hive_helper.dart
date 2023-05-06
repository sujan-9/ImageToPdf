import 'dart:io';

import 'package:hive/hive.dart';


class HiveHelper {
  static const String _boxName = 'pdf';

  Future<Box> _openBox() async {
    //final directory = await getApplicationDocumentsDirectory();
    //Hive.init(directory.path);
    return await Hive.openBox(_boxName);
  }

  Future<void> storePdfFile(File pdfFile) async {
    final box = await _openBox();
    await box.put('pdf', pdfFile.path);
  }
  

  Future<File?> getPdfFile() async {
    final box = await _openBox();
    final pdfPath = box.get('pdf');
  
    if (pdfPath == null) {

      return null;
    }
    return File(pdfPath);
  }
}
