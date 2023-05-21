import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:motion_toast/motion_toast.dart';
import '../../config/constant/text.dart';
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
    final filename = ref.watch(pdfProvider);

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
            ))
          // RichText(
          //   text: InlineSpan,
          // )
          : Padding(
              padding: EdgeInsets.all(20.0.w),
              child: ListView.builder(
                  itemCount: filePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    String currentFilePath = filePaths.elementAt(index);
                    // String currentFileName = currentFilePath.split('/').last;
                    return Container(
                      //height: MediaQuery.of(context).size.height * 0.15,
                      padding: EdgeInsets.all(10.w),
                      margin: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.01,
                        horizontal: MediaQuery.of(context).size.width * 0.01,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        // color: Colors.red,
                        borderRadius: BorderRadius.circular(17.r),
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
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PDFViewer(
                                                path: currentFilePath,
                                              )));
                                },
                                icon: const Icon(Icons.picture_as_pdf_rounded),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PDFViewer(
                                                path: currentFilePath,
                                              )));
                                },
                                child: Text(
                                  // filePaths.elementAt(index).split('/').last,
                                  //currentFileName,
                                  filename.elementAt(index).split('/').last,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                              IconButton(
                                //to be implemented
                                onPressed: () {
                                  deleteDialogBox(context, () {
                                    // print('delete');

                                    ref
                                        .read(pdfProvider.notifier)
                                        .deleteFile(currentFilePath);

                                    snackbar(context, 'File has been deleted');
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
                                  Icons.drive_file_rename_outline_rounded,
                                  size: 25.sp,
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
