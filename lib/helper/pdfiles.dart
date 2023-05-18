import 'dart:io';

class FilesHelper {
  void deleteFile(String filePath) {
  final file = File(filePath);

  file.deleteSync();

  // Perform any additional actions after deleting the file, if necessary

  // Optionally, you can update the UI or notify listeners about the file deletion
}



}