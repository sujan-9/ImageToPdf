import 'package:flutter/material.dart';

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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            //fontWeight: FontWeight.w500,
          ),
        ),
      ),
      duration: const Duration(seconds: 2),
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

//snackbar for add images
snackbaradd(
  BuildContext context,
  void Function() camera,
  void Function() gallery,
  // String message,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      // width: 120,
      behavior: SnackBarBehavior.fixed,
      dismissDirection: DismissDirection.down,
      margin: const EdgeInsets.only(
          bottom: 00,
          right: 20,
          top: 10,
          left: 20),
      elevation: 1,
      content: Column(children: [
        TextButton(
          onPressed: () {
            camera();
          },
          child: const Text(
            'Camera',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
       const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed:(){
            gallery();
          },
          child: const Text(
            'Gallery',
            style: TextStyle(
              fontSize: 20,
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

      padding: const EdgeInsets.all(5),
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
        title: const Text(
          'Rename file',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              const SizedBox(
                height: 10,
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
                  decoration: const InputDecoration(
                    focusColor: Colors.yellow,
                    hintText: 'Enter file name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    contentPadding: EdgeInsets.all(10),
                    suffixIcon: Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 5, 0),
                      child: Text(
                        '.pdf',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
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
            child: const Text('CANCEL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
              child: const Text('SAVE',
                  style: TextStyle(
                    fontSize: 16,
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
              children: const <Widget>[
                Text(
                  'Are you sure you want to delete this file?',
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
                  )),
              onPressed: () {
                delete();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('No',
                  style: TextStyle(
                    fontSize: 16,
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
      margin: const EdgeInsets.only(
          bottom: 0,
          right: 20,
          top: 10,
          left: 20),
      elevation: 1,
      content: Column(children: [
        TextButton(
          onPressed: () {
            clearImages();
          },
          child: const Text(
            'Remove all Images',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.red,
            ),
          ),
        ),
       const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed:(){
              reorderImages();
          },
          child: const Text(
            'Manage Order',
            style: TextStyle(
              fontSize: 20,
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

      padding: const EdgeInsets.all(5),
    ),
  );
}

