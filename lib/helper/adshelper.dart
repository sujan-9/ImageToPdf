import 'dart:io';

class AdsHelper {

  // ca-app-pub-3940256099942544/6300978111
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
       return 'ca-app-pub-3940256099942544/6300978111'; // test ads
     
    }
    //  else if (Platform.isIOS) {
    //   return 'ca-app-pub-3940256099942544/2934735716';
    // } 
    else {
      throw UnsupportedError("unsupported Platform");
    }
  }

  // static String get interstitialAdUnitId {
  //   if (Platform.isAndroid) {
  //      return 'ca-app-pub-3940256099942544/1033173712'; // test ads
  //    // return "ca-app-pub-5966756244031066/6834681090"; // real ads
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/4411468910';
  //   } else {
  //     throw UnsupportedError("unsupported Platform");
  //   }
  // }

  // static String get rewardedAdUnitId {
  //   if (Platform.isAndroid) {
  //     return 'ca-app-pub-3940256099942544/5224354917'; // test ads
  //     // return 'ca-app-pub-5966756244031066/1561528911'; // real ads
  //   } else if (Platform.isIOS) {
  //     return 'ca-app-pub-3940256099942544/1712485313';
  //   } else {
  //     throw UnsupportedError('Unsupported platform');
  //   }
  // }
}
