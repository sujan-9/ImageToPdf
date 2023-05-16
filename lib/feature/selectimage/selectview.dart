import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagetopdf/feature/pdfviewer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/pdf.dart';








class SelectSource extends ConsumerWidget {
 
const SelectSource({Key? key, }) : super(key: key);
  
  

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   
  String directory = ("storage/emulated/0/ImageToPdfConverter");
List<FileSystemEntity> files = Directory(directory).listSync(recursive: false);

List<String> filePaths = [];
for (var fileSystemEntity in files) {
  if (fileSystemEntity.path.endsWith(".pdf")) {
    filePaths.add(fileSystemEntity.path);
  }
}
   
    return  SafeArea(
      child: Scaffold(
       
        body: Padding(
         padding:  const EdgeInsets.all(20.0),
         child: 
        ListView.builder(
          itemCount: filePaths.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onDoubleTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PDFViewer(path: filePaths.elementAt(index),),
                ),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.15,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * 0.01,
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                 // color: Colors.red,
                  borderRadius: BorderRadius.circular(17),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    ),
                  ],
                ),
                 
                child:  Center(child: Text(filePaths.elementAt(index).split('/').last)),
              
              ),
            );
          }),
        
      ),)
    );

  }
}



