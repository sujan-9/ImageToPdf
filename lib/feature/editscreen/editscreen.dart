import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../core/image_provider.dart';

import '../../widgets/widgets.dart';
import '../bottombar/bootombar.dart';
import '../preview/preview.dart';
import '../selectimage/selectview.dart';

// ignore: must_be_immutable
class EditScreen extends ConsumerWidget {
  EditScreen({Key? key}) : super(key: key);

  List<File> fileImageArray = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //TextEditingController namecontroller = TextEditingController();
    // String name = ref.watch(nameProvider);
    // print(name);

    final img = ref.watch(imgNotifierProvider);

    pdf() async {
      final status = await Permission.manageExternalStorage.request();
      if (status.isGranted) {
        ref.read(imgNotifierProvider.notifier).createPdf();
      } else if (status.isDenied) {
        throw ('Permission denied');
      } else if (status.isPermanentlyDenied) {
        openAppSettings();
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          // title: const Text("Edit Image"),
          leading: IconButton(
            onPressed: () {
              img.clear();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  //backgroundColor: Colors.transparent,
    
                  ),
              onPressed: () {
                fileImageArray = img.map((e) => File(e.path)).toList();
    
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PreviewPage(
                              fileImageArray: fileImageArray,
                            )));
                // Navigator.pop(context);
              },
              child: const Text(
                "Preview",
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                pdf();
                // showCustomDialog(context,  ref, pdf);
                // ref.read(imgNotifierProvider.notifier).createPdf();
                //  DialogBox(onPressed: pdf);
    
                snackbar(context, 'Pdf has beed saved');
                const Duration(seconds: 2);
    
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => BottomBar()));
                //Navigator.pop(context);
              },
              child: const Text(
                "Save",
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors.red,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const IconButton(
              onPressed: null, 
              icon: Icon(Icons.more_vert_rounded,
              color: Colors.red,
              size: 25,
    
              ),
              ),
          ],
        ),
        body: img.isEmpty
            ? const Center(
                child: Text(
                  'No images is selected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              )
            : Padding(
                padding: const EdgeInsets.fromLTRB(10, 50, 10, 5),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: img.length,
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 7),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.95,
                                  width: MediaQuery.of(context).size.width * 0.95,
                                  child: Stack(
                                    children: [
                                      Image.file(
                                        img[index].imagefile,
                                        fit: BoxFit.fill,
                                      ),
                                      Positioned(
                                        top: 2,
                                        right: 2,
                                        child: IconButton(
                                          onPressed: () {
                                            ref
                                                .read(
                                                    imgNotifierProvider.notifier)
                                                .removeImage(img[index]);
    
                                            //  if(img){
                                            // const  Text('no images is selected',
                                            // style: TextStyle(color: Colors.white),);
                                            //  }
    
                                            if (img.isEmpty) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const BottomBar()));
                                            }
                                          },
                                          icon: const Icon(
                                            Icons.cancel,
                                            color: Colors.red,
                                            size: 40,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
