// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/image_provider.dart';

class ReorderPage extends ConsumerWidget {
  const ReorderPage({Key? key}) : super(key: key);

  //  List<String> imagename = [];
  //  List<File> imageArray = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
 
    final img = ref.watch(imgNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
         
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        child: ReorderableListView(
          children: [
            for (var i = 0; i < img.length; i++)
              Container(
              key: ValueKey(img[i]),
              height: MediaQuery.of(context).size.height * 0.15,
              padding:  EdgeInsets.all(10.w),
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                 

                  
                  Image.file(
                      File(img[i].path),
                      fit: BoxFit.fill,
                    ),


                   SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    // filePaths.elementAt(index).split('/').last,
                    //currentFileName,
                    img[i].name.length > 10
                        ? '${img[i].name.substring(0, 20)}...pdf'
                        : img[i].name,
                    // overflow: TextOverflow.ellipsis,
                    // maxLines: 2,
                    style:  TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              )
          ],
          onReorder: (int oldIndex, int newIndex) {
            if (newIndex > oldIndex) {
              newIndex -= 1;
            }
            ref.read(imgNotifierProvider.notifier).reorderImages(oldIndex, newIndex);
          },
        ),
        
      ),
    );
  }
}
