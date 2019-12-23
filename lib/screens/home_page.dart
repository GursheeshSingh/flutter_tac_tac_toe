import 'package:flutter/material.dart';
import 'package:flutter_tac_tac_toe/model/gamestate.dart';
import 'package:flutter_tac_tac_toe/utils.dart';

import 'game_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _player1Wins = 0;
  int _player2Wins = 0;

  @override
  void initState() {
    super.initState();

    _updateScores();
  }

  _updateScores() {
    Utils utils = Utils();

    Future<int> val = utils.getPlayerWins(1);
    val.then((value) {
      _player1Wins = value;
      GameState.PLAYER_1_WINS = value;
      print('VALUE 1: ' + value.toString());
    });

    val = utils.getPlayerWins(2);
    val.then((value) {
      GameState.PLAYER_2_WINS = value;
      _player2Wins = value;
      print('VALUE 2: ' + value.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "Welcome to Flutter Tic Tac Toe!",
            style: TextStyle(fontSize: 20),
          ),
          Center(
            child: ButtonTheme(
              minWidth: 200,
              height: 80,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.amber, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                ),
                color: Colors.amber,
                onPressed: () async {
                  await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => GamePage(widget.title)));
                  _updateScores();
                },
                child: Text(
                  "New game!",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                  'Player 1 wins: ' +
                      ((_player1Wins == 0) ? "-" : _player1Wins.toString()),
                  style: TextStyle(fontSize: 15)),
              SizedBox(
                width: 60,
              ),
              Text(
                  'Player 2 wins: ' +
                      ((_player2Wins == 0) ? "-" : _player2Wins.toString()),
                  style: TextStyle(fontSize: 15)),
            ],
          )
        ],
      ),
    );
  }
}
