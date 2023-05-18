

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/nameprovider.dart';



 snackbar(
  BuildContext context,
  String message,
){
   ScaffoldMessenger.of(context).showSnackBar(
     SnackBar(
     // width: 120,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,
      
  
      content: Center(
        child: Text(message,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          //fontWeight: FontWeight.w500,
        ),),
      ),
      duration:const Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
    //  margin: EdgeInsets.only(
    //     bottom: MediaQuery.of(context).size.height - 100,
    //     right: 20,
    //     top: 10,
    //     left: 20),
      padding: const EdgeInsets.all(5),
    ),
    
  );
}
// void snacbar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(message),
//     ),
//   );
//}



 showCustomDialog(
  BuildContext context,
  //TextEditingController namecontroller,
  WidgetRef ref,
 // VoidCallback onPressed,
  int index,
   List<String> filePaths,
   TextEditingController nameController ,
  ) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
     // TextEditingController nameController = TextEditingController();
      return AlertDialog(
      title: const Text('Rename file',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      
      ),),
      content: SingleChildScrollView(
        child: ListBody(
          children:  <Widget>[
            
            const SizedBox(height: 10,),
            Consumer(
             
               builder: (context, ref, child) {
                //final renameFileName = ref.watch(renameFileProvider.notifier).state;
               // final fileNameNotifier = ref.watch(renameFileSProvider.notifier);
                 final fileName = ref.watch(renameFileSProvider);
                 nameController.text = fileName;
      
                 
                  return SizedBox(
                   width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      
                    
                      maxLength: 20,
                      autofocus: true,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    controller: nameController,
                      onSubmitted: (String value) {
                        ref.read(renameFileSProvider.notifier).updateFileName(value);
                      },
                     //onSubmitted: (value) => nameController.text = value,
                                decoration: const InputDecoration(
                                  focusColor: Colors.yellow,
                                  
                                  hintText: 'Enter file name',
                                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    
                                  ),
                                  contentPadding: EdgeInsets.all(10),
                              
                                  suffixIcon:   Padding(
                    padding: EdgeInsets.fromLTRB(0, 12, 5, 0),
                    child: Text('.pdf',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                                  ),
                                ),
                                  ),
                  );
         } ),
           
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text('SAVE',
            style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
               )
            ),
            onPressed: () {
              String newFileName = nameController.text.trim();
              if (newFileName.isNotEmpty) {
                // Check if the new file name is valid
                RegExp regex = RegExp(r'^[a-zA-Z0-9_-]+$');
                if (regex.hasMatch(newFileName)) {
                  // Rename logic here
                  String currentFilePath = filePaths.elementAt(index);
                  String directoryPath =
                      currentFilePath.substring(0, currentFilePath.lastIndexOf('/'));
                  String newFilePath = "$directoryPath/$newFileName.pdf";
      
                  // Check if the new file name is unique
                  List<String> existingFileNames = filePaths
                      .map((filePath) => filePath.split('/').last)
                      .toList();
                  if (existingFileNames.contains(newFileName)) {
                    snackbar(context, 'File name already exists');
                  } else {
                    File(currentFilePath).renameSync(newFilePath);
                   
                    Navigator.of(context).pop();
                  }
                } else {
                  snackbar(context, 'Invalid file name');
                }
              } else {
                snackbar(context, 'Please enter a valid file name');
              }
            },
          ),
          TextButton(
            child: const Text('CANCEL',
            style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
               )
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
      ],
        );
    },
  );
}

deleteDialogBox(
  BuildContext context,
  void Function() delete,
){
  showDialog(
    context: context, 
    builder:( BuildContext context){
     return AlertDialog(
     
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
           
             Text('Are you sure you want to delete thid file?',
               style: TextStyle(
                 fontSize: 20,
                 fontWeight: FontWeight.w600,
               ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: const Text('Yes',
            style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
               )
            ),
             onPressed: (){
            delete();
            Navigator.of(context).pop();
          },
          
          
          ),
          TextButton(
            child: const Text('No',
             style: TextStyle(
                 fontSize: 16,
                 fontWeight: FontWeight.w600,
               )
            ),
             onPressed: (){
           
            Navigator.of(context).pop();
          },
          
          
          ),
      ],
    
    );
    }
    );
}


// reorder(){
//   return ReorderableList(
//     itemBuilder: itemBuilder,
//      itemCount: itemCount,
//       onReorder: onReorder)
// }