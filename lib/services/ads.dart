import 'package:firebase_admob/firebase_admob.dart';


class DisplayAds {
  static const String testDevice = "Test";

  static void initializeAdMob() {
    FirebaseAdMob.instance
        //"ca-app-pub-2296909687310111~9397774106"
        .initialize(appId: FirebaseAdMob.testAppId);
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice == null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['bbc news', 'cnn news', 'habari', 'al-jazeera'],
  );

  static BannerAd createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      targetingInfo: targetingInfo,
      size: AdSize.banner,
      listener: (MobileAdEvent event) {
        print("BannerAd $event");
      },
    );
  }

  static InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      //"ca-app-pub-2296909687310111/1155487851"
      adUnitId: InterstitialAd.testAdUnitId,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("InterstitialAd $event");
      },
    );
  }
}
