 //import 'dart:io';

// import 'package:riverpod/riverpod.dart';




// class ImgNotifier extends StateNotifier<List<ImageModel>> {
//   ImgNotifier() : super([]);

//   List<ImageModel> selectedImages = [];
//   void pickImagesFromGallery() async {
//   try {
//       final pickedFiles = await ImagePicker().pickMultiImage();
//       if (pickedFiles != null) {
//         for (var pickedFile in pickedFiles) {
//           final file = File(pickedFile.path);
//           selectedImages.add();
//         }
//       }
//     } on Exception catch (e) {
//       // Handle any errors that may occur during image picking
//      // print('Error picking images: $e');
//     }

// }
// }





import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/image_model.dart';



final imgNotifierProvider = StateNotifierProvider<ImgNotifier, List<ImageModel>>((ref) => ImgNotifier());

class ImgNotifier extends StateNotifier<List<ImageModel>> {
  ImgNotifier() : super([]);

  List<ImageModel> selectedImages = [];
  

  Future<void> pickImagesFromGallery() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();
      // if (pickedFiles != null) {
        for (var pickedFile in pickedFiles) {
          final file = File(pickedFile.path);
          final name = pickedFile.name;
         
          
          selectedImages.add(ImageModel(file.path, name, file));
        }
        //state = List.from(selectedImages);
        state = [...state, ...selectedImages];
      // selectedImages.clear(); 
       
      // }
    } on Exception catch (e) {
      print('Error picking images: $e');
    }
   //  state = [...state, ...selectedImages];
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

    final output = await getLibraryDirectory();
    final file = File("${output.path}/images + $selectedImages.pdf");
    await file.writeAsBytes(await pdf.save());

    state = [];
    print('PDF created at $file');

    // Do something with the PDF file, like opening it in a PDF viewer
    // or sharing it with another app
  }
}
