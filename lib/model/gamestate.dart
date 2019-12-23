class GameState {

  // evaluation condition values
  static const int PLAYER_1 = 1;
  static const int PLAYER_2 = -1;
  static const int NO_WINNERS_YET = 0;
  static const int DRAW = 2;
  static const int EMPTY_SPACE = 0;

  static const WIN_CONDITIONS_LIST = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  static const SYMBOLS = {EMPTY_SPACE: "", PLAYER_1: "X", PLAYER_2: "O"};

  static int PLAYER_1_WINS;
  static int PLAYER_2_WINS;
}