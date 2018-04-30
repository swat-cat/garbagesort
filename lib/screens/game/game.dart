import 'package:flutter/material.dart';
import 'game_contract.dart';
import 'game_state_properties.dart';
import 'game_view.dart';
import 'game_presenter.dart';
import 'package:garbagesort/base/loading_state.dart';

class Game extends StatefulWidget {
  @override
  GameState createState() => new GameState();
}

class GameState extends LoadingBaseState<Game> {

  GameView view;
  GameStateProperties properties;
  GamePresenter presenter;


  @override
  void initState() {
    super.initState();
    properties = new GameStateProperties();
    view = new GameViewImpl(properties,context);
    presenter = new GamePresenterImpl(view);
    presenter.initView(this)();
  }

  @override
  Widget content() {
    return view.buildContent();
  }

  @override
  void dispose() {
    presenter.reinit();
  }


}
