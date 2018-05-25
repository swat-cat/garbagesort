import 'dart:math';

import 'package:flutter/material.dart';
import 'type.dart';

class GarbageItem extends StatefulWidget {
  final Offset initPos;
  final GarbageType type;
  final String image;
  int fallSpeed;
  double end;
  BoolCallback callback;


  GarbageItem(this.initPos, this.type, this.image, this.fallSpeed, this.end,
      this.callback);

  @override
  _GarbageItemState createState() => new _GarbageItemState();
}

class _GarbageItemState extends State<GarbageItem> with TickerProviderStateMixin {
  Offset position = new  Offset(0.0, 0.0);
  bool isDrugging;
  Size size;

  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    position = widget.initPos;
    size = new Size(50.0, 50.0);
    isDrugging = false;
    controller = new AnimationController(vsync: this, duration: new Duration(seconds: widget.fallSpeed));
    animation = new Tween(begin: widget.initPos.dy, end: widget.end).animate(
      new CurvedAnimation(
        parent: controller,
        curve:Curves.easeIn,
      ),
    );
    controller.forward();
    controller.addListener((){
      setState((){});
    });
    controller.addStatusListener((status){
      if(status == AnimationStatus.completed){
        double mediana = MediaQuery.of(context).size.width/2;
        bool success = false;
        if(widget.type == GarbageType.WET){
          success = position.dx<=mediana;
        }
        else{
          success = position.dx>mediana;
        }
        widget.callback(success);
        setState(()=> size = new Size(0.0, 0.0));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Positioned(
        left: position.dx,
        top: animation.value,
        child: new Transform(
            transform: new Matrix4.translationValues(0.0, 0.0, 0.0),
            child: new GestureDetector(
              child: new Image(
                image: AssetImage(widget.image),
                width: size.width,
                height: size.height,
              ),
              onHorizontalDragStart: (dragStartDetails){
                controller.stop(canceled: false);
              },
              onHorizontalDragEnd: (dragEndDetails){
                controller.forward();
              },
              onHorizontalDragUpdate: (dragUpdateDetails){
                setState((){
                  print("Global: "+dragUpdateDetails.globalPosition.toString()+" Delta: "+dragUpdateDetails.delta.toString());
                  position = new Offset(dragUpdateDetails.globalPosition.dx, position.dy);
                });
              },
            )
        )
    );
  }
}
