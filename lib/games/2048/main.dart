import 'package:flutter/material.dart';
import 'home.dart';
//import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_admob/firebase_admob.dart';

void main() => runApp(new MyApp2048());

class MyApp2048 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-5518200916880952~9634498708")
        .then((response) {
      myBanner
        ..load()
        ..show(anchorType: AnchorType.bottom);
    });
    return new MaterialApp(
      title: '2048',
      theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.blue,
          fontFamily: 'StarJedi'),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: <String>[], // Android emulators are considered test devices
);

BannerAd myBanner = BannerAd(
//yang bawah ini real
//  adUnitId: "ca-app-pub-5518200916880952/2438125846",
  adUnitId: "ca-app-pub-3940256099942544/6300978111",
  size: AdSize.smartBanner,
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("BannerAd event is $event");
  },
);

InterstitialAd myInter = InterstitialAd(
  adUnitId: "ca-app-pub-3940256099942544/1033173712",
  targetingInfo: targetingInfo,
  listener: (MobileAdEvent event) {
    print("Interstial event is $event");
  },
);
