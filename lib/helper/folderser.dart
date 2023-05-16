import 'dart:io' as io;
import 'package:path/path.dart' as path;

class FileServices {
  /// It returns a list of all the files in the folder
  ///
  /// Args:
  ///   folderName (String): The name of the folder where the PDF files are stored.
  ///
  /// Returns:
  ///   A list of FileSystemEntity objects.
  Future<List<io.FileSystemEntity>> getAllPdfFile(String folderName) async {
    final file = io.Directory("storage/emulated/0/$folderName").listSync();

    return file;
  }

  /// It deletes the directory and all its contents.
  ///
  /// Args:
  ///   deleteFilePath (String): The path of the directory you want to delete.

  deleteDir(String deleteFilePath) {
    final dir = io.Directory(deleteFilePath);
    dir.deleteSync(recursive: true);
  }

  /// It takes a file and a new filename, and renames the file to the new filename
  ///
  /// Args:
  ///   originalFile (io): The file you want to rename.
  ///   newFilename (String): The new name of the file
  renameDir(io.File originalFile, String newFilename) {
    String dir = path.dirname(originalFile.path);
    String newPath = path.join(dir, "$newFilename.pdf");
    originalFile.renameSync(newPath);
  }
}
