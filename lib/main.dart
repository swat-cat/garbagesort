import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/game/game.dart';
import 'screens/start/start.dart';

void main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new StartScreen(),
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes:  <String, WidgetBuilder> {
        "/start":(BuildContext context)=> new StartScreen(),
        "/game":(BuildContext context) => new Game()
      },
    );
  }
}