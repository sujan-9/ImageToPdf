import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constant/text.dart';
import '../../core/pdfprovider.dart';
import '../../helper/pdfFiles.dart';
import '../../helper/sharePDF.dart';

import '../../widgets/widgets.dart';
import '../pdfviewer.dart';

class SelectSource extends ConsumerStatefulWidget {
  const SelectSource({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SelectSourceState();
}

class _SelectSourceState extends ConsumerState<SelectSource> {
  final TextEditingController controller = TextEditingController();
  //UrlLauncherServices urlLauncherServives = UrlLauncherServices();

  void showRecentPDFDialog(String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Recent PDF File'),
          content: Column(
            children: [
              const Text('The PDF file has been created successfully.'),
              const SizedBox(height: 16),
              Text('File Path: $filePath'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Delay the execution of getFiles using addPostFrameCallback
      ref.read(pdfProvider.notifier).getFiles();

      //ref.read(renameFileSProvider);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final filename = ref.watch(pdfProvider);\
    DateTime time = DateTime.now();
    String formattedDate = "${time.day}/${time.month}/${time.year}";

    final filePaths = ref.watch(pdfProvider);

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        //backgroundColor: Colors.red,
        // leading: const Text(""),
        title: titletext(
          'PDF Files',
        ),
        shape: Border(
          bottom: BorderSide(
            color: Colors.red,
            width: 1.8.w,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        titleSpacing: 1,
      ),
      body: filePaths.isEmpty
          ? Center(
              child: Text(
                'Nothing to show',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w600),
              ),
            )
          // RichText(
          //   text: InlineSpan,
          // )
          : Padding(
             // padding: EdgeInsets.all(22.0.w),
             padding:const  EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: ListView.builder(
                  itemCount: filePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    // int reversedIndex = filePaths.length - 1 - index;
                    // String currentFilePath = filePaths.elementAt(reversedIndex);
                    String currentFilePath = filePaths.elementAt(index);
                    String currentFileName = currentFilePath.split('/').last;
                    var filesize = File(currentFilePath).lengthSync();
                    var filesizeInKB = filesize / 1000;
                    var filesizeInMB = filesizeInKB / 1000;

                    return Container(
                      //height: MediaQuery.of(context).size.height * 0.15,
                      padding: const EdgeInsets.fromLTRB(8, 6, 9, 5),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02,
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(17.r),
                        //  border: Border.all(
                        //     color: Colors.red,
                        //     width: 1.w,
                        //   ),
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
                            children: [
                              //to implement images:
                              Container(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PDFViewer(
                                                  path: currentFilePath,
                                                )));
                                  },
                                  icon:
                                      const Icon(Icons.picture_as_pdf_rounded),
                                ),
                              ),
                              SizedBox(
                                width: 40.w,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // SizedBox(
                                      //   width: 40.w,
                                      // ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PDFViewer(
                                                        path: currentFilePath,
                                                      )));
                                        },
                                        child: Text(
                                          //filePaths.elementAt(index).split('/').last,
                                          currentFileName,

                                          style: TextStyle(
                                            letterSpacing: 1.2,
                                            fontSize: 17.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.020,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                        //to be implemented
                                        onPressed: () {
                                          // _getFileSize(currentFilePath);
                                          deleteDialogBox(context, () {
                                            // print('delete');

                                            ref
                                                .read(pdfProvider.notifier)
                                                .deleteFile(currentFilePath);

                                            snackbar(context,
                                                'File has been deleted');
                                            //Navigator.pop(context);
                                          });
                                        },
                                        icon: Icon(
                                          Icons.delete_forever_rounded,
                                          size: 25.sp,
                                        ),
                                        style: TextButton.styleFrom(
                                          iconColor: Colors.red,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      IconButton(
                                        //to be implemented
                                        onPressed: () {
                                          sharePDFFile(currentFilePath);
                                        },
                                        icon: Icon(
                                          Icons.share_rounded,
                                          size: 23.sp,
                                        ),
                                        style: TextButton.styleFrom(
                                          iconColor: Colors.red,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      IconButton(
                                        //rename file
                                        onPressed: () {
                                          showCustomDialog(
                                              context,
                                              index,
                                              filePaths,
                                              controller,
                                              () => ref
                                                  .read(pdfProvider.notifier)
                                                  .renamePdf(filePaths[index],
                                                      controller.text));
                                        },
                                        icon: Icon(
                                          Icons
                                              .drive_file_rename_outline_rounded,
                                          size: 25.sp,
                                        ),
                                        style: TextButton.styleFrom(
                                          iconColor: Colors.red,
                                          backgroundColor: Colors.white,
                                        ),
                                      ),
                                      // SizedBox(
                                      //   width: 5.w,
                                      // ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.020,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                formattedDate,
                                style: TextStyle(
                                  letterSpacing: 1.5,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  // color: Colors.red,
                                ),
                              ),
                              if (filesizeInMB < 1)
                                Text(
                                  '${filesizeInKB.toStringAsFixed(2)} KB',
                                  style: TextStyle(
                                    //letterSpacing: 1.2,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.red,
                                  ),
                                ),
                              if (filesizeInMB > 1)
                                Text(
                                  '${filesizeInMB.toStringAsFixed(2)} MB',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    // color: Colors.red,
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    );
                  }),
            ),
    ));
  }
}
