import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/nameprovider.dart';
import '../../helper/pdfiles.dart';

import '../../widgets/widgets.dart';

class SelectSource extends ConsumerStatefulWidget {
  const SelectSource({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectSourceState();
}

class _SelectSourceState extends ConsumerState<SelectSource> {
  final TextEditingController controller = TextEditingController();
  // @override
  // void initState() {
    
  //   super.initState();
    
  // }


   @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    String filename = ref.watch(renameFileSProvider);
   // print(filename);
   FilesHelper deleteFile = FilesHelper();

    String directory = ("storage/emulated/0/ImageToPdfConverter");
    List<FileSystemEntity> files =
        Directory(directory).listSync(recursive: false);

    List<String> filePaths = [];
    for (var fileSystemEntity in files) {
      if (fileSystemEntity.path.endsWith(".pdf")) {
        filePaths.add(fileSystemEntity.path);
      }
    }
    // //String name = filePaths.elementAt(index).split('/').last;

    
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
            itemCount: filePaths.length,
            itemBuilder: (BuildContext context, int index) {
              String currentFilePath = filePaths.elementAt(index);
              String currentFileName = currentFilePath.split('/').last;
              return Container(
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

                //  child:  Center(child: Text(filePaths.elementAt(index).split('/').last)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(Icons.picture_as_pdf_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          // filePaths.elementAt(index).split('/').last,
                          //currentFileName,
                          filename.isNotEmpty?filename:currentFileName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Icon(Icons.share),
                        // Icon(Icons.delete),

                        IconButton(
                          //to be implemented
                          onPressed: () {
                            // deleteFile.deleteFile(currentFilePath);
                            setState(() {
                              deleteDialogBox(context, () {
                                deleteFile.deleteFile(currentFilePath);
                               //ref.read(pathProvider.notifier).deleteFile(currentFilePath);
                                snackbar(context, 'File has been deleted');

                              });
                              
                            });
                          },
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            size: 25,
                          ),
                          style: TextButton.styleFrom(
                            iconColor: Colors.red,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        IconButton(
                          //to be implemented
                          onPressed: null,
                          icon: const Icon(
                            Icons.share_rounded,
                            size: 23,
                          ),
                          style: TextButton.styleFrom(
                            iconColor: Colors.red,
                            backgroundColor: Colors.white,
                          ),
                        ),
                        IconButton(
                          //rename file
                          onPressed: () {
                           setState(() {
                              showCustomDialog(
                              context,
                              ref,
                              index,
                              filePaths,
                              controller,
                            );
                           });
                            // RefreshCallback;
                          },
                          icon: const Icon(
                            Icons.drive_file_rename_outline_rounded,
                            size: 25,
                          ),
                          style: TextButton.styleFrom(
                            iconColor: Colors.red,
                            backgroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
      ),
    ));
  }
}
