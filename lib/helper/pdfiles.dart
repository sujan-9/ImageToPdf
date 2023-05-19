// // import 'dart:io';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:imagetopdf/helper/pdfFiles.dart';

// final renameDialogStateProvider = StateProvider<String>((ref) => '');

// class RenameFileDialog extends ConsumerWidget {
//   final String filePath;

//   const RenameFileDialog({required this.filePath});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final height = MediaQuery.of(context).size.height;
//    // final weidth = MediaQuery.of(context).size.width;
//     final nameController = TextEditingController();
    

//     return SizedBox(
//       height: height * 0.3,
//       child: AlertDialog(
//         title: const Text(
//           'Rename File',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//         content: TextField(
//           controller: nameController,
//           maxLength: 20,
//           autofocus: true,
//           decoration: const InputDecoration(
//             hintText: 'Enter file name',
//           ),
//          // onChanged: (value) => ref.read(renameDialogStateProvider).state = value,
//         ),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: (){
             
   
//         ref.read(pdfProvider.notifier).renamePdf( filePath, nameController.text.trim());
    
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(message),
//     ));
//   }
// }
