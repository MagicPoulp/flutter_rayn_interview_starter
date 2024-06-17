import 'package:get/get.dart';
import 'dart:math';

enum GridCellState { empty, cross, circle }

class CellPosition {
  CellPosition({ required this.row, required this.col });

  final int row;
  final int col;
}

class GameViewStateContainer extends GetxController {
  GameViewStateContainer() {
    resetHistory();
  }
  var whichPlayerShouldPlay = 1.obs;
  var scorePlayer1 = 0.obs;
  var scorePlayer2 = 0.obs;
  List<List<Rx<GridCellState>>> gridCells =  List.generate(
    3, (index) => List.generate(
        3, (index2) => GridCellState.empty.obs,
      ),
  );
  var onePlayerWon = false.obs;
  var winnerIndexIfWon = 1;
  var isGameStuck = false.obs;

  incrementScorePlayer1() => scorePlayer1++;
  incrementScorePlayer2() => scorePlayer2++;

  void clickGridCell(CellPosition cellPosition) {
    if (isGameStuck.value || onePlayerWon.value) {
      return;
    }
    if (gridCells[cellPosition.row][cellPosition.col].value == GridCellState.empty) {
      if (whichPlayerShouldPlay.value == 1) {
        gridCells[cellPosition.row][cellPosition.col].value = GridCellState.cross;
      }
      else {
        gridCells[cellPosition.row][cellPosition.col].value = GridCellState.circle;
      }
    }
    // 1 and 2 are permuted
    whichPlayerShouldPlay.value = 3 - whichPlayerShouldPlay.value;
    detectWinOrStuck();
  }

  void detectWinOrStuck() {
    getPlayerFromStateImage(GridCellState state) => state == GridCellState.cross ? 1 : 2;

    // check diagonals
    // if the center is not empty, and a diagonal is equal
    if (gridCells[1][1].value != GridCellState.empty && ((gridCells[0][0].value == gridCells[1][1].value && gridCells[0][0].value == gridCells[2][2].value)
    || (gridCells[2][0].value == gridCells[1][1].value && gridCells[2][0].value == gridCells[0][2].value))) {
      int winnerPlayer = getPlayerFromStateImage(gridCells[1][1].value);
      declareWinner(winnerPlayer);
    }

    bool found = checkInOneDirection(isInverted: false);
    if (found) {
      return;
    }
    found = checkInOneDirection(isInverted: true);
    if (found) {
      return;
    }
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        // if a cell is empty, the game is not finished
        if (gridCells[i][j].value == GridCellState.empty) {
          return;
        }
      }
    }
    declareStuckGame();
  }

  bool checkInOneDirection({required bool isInverted}) {
    getPlayerFromStateImage(GridCellState state) => state == GridCellState.cross ? 1 : 2;
    getAt(int row, int col, bool isInverted) => isInverted ? gridCells[col][row] : gridCells[row][col];

    for (int i = 0; i < 3; i++) {
      // if one cell is empty we cannot have a row or a column
      if (getAt(i, 0, isInverted).value == GridCellState.empty) {
        continue;
      }
      int numEqualities = 0;
      for (int j = 1; j < 3; j++) {
        if (getAt(i, j, isInverted).value == getAt(i, 0, isInverted).value) {
          numEqualities++;
        }
      }
      if (numEqualities == 2) {
        int winnerPlayer = getPlayerFromStateImage(getAt(i, 0, isInverted).value);
        declareWinner(winnerPlayer);
        return true;
      }
    }
    return false;
  }

  void declareWinner(int winnerPlayer) {
    onePlayerWon.value = true;
    winnerIndexIfWon = winnerPlayer;
    if (winnerPlayer == 1) {
      incrementScorePlayer1();
    }
    else {
      incrementScorePlayer2();
    }
  }

  void declareStuckGame() {
    isGameStuck.value = true;
  }

  void resetHistory() {
    whichPlayerShouldPlay.value = randomNumberZeroOrOne() + 1;
    scorePlayer1.value = 0;
    scorePlayer2.value = 0;
    clearGrid();
    onePlayerWon.value = false;
    isGameStuck.value = false;
  }

  void clearGrid() {
    for (int i = 0; i<3; i++) {
      for (int j = 0; j<3; j++) {
        gridCells[i][j].value =  GridCellState.empty;
      }
    }
  }

  void newGame() {
    clearGrid();
    onePlayerWon.value = false;
    isGameStuck.value = false;
    // 1 and 2 are permuted
    whichPlayerShouldPlay.value = 3 - whichPlayerShouldPlay.value;
  }

  int randomNumberZeroOrOne() {
    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    return random.nextInt(2); // from 0 up to 1 included
  }
}
