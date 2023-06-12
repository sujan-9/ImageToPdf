import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../helper/folderser.dart';

class PdfPaths extends StateNotifier<String> {
  PdfPaths( state) :  super(state);

  Future<void> getPath() async {
    PdfModel pdfModel = PdfModel();
    String path = "storage/emulated/0/ImageToPdf/";
    String pdfPath = path + pdfModel.file();
    state = pdfPath;
  //  state = [...pdfPath] as String;
  }
}

String getpath() {
  PdfModel pdfModel = PdfModel();
  String path = "storage/emulated/0/ImageToPdf/";
  String pdfPath = path + pdfModel.file();
  return pdfPath;
}
final pdfpathProvider =
    StateNotifierProvider<PdfPaths, String>((ref) => PdfPaths([]));