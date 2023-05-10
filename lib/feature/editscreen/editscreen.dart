import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../core/image_provider.dart';

import '../../widgets/widgets.dart';
import '../bottombar/bootombar.dart';
import '../preview/preview.dart';


// ignore: must_be_immutable
class EditScreen extends ConsumerWidget {
   EditScreen({Key? key}) : super(key: key);
  
  
List<File> fileImageArray = [];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final img = ref.watch(imgNotifierProvider);
    //final path = ref.watch (imgNotifierProvider.notifier).path;
   // print(fileImageArray.length);
    void pdf ()async{
       final status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      ref.read(imgNotifierProvider.notifier).createPdf();
      
    }
    else if (status.isDenied){
      throw('Permission denied');
    }
    else if (status.isPermanentlyDenied){
      openAppSettings();

    }}
     
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: const Text("Edit Image"),
        leading: IconButton(
          onPressed: () {
           
          // img.clear();
           // ref.read(imgNotifierProvider.notifier).removeAllImages;
           // fileImageArray.clear();
             Navigator.pop(context);
            
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
           TextButton(
            onPressed: () {
              
              // ref.read(imgNotifierProvider.notifier).createPdf();
              fileImageArray = img.map((e) => File(e.path)).toList();
              
              
               Navigator.push(context, MaterialPageRoute(builder:
                (context) => PreviewPage( fileImageArray: fileImageArray,)));
              // Navigator.pop(context);
            },
            child: const Text("PreviewPage"),
          ),
          TextButton(
            onPressed: () {
              pdf();
              // ref.read(imgNotifierProvider.notifier).createPdf();
              
              snackbar(context, 'Pdf has beed saved');
               const Duration(seconds: 2);
              // print('Pdf has beed saved');
               
            
             //snacckbar
                 
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const BottomBar( )));
              // Navigator.pop(context);
            },
            child: const Text("SAVE"),
          ),
          
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
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
                          height: MediaQuery.of(context).size.height * 0.95,
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
                                   ref.read(imgNotifierProvider.notifier).removeImage(img[index]);
                                  
                                   
                                   if(img.length==1){
                                  const  Text('no images is selected',
                                  style: TextStyle(color: Colors.white),);
                                   }
                                   
                                    // if (ref.read(imgNotifierProvider.notifier).selectedImages==null) {
                                    //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const BottomBar( )));
                                    // }
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
    );
  }
}
