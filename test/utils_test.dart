import 'package:flutter_tac_tac_toe/model/gamestate.dart';
import 'package:flutter_tac_tac_toe/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('Check isBoardFull with full board and should be true', () {
    List<int> board = [1, -1, 1, 1, -1, -1, -1, 1, 1];

    bool isBoardFull = Utils.isBoardFull(board);

    expect(isBoardFull, true);
  });

  test('Check isBoardFull with partially filled board and should be false', () {
    List<int> board = [1, 0, 1, 1, -1, -1, -1, 1, 1];

    bool isBoardFull = Utils.isBoardFull(board);

    expect(isBoardFull, false);
  });

  test('Check isMoveLegal with legal move and should be true', () {
    List<int> board = [1, 0, 1, 1, -1, -1, -1, 1, 1];

    bool isMoveLegal = Utils.isMoveLegal(board, 1);

    expect(isMoveLegal, true);
  });

  test('Check isMoveLegal with illegal move in range and should be false', () {
    List<int> board = [1, 0, 1, 1, -1, -1, -1, 1, 1];

    bool isMoveLegal = Utils.isMoveLegal(board, 2);

    expect(isMoveLegal, false);
  });

  test('Check isMoveLegal with illegal move not in range and should be false',
      () {
    List<int> board = [1, 0, 1, 1, -1, -1, -1, 1, 1];

    bool isMoveLegal = Utils.isMoveLegal(board, -1);

    expect(isMoveLegal, false);
  });

  test('Check isMoveLegal with illegal move not in range and should be false',
      () {
    List<int> board = [1, 0, 1, 1, -1, -1, -1, 1, 1];

    bool isMoveLegal = Utils.isMoveLegal(board, 10);

    expect(isMoveLegal, false);
  });

  test('Check evaluateBoard with draw board and should be draw state', () {
    List<int> board = [1, -1, 1, 1, -1, -1, -1, 1, 1];

    int gameState = Utils.evaluateBoard(board);

    expect(gameState, GameState.DRAW);
  });

  test(
      'Check evaluateBoard with no winner incomplete board and should be draw state',
      () {
    List<int> board = [1, 0, 0, 1, -1, -1, -1, 1, 1];

    int gameState = Utils.evaluateBoard(board);

    expect(gameState, GameState.NO_WINNERS_YET);
  });

  test(
      'Check evaluateBoard with no winner empty board and should be draw state',
      () {
    List<int> board = [0, 0, 0, 0, 0, 0, 0, 0, 0];

    int gameState = Utils.evaluateBoard(board);

    expect(gameState, GameState.NO_WINNERS_YET);
  });

  test(
      'Check evaluateBoard with player 1 winner and should be player 1 winner state',
      () {
    List<int> board = [1, 1, 1, -1, -1, 1, -1, 0, 0];

    int gameState = Utils.evaluateBoard(board);

    expect(gameState, GameState.PLAYER_1);
  });

  test(
      'Check evaluateBoard with player 2 winner and should be player 2 winner state',
      () {
    List<int> board = [-1, -1, -1, 1, 1, -1, 1, 0, 0];

    int gameState = Utils.evaluateBoard(board);

    expect(gameState, GameState.PLAYER_2);
  });

  test('Check player with player 1 and should be player 2', () {
    int player = GameState.PLAYER_1;

    int flippedPlayer = Utils.flipPlayer(player);

    expect(flippedPlayer, GameState.PLAYER_2);
  });

  test('Check player with player 2 and should be player 1', () {
    int player = GameState.PLAYER_2;

    int flippedPlayer = Utils.flipPlayer(player);

    expect(flippedPlayer, GameState.PLAYER_1);
  });

  test('Check player 1 wins with 5 player wins and should return 5 wins',
      () async {
    SharedPreferences.setMockInitialValues({"PLAYER1": 5});
    Utils utils = Utils();
    Future<int> val = utils.getPlayerWins(1);
    val.then((wins) {
      expect(wins, 5);
    });
  });

  test('Check player 1 wins with no wins and should return 0 wins', () async {
    SharedPreferences.setMockInitialValues({});
    Utils utils = Utils();
    Future<int> val = utils.getPlayerWins(1);
    val.then((wins) {
      expect(wins, 0);
    });
  });
}
