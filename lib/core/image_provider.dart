import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/image_model.dart';



final imgNotifierProvider = StateNotifierProvider<ImgNotifier, List<ImageModel>>((ref) => ImgNotifier());

final pdfPathProvider = StateProvider<String>((ref) => '');

class ImgNotifier extends StateNotifier<List<ImageModel>> {
  ImgNotifier() : super([]);

  List<ImageModel> selectedImages = [];

  Future<void> pickImagesFromGallery() async {
 final status = await 
    Permission.storage.request();

  if (status.isGranted) {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();

      for (var pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        final name = pickedFile.name;
         
        selectedImages.add(ImageModel(file.path, name, file));
      }

      state = [...state, ...selectedImages];
    } on Exception catch (e) {
      print('Error picking images: $e');
    }
  } else if (status.isDenied){
    print('Permission denied');
  }
  else if (status.isPermanentlyDenied){
    openAppSettings();

  }
}


  //remove single image from the list
  void removeImage(ImageModel image) {
  state = state.where((img) => img.path != image.path).toList();
}

  //remove image to do
  void removeAllImages() {
     
  state = [];
}

  Future<void> createPdf() async {
    final status = await 
    Permission.storage.request();
    if (status.isGranted){
      if (state.isEmpty) {
      return;
    }

    final pdf = pw.Document();

    for (var image in state) {
      final imageFile = File(image.path);
      final bytes = imageFile.readAsBytesSync();
      final imageProvider = pw.MemoryImage(bytes);

      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.Image(imageProvider),
            );
          },
        ),
      );
    }

   // final output = await getTemporaryDirectory();
     final String dir = (await getApplicationDocumentsDirectory()).path;
    // final fileName = '${selectedImages.join(', ')}';
   // final file = File("${output!.path}/images + 'converter'.pdf");
     final file = File("$dir/images + 'converter'.pdf");
     print(file);
    
    await file.writeAsBytes(await pdf.save());
    // await HiveHelper().storePdfFile(file);
    
     
    state = [];
   
    print('PDF created at $file');

    // Do something with the PDF file, like opening it in a PDF viewer
    // or sharing it with another app
     
  }
  else if (status.isDenied){
    print('denied');
  }
  else if ( status.isPermanentlyDenied){
    openAppSettings();
  }
  }



  // Future<File?> getSavedPdf() async {
  //   return await HiveHelper().getPdfFile();
    
 // }
    }

