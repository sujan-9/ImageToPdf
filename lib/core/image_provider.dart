import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import '../helper/folderser.dart';
import '../helper/imageCompress.dart';
import '../model/image_model.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

final imgNotifierProvider =
    StateNotifierProvider<ImgNotifier, List<ImageModel>>(
  (ref) => ImgNotifier(),
);

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

          // final compressedFile = await compressCameraImage(file);
           final compressedFile = await compressFile(file: file);
          selectedImages
              .add(ImageModel(compressedFile.path, name, compressedFile));
          

          // selectedImages.add(ImageModel(file.path, name, file));
        }

        state = [...state, ...selectedImages];
        selectedImages.clear();
      } catch (e) {
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
          final compressImage = await compressGalleryImages(file, name);
          selectedImages
              .add(ImageModel(compressImage, name, File(compressImage)));

          // selectedImages.add(ImageModel(file.path, name, file));
        }

        state = [...state, ...selectedImages];
        selectedImages.clear();
      } catch (e) {
        throw ('Error picking images: $e');
      }
    } else if (status.isDenied) {
      throw ('Permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  void addImages() async {
    try {
      final pickedFiles = await ImagePicker().pickMultiImage();

      for (var pickedFile in pickedFiles) {
        final file = File(pickedFile.path);
        final name = pickedFile.name;

        final compressImage = await compressGalleryImages(file, name);
        selectedImages
            .add(ImageModel(compressImage, name, File(compressImage)));

        // final image = ImageModel(file.path, name, file);
        // selectedImages.add(image);
      }

      state = [...state, ...selectedImages];
      selectedImages.clear();
    } catch (e) {
      throw ('Error picking images: $e');
    }
  }

  void addFromCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear,
      );

      if (pickedFile != null) {
        final file = File(pickedFile.path);
        final name = pickedFile.name;


        // final image = ImageModel(file.path, name, file);
        // selectedImages.add(image);

         //compressing images
         final compressedFile = await compressFile(file: file);
          selectedImages
              .add(ImageModel(compressedFile.path, name, compressedFile));
        state = [...state, ...selectedImages];
        selectedImages.clear();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void removeImage(ImageModel image) {
    state = state.where((img) => img.path != image.path).toList();
    selectedImages.remove(image);
  }

  void removeAllImages() {
    state = [];
    selectedImages.clear();
  }

  void reorderImages(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final ImageModel item = state.removeAt(oldIndex);
    state.insert(newIndex, item);
    state = [...state];
  }

  Future<void> createPdf() async {
    PdfModel path = PdfModel();
    final status = await Permission.storage.request();

    if (status.isGranted) {
      if (state.isEmpty) {
        return;
      }

      final pdf = pw.Document();

      for (var image in state) {
        final imageFile = File(image.path);

        //for file compression to do

        final bytes = await imageFile.readAsBytes();
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
      throw ('Permission denied');
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }
}
