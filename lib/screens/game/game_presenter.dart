import 'package:flutter/material.dart';
import 'game.dart';
import 'game_contract.dart';
import 'dart:async';

class GamePresenterImpl implements GamePresenter{

  GameState state;
  GameView view;

  final Duration timeout = const Duration(seconds: 3);

  GamePresenterImpl(this.view);

  Widget currItem;

  @override
  VoidCallback initView(GameState state) =>(){
    this.state = state;
    this.state.properties.score = 0;
    this.state.properties.maxCount = 50;
    this.state.properties.fallTime = 10;
    this.state.properties.level = 1;
    new Timer.periodic(timeout,(Timer t){
      reState((){
        view.generateGarbageItem((success){
          updateScore(success);
          view.deleteGarbageItem(currItem);
        },state.properties.fallTime);

      });
    });
  };

  void updateScore(bool success){
    if (success) {
      reState((){
        ++state.properties.score;
      });
    }
    else{
      reState((){
        --state.properties.score;
      });
    }
    checkLevel();
  }

  void checkLevel(){
    state.properties.maxCount --;
    if(state.properties.maxCount <= 0){
      state.properties.level++;
      state.properties.maxCount = 50;
      if (state.properties.fallTime>5) {
        state.properties.fallTime--;
      }
    }
    if(state.properties.score<0){
      new Timer(timeout, ()=> view.returnToStart());
      return;
    }
  }

  void reState(VoidCallback callback){
    state.setState(callback);
  }

  @override
  void reinit() {
    this.state.properties.score = 0;
    this.state.properties.maxCount = 50;
    this.state.properties.fallTime = 10;
    this.state.properties.level = 1;
  }


}