import 'package:flutter/material.dart';
import 'game.dart';
import 'garbage/type.dart';

abstract class GameView{
  Widget buildContent();
  Size getScreenSize();
  Widget generateGarbageItem(BoolCallback callbac, int fallTime);
  void deleteGarbageItem(Widget item);
  void showInfoPopup(String message);
  void returnToStart();
}

abstract class GamePresenter{
  VoidCallback initView(GameState state);
  void reinit();
}