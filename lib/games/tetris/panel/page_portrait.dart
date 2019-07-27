import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
import '../generated/i18n.dart';
import '../income/donation_dialog.dart';
import '../main.dart';
import '../panel/controller.dart';
import '../panel/screen.dart';

part 'page_land.dart';

class PagePortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final screenW = size.width * 0.8;

    return SizedBox(
      child: SizedBox.expand(
        child: Container(
          color: BACKGROUND_COLOR,
          padding: EdgeInsets.all(15.0),
//          constraints: BoxConstraints.expand(
//            height: 500.0,
//          ),
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Spacer(),
                    FlatButton(
                      onPressed: () {
                        RewardedVideoAd.instance
                          ..load(
                              adUnitId:
                                  "ca-app-pub-3940256099942544/5224354917",
                              targetingInfo: targetingInfo)
                          ..show().then((e) {
                            showDialog(
                                context: context,
                                builder: (context) => DonationDialog());
                          });
                      },
                      child: Text('Donasi Kuy!'),
                    ),
//                        Text(S.of(context).reward))
                  ],
                ),
                Spacer(),
                _ScreenDecoration(child: Screen(width: screenW)),
                Spacer(flex: 2),
                GameController(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ScreenDecoration extends StatelessWidget {
  final Widget child;

  const _ScreenDecoration({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: const Color(0xFF00BFA5), width: SCREEN_BORDER_WIDTH),
          left: BorderSide(
              color: const Color(0xFF1DE9B6), width: SCREEN_BORDER_WIDTH),
          right: BorderSide(
//              color: const Color(0xFFfae36c), width: SCREEN_BORDER_WIDTH),
              color: const Color(0xFF64FFDA),
              width: SCREEN_BORDER_WIDTH),
          bottom: BorderSide(
              color: const Color(0xFFA7FFEB), width: SCREEN_BORDER_WIDTH),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
        child: Container(
          padding: const EdgeInsets.all(3),
          color: SCREEN_BACKGROUND,
          child: child,
        ),
      ),
    );
  }
}

MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  testDevices: <String>[], // Android emulators are considered test devices
);
