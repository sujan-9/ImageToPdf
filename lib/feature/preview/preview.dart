import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:imagetopdf/model/image_model.dart';

//import '../../core/image_provider.dart';


// ignore: must_be_immutable
class PreviewPage extends ConsumerWidget {
  List<File> fileImageArray = [];
   PreviewPage({Key? key, required this.fileImageArray}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final options = ref.read(imgNotifierProvider.notifier).selectedImages;
    // List<File> fileImageArray = options.map((e) => File(e.path)).toList();
    //print('preview $fileImageArray.length');

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
              padding:  EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 5.h),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: fileImageArray.length,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w,vertical: 2.h),
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