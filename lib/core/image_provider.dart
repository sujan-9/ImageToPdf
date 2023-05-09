import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../model/image_model.dart';
import '../model/pdf.dart';



final imgNotifierProvider = StateNotifierProvider<ImgNotifier, List<ImageModel>>((ref) => ImgNotifier());

//final pdfPathProvider = StateProvider<String>((ref) => '');

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
      throw('Error picking images: $e');
    }
  } else if (status.isDenied){
    throw('Permission denied');
  }
  else if (status.isPermanentlyDenied){
    openAppSettings();

  }
}


  //remove single image from the list
  void removeImage(ImageModel image) {
    
  state = state.where((img) => img.path != image.path).toList();
  selectedImages.remove(image);
  
}

  //remove image to do
  void removeAllImages() {
     
  state = [];
}

void reorderImages(int oldIndex, int newIndex) {
  if (oldIndex < newIndex) {
    newIndex -= 1;
  }

  final ImageModel item = state.removeAt(oldIndex);
  state.insert(newIndex, item);
}


  Future<void> createPdf() async {
    PdfModel  path = PdfModel();
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
    
    var fileName = path.file();
     var createPath = await path.createFolder("ImageToPdfConverter");
     File savePath = File("$createPath$fileName.pdf");
    
    
    await savePath.writeAsBytes(await pdf.save());
  

  // var _createPath = await _createFolder("ImageToPdfConverter");
  //   File _savePath = File(_createPath + "$fileName.pdf");
  //   final pdfSaveByte = await pdf.save();
  //   final savePDFfile = _savePath.writeAsBytes(pdfSaveByte);
  //  return savePDFfile;
    
     
    state = [];
   
    

    // Do something with the PDF file, like opening it in a PDF viewer
    // or sharing it with another app
     
  }
  else if (status.isDenied){
    throw('denied');
  }
  else if ( status.isPermanentlyDenied){
    openAppSettings();
  }
  }



  

//  Future<String> _createFolder(String folderName) async {
//     //Get this App Document Directory
//     final Directory appDocDir = Directory("storage/emulated/0");
//     //App Document Directory + folder name
//     final Directory appDocDirFolder =
//         Directory('${appDocDir.path}/$folderName/');

//     if (await appDocDirFolder.exists()) {
//       //if folder already exists return path
//       return appDocDirFolder.path;
//     } else {
//       //if folder not exists create folder and then return its path
//       final Directory appDocDirNewFolder =
//           await appDocDirFolder.create(recursive: true);
//       return appDocDirNewFolder.path;
//     }
//   }


// Future<String> _createFolder(String folderName) async {
//   // Request permission
//   final status = await Permission.manageExternalStorage.request();
//   if (!status.isGranted) {
//     throw Exception('Permission denied');
//   }

//   // Get app document directory
//   final Directory appDocDir = Directory("storage/emulated/0");

//   // Combine app document directory path with folder name
//   final Directory appDocDirFolder = Directory('${appDocDir.path}/$folderName/');

//   // If the folder doesn't exist, create it
//   if (!await appDocDirFolder.exists()) {
//     try {
//       await appDocDirFolder.create(recursive: true);
//     } catch (e) {
//       throw Exception('Failed to create folder: $e');
//     }
//   }

//   // Return the path to the folder
//   return appDocDirFolder.path;
// }

    }

