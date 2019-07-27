import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flame/flame.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'games/trex/game/game.dart';

import 'games/2048/main.dart';
import 'games/tetris/main.dart';
import 'games/crush/application_crush.dart';
import 'games/trex/main.dart';
import 'games/snake/main.dart';

const HomeRoute = '/';
const Game2048Route = '/game/2048';
const GameTetrisRoute = '/game/tetris';
const GameCrushRoute = '/game/crush';
const GameTrexRoute = '/game/trex';
const GameSnakeRoute = '/game/snake';

TRexGame tRexGame;

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: _routes(),
      title: 'Games and Donations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Arial',
        textTheme: TextTheme(
          button: TextStyle(color: Colors.white, fontSize: 18.0),
          title: TextStyle(color: Colors.red),
        ),
      ),
      home: HomeScreen(),
    );
  }

  RouteFactory _routes() {
    return (settings) {
      final Map<String, dynamic> arguments = settings.arguments;
      Widget screen;
      switch (settings.name) {
        case HomeRoute:
          screen = App();
          break;
        case Game2048Route:
          screen = MyApp2048();
          break;
        case GameTetrisRoute:
          screen = MyAppTetris();
          break;
        case GameCrushRoute:
          screen = ApplicationCrush();
          break;
        case GameTrexRoute:
          screen = GameTrexWrapper(tRexGame);
          break;
        case GameSnakeRoute:
          screen = MySnakeApp();
          break;
        default:
          return null;
      }
      return MaterialPageRoute(builder: (BuildContext context) => screen);
    };
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () => _handleURLButtonPress(context, HomeRoute),
                  child: Text('Home'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () =>
                      _handleURLButtonPress(context, Game2048Route),
                  child: Text('Game 2048'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () =>
                      _handleURLButtonPress(context, GameTetrisRoute),
                  child: Text('Game Tetris'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () =>
                      _handleURLButtonPress(context, GameCrushRoute),
                  child: Text('Game Crush'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () {
                    _mainTrex(context);
//                    _handleURLButtonPress(context, GameTrexRoute);
                  },
                  child: Text('Game Trex'),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: FlatButton(
                  color: Theme.of(context).primaryColor,
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.0, vertical: 15.0),
                  onPressed: () {
//                    _mainTrex(context);
                    _handleURLButtonPress(context, GameSnakeRoute);
                  },
                  child: Text('Game Snake'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleURLButtonPress(BuildContext context, String game) {
//    Navigator.push(
//        context, MaterialPageRoute(builder: (context) => WebviewDetail(url))
//    );
    Navigator.pushNamed(context, game);
  }

  void _mainTrex(BuildContext context) async {
    Flame.audio.disableLog();
    List<ui.Image> image = await Flame.images.loadAll(["sprite.png"]);
    tRexGame = TRexGame(spriteImage: image[0]);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MaterialApp(
            title: 'TRexGame',
            home: Scaffold(
              body: GameTrexWrapper(tRexGame),
            ),
          ),
        ));

    Flame.util.addGestureRecognizer(new TapGestureRecognizer()
      ..onTapDown = (TapDownDetails evt) => tRexGame.onTap());

    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
