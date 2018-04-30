import 'package:flutter/material.dart';
import 'game_contract.dart';
import 'game_state_properties.dart';
import 'garbage/garbage_item.dart';
import 'garbage/type.dart';
import 'dart:math';
import 'package:garbagesort/base/dialog_shower.dart' as DialogShower;
import 'package:garbagesort/screens/start/start.dart';

class GameViewImpl extends GameView{

  GameStateProperties properties;
  BuildContext context;

  Widget wetContainerWidget;
  Widget dryContainerWidget;

  List<GarbageItem> garbage = new List();

  GameViewImpl(this.properties, this.context);


  @override
  Widget buildContent() {
    return new Container(
      color: Colors.white,
      child: new Stack(
        children: content()
      ),
    );
  }

  List<Widget> content(){
    List<Widget> list = new List();
    list.add(garbageContainers());
    list.add(score());
    list.add(level());
    list.add(gameOver());
    list.addAll(garbage);
    return list;
  }
  Widget gameOver(){
    return properties.score<0?new Align(
      alignment: Alignment.center,
      child: new Container(
        alignment: new Alignment(0.5, 0.5),
        height: 50.0,
        width: 75.0,
        margin: const EdgeInsets.only(left: 75.0,right: 75.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: new BoxDecoration(
            borderRadius: new BorderRadius.all(const Radius.circular(4.0)),
            border: new Border.all(color: Colors.grey)),
        child: new Text("Game Over",
          textAlign: TextAlign.center,
        ),
      ),
    ):new Container();
  }

  Widget garbageContainers(){
    return new Align(
      alignment: Alignment.bottomCenter,
      child: new Container(
        height: 100.0,
        child: new Row(
          children: <Widget>[
            wetContainer(),
            dryContainer()
          ],
        ),
      ),
    );
  }

  Widget level(){
    return new Positioned(
        top: 30.0,
        left: getScreenSize().width - 80.0,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("Level: ",
              style: new TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            new Text(properties.level.toString(),
              style: new TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
        ));
  }

  Widget score(){
    return new Positioned(
        top: 30.0,
        left: 15.0,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Text("Score: ",
              style: new TextStyle(
                color: Colors.blueGrey,
                fontSize: 15.0,
                fontWeight: FontWeight.bold
              ),
            ),
            new Text(properties.score.toString(),
              style: new TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
          ],
    ));
  }

  Widget wetContainer(){
    wetContainerWidget =  new Expanded(child: new Container(
      color: Colors.green,
    ));
    return wetContainerWidget;
  }

  Widget dryContainer(){
    dryContainerWidget = new Expanded(child: new Container(
      color: Colors.yellow,
    ));
    return dryContainerWidget;
  }

  @override
  Size getScreenSize() => MediaQuery.of(context).size;

  @override
  Widget generateGarbageItem(BoolCallback callback,int fallTime) {
    double end = getScreenSize().height-125.00;
    Random r = new Random();
    int x = r.nextInt(getScreenSize().width.round());
    bool wet = r.nextBool();
    print("End: "+end.toString());
    Widget item = new GarbageItem(new Offset(x.toDouble(), 80.0), wet?GarbageType.WET:GarbageType.DRY, "", fallTime, end, callback);
    garbage.add(item);
    return item;
  }

  @override
  void deleteGarbageItem(Widget item) {
    if(garbage.contains(item)){
      garbage.remove(item);
    }
  }

  @override
  void showInfoPopup(String message){
    var dialog = DialogShower.buildDialog(
        message: message,
        confirm: "OK",
        confirmFn: () => Navigator.pop(context));
    showDialog(context: context, child: dialog);
  }

  @override
  void returnToStart() {
    MaterialPageRoute route = new MaterialPageRoute(builder: (BuildContext c)=> new StartScreen());
    Navigator.of(context).pushAndRemoveUntil(route,(route)=>true);
  }
  
}