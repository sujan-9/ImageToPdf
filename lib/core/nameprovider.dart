// //  import 'dart:io';

// // import 'package:flutter/material.dart';
//  import 'package:flutter_riverpod/flutter_riverpod.dart';

// // // class NameStateNotifier extends StateNotifier<String> {
// // //   NameStateNotifier() : super('sujan');

// // //   set state(String value) {
// // //     state = value;
// // //   }
// // // }

// //  final nameProvider = StateProvider((ref) {
// //   String directory = ("storage/emulated/0/ImageToPdfConverter");
// //    Future<void> renameFile( String newName) async {
// //   final file = File(directory);

// //   if (await file.exists()) {
// //     final directory = file.parent;
// //     final newPath = '${directory.path}/$newName';
// //     await file.rename(newPath);
// //   } else {
// //     throw Exception('File does not exist');
// //   }
// // }
   

// //  });


// final renameFileSProvider = StateNotifierProvider<FileNameNotifier,String>((ref) => FileNameNotifier());

// class FileNameNotifier extends StateNotifier<String> {
//   FileNameNotifier() : super('');

//   void updateFileName(String value) {
//     state = value;

    
//   }
// }