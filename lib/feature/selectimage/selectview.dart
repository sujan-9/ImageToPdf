import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagetopdf/feature/editscreen/editscreen.dart';

import '../../core/image_provider.dart';




class SelectSource extends ConsumerWidget {
  const SelectSource({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
  

   //final opt = ref.watch(imgNotifierProvider.notifier).selectedImages;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          TextButton(onPressed: (){
            //opt.pickImagesFromGallery();
            ref.read(imgNotifierProvider.notifier).pickImagesFromGallery();
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  EditScreen()));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.blue)
              )
            )
          
          ),
           child: const Text("Gallery")),
           const  TextButton(onPressed: null,
           child: Text("Camera")),
           TextButton(onPressed: (){
            //opt.pickImagesFromGallery();
            //ref.read(imgNotifierProvider.notifier).();
           // Navigator.push(context, MaterialPageRoute(builder: (context) =>  PdfViewerScreen(path: path,)));
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blue),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: const BorderSide(color: Colors.blue)
              )
            )
          
          ),
           child: const Text("saved pdf")),
        ],),
      ),
    );

  }
}