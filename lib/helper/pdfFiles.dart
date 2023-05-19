// ignore: file_names
import 'dart:io';


import 'package:flutter_riverpod/flutter_riverpod.dart';

final pdfProvider =
    StateNotifierProvider<PDFServices, List<String>>((ref) => PDFServices([]));

class PDFServices extends StateNotifier<List<String>> {
  PDFServices(List<String> state) : super(state);

  void getFiles() {
    String directory = "storage/emulated/0/ImageToPdfConverter";
    List<FileSystemEntity> files =
        Directory(directory).listSync(recursive: false);

    final pdfFiles = files
        .where((fileSystemEntity) =>
            fileSystemEntity.path.endsWith(".pdf") && fileSystemEntity is File)
        .map((fileSystemEntity) => fileSystemEntity.path)
        .toList();

    state = [...pdfFiles];
  }

  //renmae files

  


void renamePdf(String oldFilePath, String newFileName) {
    try {
      final oldFile = File(oldFilePath);
      final directory = oldFile.parent;
      final fileExtension = oldFile.path.split('.').last;
      final newFilePath = '${directory.path}/$newFileName.$fileExtension';
      final newFile = oldFile.renameSync(newFilePath);

      final updatedList = state.map((filePath) {
        if (filePath == oldFilePath) {
          return newFile.path;
        } else {
          return filePath;
        }
      }).toList();

      state = updatedList;

      print('PDF file renamed successfully!');
      print('New file path: ${newFile.path}');
    } catch (e) {
      print('Failed to rename PDF file: $e');
    }
  }










//delete pdf files

  void deleteFile(String filePath) {
    try {
      final file = File(filePath);
     // file.delete();
     file.deleteSync();

      state = state
          .where((path) => path != filePath)
          .toList(); // Remove the file from the state

      print('PDF file deleted successfully!');
    } catch (e) {
      print('Failed to delete PDF file: $e');
    }
  }
}
