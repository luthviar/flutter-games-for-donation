import 'helpers/audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bloc/bloc_provider.dart';
import 'bloc/game_bloc.dart';
import 'pages/home_page.dart';
import 'package:flutter/material.dart';

class ApplicationCrush extends StatelessWidget {
  //
  // Remove the status bar
  //

  @override
  Widget build(BuildContext context) {
    Audio.init();
    SystemChrome.setEnabledSystemUIOverlays([]);
    return BlocProvider<GameBloc>(
      bloc: GameBloc(),
      child: MaterialApp(
        title: 'Flutter Crush',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
