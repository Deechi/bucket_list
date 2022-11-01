import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Admob extends ChangeNotifier{
  InterstitialAd? interstitialAd;
  int maxFailedLoadAttempts = 5;
  int numInterstitialLoadAttempts = 0;

  String getInterStitialID() {
    String interStitialUnitId = "";
    if (Platform.isAndroid) {
      // Android のとき
      interStitialUnitId = "ca-app-pub-1277964379646272/9143837865";
      // test
      // interStitialUnitId = "ca-app-pub-3940256099942544/1033173712";
    } else {
      // iOSのとき
      interStitialUnitId = "ca-app-pub-1277964379646272/9910124623";
      // test
      // interStitialUnitId = "ca-app-pub-3940256099942544/4411468910";
    }
    return interStitialUnitId;
  }

  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  void createInterstitialAd() {
    print("createInterstitialAd");
    final String unitID = getInterStitialID();
    InterstitialAd.load(
        adUnitId: unitID,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print("InterstitialAd loaded");
            interstitialAd = ad;
            numInterstitialLoadAttempts = 0;
            interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            numInterstitialLoadAttempts += 1;
            interstitialAd = null;
            if (numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
    notifyListeners();
  }

  void showInterstitialAd() {
    bool showAdFlag = getShowAdFlag();
    print(showAdFlag);
    if (interstitialAd == null || showAdFlag == false) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
    notifyListeners();
  }

  bool getShowAdFlag() {
    var random = math.Random();
    int rand = random.nextInt(6);

    print(rand);

    if(rand == 0) {
      return true;
    }else {
      return false;
    }
  }


}
