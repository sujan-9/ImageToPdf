import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../config/constant/text.dart';
import '../../core/image_provider.dart';
import '../../helper/adshelper.dart';
import '../editscreen/editscreen.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Chosse one option',
                style: TextStyle(
                  fontSize: 15,
                  //fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  ref.read(imgNotifierProvider.notifier).pickImagesFromCamera();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditScreen()));
                },
                child: const Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(imgNotifierProvider.notifier)
                      .pickImagesFromGallery();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditScreen()));
                },
                child: const Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  // BannerAd? _bannerAd;
  // bool _isLoaded = false;
  // var adsId = 'ca-app-pub-3940256099942544/6300978111';

  // void loadAd() {
  //   _bannerAd = BannerAd(
  //     adUnitId: adsId,
      
  //     request: const AdRequest(),
  //     size: AdSize.banner,
  //     listener: BannerAdListener(
  //       // Called when an ad is successfully received.
  //       onAdLoaded: (ad) {
  //         debugPrint('$ad loaded.');
  //         setState(() {
  //           _isLoaded = true;
  //         });
  //       },
  //       // Called when an ad request failed.
  //       onAdFailedToLoad: (ad, error) {
  //         debugPrint('BannerAd failed to load: $error');
  //         print(error.toString());
  //         // Dispose the ad here to free resources.
  //         ad.dispose();
  //       },
  //     ),
  //   )..load();
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   loadAd();
  // }

  // @override
  // void dispose() {
  //   _bannerAd?.dispose();
  //   loadAd();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;
    Future<bool> exitApp(BuildContext context) async {
      // Check if the back button is pressed twice within 2 seconds
      if (currentBackPressTime == null ||
          DateTime.now().difference(currentBackPressTime!) >
              const Duration(seconds: 2)) {
        // First back press, show a message
        currentBackPressTime = DateTime.now();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Press back again to exit'),
            duration: Duration(seconds: 2),
          ),
        );
        return false; // Prevent the app from closing
      } else {
        // Second back press within 2 seconds, exit the app
        return true; // Let the app close
      }
    }

    return WillPopScope(
      onWillPop: () async => exitApp(context),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
           // leading: const Text(''),
           backgroundColor:const Color.fromARGB(255, 247, 245, 245),
            centerTitle: true,
            elevation: 1,
             automaticallyImplyLeading: false,
            title: titletext(
              'PDF Maker',
              
            ),
            shape: Border(
            bottom: BorderSide(
              color: Colors.red,
              width: 1.8.w,
            ),
          ),
          ),
          body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              //  SizedBox(
              //     height: 120,
              //     child:
              //      _isLoaded
              //         ? Align(
              //             alignment: Alignment.bottomCenter,
              //             child: SizedBox(
              //               width: _bannerAd!.size.width.toDouble(),
              //               height: _bannerAd!.size.height.toDouble(),
              //               child: AdWidget(ad: _bannerAd!),
              //             ),
              //           )
              //         : const Text('ADS failed to load'),
              //   ),
                Center(
                    child: Text(
                  "Image",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )),
                Text(
                  "No image is Selected",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Select an image to start editing",
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  width: 200.w,
                  child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0).r,
                                  side:
                                      const BorderSide(color: Colors.purple)))),
                      onPressed: () {
                        _showDialog();
                      },
                      child: Text(
                        'Select Images',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ]),
        ),
      ),
    );
  }
}
