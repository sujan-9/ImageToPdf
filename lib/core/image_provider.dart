import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart' as img;

import 'package:image_picker/image_picker.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helper/folderser.dart';
import '../helper/imageCompress.dart';
import '../model/image_model.dart';


final imgNotifierProvider =
    StateNotifierProvider<ImgNotifier, List<ImageModel>>(
        (ref) => ImgNotifier());
// final imgNotifierProvider = StateNotifierProvider.autoDispose<ImgNotifier,List<ImageModel>>((ref) {
//   return ImgNotifier();
// });

//final pdfPathProvider = StateProvider<String>((ref) => '');

class ImgNotifier extends StateNotifier<List<ImageModel>> {
  ImgNotifier() : super([]);

  List<ImageModel> selectedImages = [];

  Future<void> pickImagesFromCamera() async {
    final status = await Permission.camera.request();

    if (status.isGranted) {
      try {
        final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
          preferredCameraDevice: CameraDevice.rear,
        );

        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final name = pickedFile.name;
          final compressedFile = await compressFile(file: file);
          selectedImages.add(ImageModel(compressedFile.path, name, compressedFile));
        }

        state = [...state, ...selectedImages];
      } on Exception catch (e) {
        throw ('Error picking images: $e');
      }
    } else if (status.isDenied) {
      throw ('Permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> pickImagesFromGallery() async {
    final status = await Permission.storage.request();

    if (status.isGranted) {
      try {
        final pickedFiles = await ImagePicker().pickMultiImage();

        for (var pickedFile in pickedFiles) {
          final file = File(pickedFile.path);
          final name = pickedFile.name;
        // testCompressAndGetFile(file, file.path);
         final compressedFile = await compressFile(file: file);

          selectedImages.add(ImageModel(compressedFile.path, name, compressedFile));
        }

        state = [...state, ...selectedImages];
      } on Exception catch (e) {
        throw ('Error picking images: $e');
      }
    } else if (status.isDenied) {
      throw ('Permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

//add images with floating button from gallery

  void addImages() async {
    try {
      // Pick images from gallery using ImagePicker
      final pickedFiles = await ImagePicker().pickMultiImage();

      for (var pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        final name = pickedFile.name;
        //testCompressAndGetFile(file, file.path);
         final compressedFile = await compressFile(file: file);

        // Create an ImageModel object and add it to the state
        final image = ImageModel(compressedFile.path, name, compressedFile);
        state = [...state, image];
      }
    } catch (e) {
      throw ('Error picking images: $e');
    }
  }


  //add images from camera

 void addFromCamera ()async{
  try{
      final pickedFile = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 100,
          preferredCameraDevice: CameraDevice.rear,
        );

        if (pickedFile != null) {
          final file = File(pickedFile.path);
          final name = pickedFile.name;
          final compressedFile = await compressFile(file: file);

           final image = ImageModel(compressedFile.path, name, compressedFile);
        state = [...state, image];
        
        }
      
       

  }
  catch(e){
   print(e.toString());
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

  //compress file
  Future<File> compressImage(XFile imageFile, int quality) async {
  final file = File(imageFile.path);
  final bytes = await file.readAsBytes();

  final image = img.decodeImage(bytes);
  final compressedImage = img.encodeJpg(image!, quality: quality);
  //final compressedImage = img.encodeJpg(compressedImg!);


  final compressedFile = File('${file.path}_compressed.jpg');
  await compressedFile.writeAsBytes(compressedImage);

  return compressedFile;
}


  Future<void> createPdf(
      // String fileName,
      ) async {
    PdfModel path = PdfModel();
    final status = await Permission.storage.request();
    // BuildContext context;
    // WidgetRef ref = this.context;
    if (status.isGranted) {
      if (state.isEmpty) {
        return;
      }

      final pdf = pw.Document();

      for (var image in state) {
        // final imageFile = File(image.path);
        // final bytes = imageFile.readAsBytesSync();
         final compressedImage = await compressImage (XFile(image.path), 50);
         final bytes = compressedImage.readAsBytesSync();
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

      state = [];

      
    } else if (status.isDenied) {
      throw ('denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

}
