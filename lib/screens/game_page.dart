import 'package:flutter/material.dart';
import 'package:flutter_tac_tac_toe/components/field.dart';
import 'package:flutter_tac_tac_toe/model/gamestate.dart';
import 'package:flutter_tac_tac_toe/utils.dart';

class GamePage extends StatefulWidget {
  final String title;

  GamePage(this.title);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  List<int> board;
  int _currentPlayer;

  void _movePlayed(int idx) {
    setState(() {
      board[idx] = _currentPlayer;

      int evaluation = Utils.evaluateBoard(board);
      if (evaluation != GameState.NO_WINNERS_YET) {
        _onGameEnd(evaluation);
      }

      _currentPlayer = Utils.flipPlayer(_currentPlayer);
    });
  }

  void _onGameEnd(int winner) {
    Utils utils = Utils();
    var title = "Game over!";
    var content = "You lose :(";
    switch (winner) {
      case GameState.PLAYER_1: // will never happen :)
        title = "Congratulations!";
        content = "Player 1 wins";
        GameState.PLAYER_1_WINS = GameState.PLAYER_1_WINS + 1;
        utils.setPlayerWins(1, GameState.PLAYER_1_WINS);
        break;
      case GameState.PLAYER_2:
        title = "Game Over!";
        content = "Player 2 wins";
        GameState.PLAYER_2_WINS = GameState.PLAYER_2_WINS + 1;
        utils.setPlayerWins(2, GameState.PLAYER_2_WINS);
        break;
      default:
        title = "Draw!";
        content = "No winners here.";
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  setState(() {
                    reinitialize();
                    Navigator.of(context).pop();
                  });
                },
                child: Text("Restart"),
              )
            ],
          );
        });
  }

  String getSymbolForIndex(int index) {
    return GameState.SYMBOLS[board[index]];
  }

  @override
  void initState() {
    super.initState();
    reinitialize();
  }

  void reinitialize() {
    _currentPlayer = GameState.PLAYER_1;
    // generate the initial board
    board = List.generate(9, (idx) => 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(60),
            child: Text(
              "You are playing as " +
                  ((_currentPlayer == GameState.PLAYER_1)
                      ? GameState.SYMBOLS[GameState.PLAYER_1]
                      : GameState.SYMBOLS[GameState.PLAYER_2]),
              style: TextStyle(fontSize: 25),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              // generate the widgets that will display the board
              children: List.generate(9, (idx) {
                return Field(
                  idx: idx,
                  onTap: _movePlayed,
                  playerSymbol: getSymbolForIndex(idx),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
