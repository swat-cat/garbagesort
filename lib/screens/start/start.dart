import 'package:flutter/material.dart';
import 'package:garbagesort/base/loading_state.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => new _StartScreenState();
}

class _StartScreenState extends LoadingBaseState<StartScreen> {

  @override
  Widget content() {
    return new Container(
      color: Colors.white,
      child:  new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Vinnitsa Garbage Sort Game",
              textAlign: TextAlign.center,
              style: new TextStyle(
                  color: Colors.blue,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            new Padding(padding: new EdgeInsets.only(bottom: 20.0)),
            new RaisedButton(
                child: new Text("Start Game"),
                onPressed: (){
                  Navigator.of(context).pushReplacementNamed("/game");
                }),
          ],
        ),
      ),
    );
  }


}
