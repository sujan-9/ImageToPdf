

// import 'dart:io';

// import 'package:path_provider/path_provider.dart';
// import 'package:url_launcher/url_launcher.dart';
// // ignore: depend_on_referenced_packages
// import 'package:path/path.dart' as path;

// class UrlLauncherServices {
//   static Future<void> launchFile(String filePath) async {
    
//     String absolutePath = path.absolute(filePath);
//     //String encodedPath = Uri.encodeFull(absolutePath);
//     String encodedPath = Uri.encodeFull(absolutePath);

//     String url = 'file:$encodedPath';

//     // ignore: deprecated_member_use
//     if (await canLaunch(url)) {
//       // ignore: deprecated_member_use
//       await launch(url,
//          // packageName: 'com.adobe.reader',
//           forceSafariVC: false,
//           forceWebView:false,
//           headers: <String, String>{'header_key': 'header_value'}
//       );
//     } else {
//      // print('Could not launch file: $filePath');
//     }
//   }

//   static Future<String> getActualFilePath(String filePath) async {
//   File file = File(filePath);

//   if (file.existsSync()) {
//     // Get the application directory
//     Directory appDir = await getApplicationDocumentsDirectory();
//     String appPath = appDir.path;

//     // Get the file name without the extension
//     String fileName = path.basenameWithoutExtension(filePath);

//     // Get the file extension
//     String extension = path.extension(filePath);

//     // Create a new file in the application directory with the correct extension
//     File newFile = File('$appPath/$fileName$extension');

//     // Copy the file to the new location
//     await file.copy(newFile.path);

//     // Return the actual file path
//     return newFile.path;
//   }

//   return '';
// }

// }