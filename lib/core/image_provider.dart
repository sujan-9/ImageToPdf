import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';


import '../model/image_model.dart';
import '../model/pdf.dart';



final imgNotifierProvider = StateNotifierProvider<ImgNotifier, List<ImageModel>>((ref) => ImgNotifier());
// final imgNotifierProvider = StateNotifierProvider.autoDispose<ImgNotifier,List<ImageModel>>((ref) {
//   return ImgNotifier();
// });


//final pdfPathProvider = StateProvider<String>((ref) => '');

class ImgNotifier extends StateNotifier<List<ImageModel>> {
  ImgNotifier() : super([]);

  List<ImageModel> selectedImages = [];
  

  // Future<void> pickImagesFromCamera()async {
  //   final status = await Permission.camera.request();

  // if (status.isGranted) {
  //   try {
  //     final pickedFile = await ImagePicker().pickImage
  //     (source: ImageSource.camera,
  //     imageQuality: 100,
  //     preferredCameraDevice: CameraDevice.rear,
  //     );

  //     if (pickedFile != null) {
  //       final file = File(pickedFile.path);
  //       final name = pickedFile.name;
  //       selectedImages.add(ImageModel(file.path, name, file));
        
  //     }

  //     state = [...state, ...selectedImages];
      
  //   } on Exception catch (e) {
  //     throw('Error picking images: $e');
  //   }
  // } else if (status.isDenied){
  //   throw('Permission denied');
  // }
  // else if (status.isPermanentlyDenied){
  //   openAppSettings();

  // }

  // }



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


//add images with floating button

void addImages() async {
  try {
    // Pick images from gallery using ImagePicker
    final pickedFiles = await ImagePicker().pickMultiImage();

    for (var pickedFile in pickedFiles) {
      final file = File(pickedFile.path);
      final name = pickedFile.name;

      // Create an ImageModel object and add it to the state
      final image = ImageModel(file.path, name, file);
      state = [...state, image];
    }
  } catch (e) {
    print('Error picking images: $e');
  }
}


  //remove single image from the list
  void removeImage(ImageModel image) {
    
  state = state.where((img) => img.path != image.path).toList();
  selectedImages.remove(image);
  
}

  //remove image all images 
  void removeAllImages() {
    state = [];
    selectedImages.clear();
     
 
}

//manage order of images
void reorderImages(int oldIndex, int newIndex) {
  if (oldIndex < newIndex) {
    newIndex -= 1;
  }

  final ImageModel item = state.removeAt(oldIndex);
  state.insert(newIndex, item);
  state = [...state];
}




  Future<void> createPdf(
   // String fileName,
  ) async {
    PdfModel  path = PdfModel();
    final status = await 
    Permission.storage.request();
    // BuildContext context;
    // WidgetRef ref = this.context;
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
   // WidgetRef ref = this.context;
    //String fileName = ref.watch(nameProvider);
     var createPath = await path.createFolder("ImageToPdfConverter");
     File savePath = File("$createPath$fileName.pdf");
     //print(savePath);
    
   
    
    await savePath.writeAsBytes(await pdf.save());
  

  
    
     
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



  // reorderImage(int oldIndex, int newIndex) {
  //   if (oldIndex < 0 || oldIndex >= selectedImages.length || newIndex < 0 || newIndex >= selectedImages.length) {
  //     return; // Invalid indices, do nothing
  //   }

  //   // final image = selectedImages.removeAt(oldIndex);
  //   // selectedImages.insert(newIndex, image);

  //   final newimage = state.removeAt(oldIndex);
  //   state.insert(newIndex, newimage);
  //   return state;
  // }
    }

 