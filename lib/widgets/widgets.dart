import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

snackbar(
  BuildContext context,
  String message, 
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // width: 120,
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.down,

      content: Center(
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
            //fontWeight: FontWeight.w500,
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.redAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      //  margin: EdgeInsets.only(
      //     bottom: MediaQuery.of(context).size.height - 100,
      //     right: 20,
      //     top: 10,
      //     left: 20),
      padding:  EdgeInsets.all(5.w),
    ),
  );
}

//snackbar for add images
snackbaradd(
  BuildContext context,
  void Function() camera,
  void Function() gallery,
  // String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // width: 420,
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.down,
      
      elevation: 1,
      content: Column(children: [
        TextButton(
          onPressed: () {
            camera();
          },
          child:  Text(
            'Camera',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
       SizedBox(
          height: 10.h,
        ),
        TextButton(
          onPressed:(){
            gallery();
          },
          child:  Text(
            'Gallery',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
      ]),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 153, 180, 226),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

      padding:  EdgeInsets.all(5.w),
    ),
  );
}

//rename pdf files
showCustomDialog(
  BuildContext context,
  int index,
  List<String> filePaths,
  TextEditingController nameController,
  void Function() rename,
) {
  //final fileName = ref.watch(pdfProvider.notifier).renamePdfFile(oldFilePath, newFileName);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title:  Text(
          'Rename file',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
               SizedBox(
                height: 10.h,
              ),
              SizedBox(
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
                    nameController.text = value;
                  },
                  //onSubmitted: (value) => nameController.text = value,
                  decoration:  InputDecoration(
                    focusColor: Colors.yellow,
                    hintText: 'Enter file name',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: EdgeInsets.all(10.w),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 5, 0),
                      child: Text(
                        '.pdf',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child:  Text('CANCEL',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child:  Text('SAVE',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {
                //  ref.read(pdfProvider.notifier).renamePdf( filePath, nameController.text.trim());
                rename();
                Navigator.of(context).pop();
              }),
        ],
      );
    },
  );
}

deleteDialogBox(
  BuildContext context,
  void Function() delete,
) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Text(
                  'Are you sure you want to delete this file?',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('Yes',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {
                delete();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child:  Text('No',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      });
}

 
snackbarmenu(
  BuildContext context,
  void Function() clearImages,
  void Function() reorderImages,
  // String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // width: 120,
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.down,
     
      elevation: 1,
      content: Column(children: [
        TextButton(
          onPressed: () {
            clearImages();
          },
          child:  Text(
            'Remove all Images',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        TextButton(
          onPressed:(){
              reorderImages();
          },
          child:  Text(
            'Manage Order',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
      ]),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 153, 180, 226),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.r),
      ),
      // margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),

      padding:  EdgeInsets.all(5.w),
    ),
  );
}

//Loading indicator

loader(BuildContext context, ){
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.transparent,
      color: Color.fromARGB(255, 199, 28, 16),
    ),
  );
}