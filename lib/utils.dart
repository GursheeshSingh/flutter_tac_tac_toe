import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/gamestate.dart';

class Utils {

  static SharedPreferences _preferences;

  static bool isBoardFull(List<int> board) {
    for (var val in board) {
      if (val == GameState.EMPTY_SPACE) return false;
    }

    return true;
  }

  static bool isMoveLegal(List<int> board, int move) {
    if (move < 0 ||
        move >= board.length ||
        board[move] != GameState.EMPTY_SPACE) return false;

    return true;
  }

  /// Returns the current state of the board [winning player, draw or no winners yet]
  static int evaluateBoard(List<int> board) {
    for (var list in GameState.WIN_CONDITIONS_LIST) {
      if (board[list[0]] !=
              GameState.EMPTY_SPACE && // if a player has played here AND
          board[list[0]] ==
              board[list[1]] && // if all three positions are of the same player
          board[list[0]] == board[list[2]]) {
        return board[list[0]];
      }
    }

    if (isBoardFull(board)) {
      return GameState.DRAW;
    }

    return GameState.NO_WINNERS_YET;
  }

  /// Returns the opposite player from the current one.
  static int flipPlayer(int currentPlayer) {
    return -1 * currentPlayer;
  }

  getSharePreferencesInstance() async {
    if(_preferences == null){
      _preferences = await SharedPreferences.getInstance();
    }
    return _preferences;
  }

  Future<int> getPlayerWins(int playerNumber) async {
    await getSharePreferencesInstance();
    if(_preferences.containsKey('PLAYER$playerNumber')){
      int intValue = _preferences.getInt('PLAYER$playerNumber') ?? 0;
      return intValue;
    } else {
      await setPlayerWins(playerNumber, 0);
      return 0;
    }
  }

  Future<bool> setPlayerWins(int playerNumber, int wins) async {
    try {
      await getSharePreferencesInstance();
      await _preferences.setInt('PLAYER$playerNumber', wins);
      return true;
    } catch (e) {
      return false;
    }
  }
}
