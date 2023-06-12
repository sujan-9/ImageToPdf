import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imagetopdf/feature/ReorderPage/reorder.dart';
import 'package:imagetopdf/feature/bottombar/provider.dart';

import 'package:permission_handler/permission_handler.dart';

import '../../core/image_provider.dart';

import '../../helper/imagecropper.dart';
import '../../widgets/widgets.dart';
import '../bottombar/bootombar.dart';

import '../preview/preview.dart';

// ignore: must_be_immutable
class EditScreen extends ConsumerStatefulWidget {
  const EditScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditScreenState();
}

class _EditScreenState extends ConsumerState<EditScreen> {
  final PageController _pageController = PageController();
 int currentPageIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<File> fileImageArray = [];
    final img = ref.watch(imgNotifierProvider);

    //pagecontroller

    void scrollToNextImage() {
      if (currentPageIndex < img.length - 1) {
        _pageController.animateToPage(
          currentPageIndex + 1,
          duration: const Duration(
              milliseconds: 300), // Replace with the desired animation duration
          curve:
              Curves.elasticInOut, // Replace with the desired animation curve
        );
      }
    }

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
    // bool isSaving = false;
    // final isSaving = ref.watch(isSavingProvider);

    Cropper cropeimage = Cropper();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        appBar: AppBar(
          // title: const Text("Edit Image"),
          leading: IconButton(
            onPressed: () {
              ref.read(imgNotifierProvider.notifier).removeAllImages();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.red,
              size: 24.sp,
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                  //backgroundColor: Colors.transparent,

                  ),
              onPressed: () {
                if (img.isNotEmpty) {
                  fileImageArray = img.map((e) => File(e.path)).toList();

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PreviewPage(
                                fileImageArray: fileImageArray,
                              )));
                } else {
                  return;
                }
              },
              child: Text(
                "Preview",
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors.red,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //  const CircularProgressIndicator(
                //     valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),);
                if (img.isNotEmpty) {
                  pdf();

                  snackbar(context, 'Generating PDF wait...');
                  ref.read(navProvider.notifier).changeIndex(1);
                  Timer(const Duration(seconds: 3), () {
                    snackbar(context, 'Pdf has beed saved');
                    
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BottomBar()));
                    ref.read(imgNotifierProvider.notifier).removeAllImages();
                  });
                } else {
                  null;
                }
              },
              child: Text(
                "Save",
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors.red,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                snackbarmenu(
                  context,
                  () =>
                      ref.read(imgNotifierProvider.notifier).removeAllImages(),
                  () {
                    if (img.isNotEmpty) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReorderPage()));
                    } else {
                      return;
                    }
                  },
                );
              },
              icon: Icon(
                Icons.more_vert_rounded,
                color: Colors.red,
                size: 25.sp,
              ),
            ),
          ],
        ),
        body: img.isEmpty
            ? Center(
                child: Text(
                  'No images is selected',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                  ),
                ),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(10.w, 20.h, 10.w, 5.h),
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onHorizontalDragEnd: (details) {
                          if (details.velocity.pixelsPerSecond.dx > 0) {
                            // Swiped to the right
                            scrollToNextImage();
                          } else if (details.velocity.pixelsPerSecond.dx < 0) {
                            // Swiped to the left
                            // Implement scrolling to previous image if needed
                          }
                        },
                        child: PageView.builder(
                            controller: _pageController,
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: img.length,
                            itemBuilder: (context, index) => Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.w, vertical: 7.h),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.95,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
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
                                                  .read(imgNotifierProvider
                                                      .notifier)
                                                  .removeImage(img[index]);

                                              if (img.isEmpty) {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const BottomBar()));
                                              }
                                            },
                                            icon: Icon(
                                              Icons.cancel,
                                              color: Colors.red,
                                              size: 40.sp,
                                            ),
                                          ),
                                        ),

                                        //crop images
                                        Positioned(
                                          top: 2,
                                          left: 2,
                                          child: IconButton(
                                            onPressed: ()async {
                                              // ref
                                              //     .read(imgNotifierProvider
                                              //         .notifier)
                                              //     .removeImage(img[index]);
                                              //(img[index].imagefile);
                                              
                                                final croppedImage =
                                                    await cropeimage.cropImage(
                                                        img[index].imagefile);
                                                if (croppedImage != null) {
                                                  ref
                                                      .read(imgNotifierProvider
                                                          .notifier)
                                                      .replaceImage(img[index],
                                                          croppedImage);
                                                }
                                              

                                              // if (img.isNotEmpty) {
                                              //   Navigator.pushReplacement(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //           builder: (context) =>
                                              //               CropImagePage(image: img[index].imagefile,)));
                                              // }
                                            },
                                            icon: Icon(
                                              Icons.crop_16_9_rounded,
                                              color: Colors.red,
                                              size: 40.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    ),
                    //const  Text('set color',style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            snackbaradd(
              context,
              () => ref.read(imgNotifierProvider.notifier).addFromCamera(),
              () => ref.read(imgNotifierProvider.notifier).addImages(),
            );
          },
          child: Icon(
            Icons.add,
            size: 25.sp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
