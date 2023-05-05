import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/image_provider.dart';

class EditScreen extends ConsumerWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final img = ref.watch(imgNotifierProvider.notifier).selectedImages;
    final savepdf = ref.watch(imgNotifierProvider.notifier).createPdf();
    
    void remove(){
ref.read(imgNotifierProvider.notifier).removeAllImages();
    }
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        title: const Text("Edit Image"),
        
        leading:
             IconButton(
              onPressed: (){
                Navigator.pop(context);
                remove();
              }, 
            icon:const Icon(Icons.arrow_back_ios)),

            actions: [
              TextButton(onPressed: (){
                savepdf;
              },
               child: const Text("SAVE"))
            ],
      ),
      body:  Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        //child: ListView.builder(itemBuilder: itemBuilder),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: img.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
                        child:  Stack(
                          children: [
                            Image.file(
                             img[index].imagefile,
                            
                            fit: BoxFit.cover,

                            // IconButton(
                            //   onPressed: null,
                            //   icon: const Icon(Icons.close),
                            // ),

                          ),]
                        )
                            )
                            ),
            ),
          ],
        )
      ),
    );
  }
}
