import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imagetopdf/model/image_model.dart';

import '../../core/image_provider.dart';

class PreviewPage extends ConsumerWidget {
  const PreviewPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(imgNotifierProvider.notifier).selectedImages;
    List<File> fileImageArray = options.map((e) => File(e.path)).toList();

   return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Converter'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           
          Navigator.pop(context);
          
          },
        )
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children:[
            
            Container(
              height: MediaQuery.of(context).size.height ,
              padding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: fileImageArray.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 7),
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Image.file(
                         fileImageArray[index],
                        
                        fit: BoxFit.cover,
                      ),
                     
                      ]
                      )
                      )
                      )
                      ),
                      
          ],
        ),
      ),
    );
  }
}