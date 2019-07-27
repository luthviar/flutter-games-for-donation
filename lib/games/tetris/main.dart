import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'gamer/gamer.dart';
import 'generated/i18n.dart';
import 'material/audios.dart';
import 'panel/page_portrait.dart';

import 'gamer/keyboard.dart';

//void main() {
//  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
//  _disableDebugPrint();
//  runApp(MyAppTetris());
//}

void _disableDebugPrint() {
  bool debug = false;
  assert(() {
    debug = true;
    return true;
  }());
  if (!debug) {
    debugPrint = (String message, {int wrapWidth}) {
      //disable log print when not in debug mode
    };
  }
}

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

class MyAppTetris extends StatelessWidget {
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

    return MaterialApp(
      title: 'tetris',
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      navigatorObservers: [routeObserver],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Sound(
          child: Game(
            child: KeyboardController(child: _HomePage()),
          ),
        ),
      ),
    );
  }
}

const SCREEN_BORDER_WIDTH = 2.0;

const BACKGROUND_COLOR = const Color(0xFF1DE9B6);

class _HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //only Android/iOS support land mode
    bool supportLandMode = Platform.isAndroid || Platform.isIOS;
    bool land = supportLandMode &&
        MediaQuery.of(context).orientation == Orientation.landscape;

    return land ? PageLand() : PagePortrait();
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
