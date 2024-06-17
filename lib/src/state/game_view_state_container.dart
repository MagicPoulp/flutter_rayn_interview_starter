import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math';

enum GridCellState { empty, cross, circle }

class CellPosition {
  CellPosition({ required this.row, required this.col });

  final int row;
  final int col;
}

class GameViewStateContainer extends GetxController {
  GameViewStateContainer() {
    retrieveHistoryData();
  }

  var whichPlayerShouldPlay = 1.obs;
  var lastStartingPlayer = 1;
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
    storeHistoryData();
  }

  // TODO we can improve game stuck detection. Currenbtly we only detect stuck games that have no empty cells
  // TODO we could guess in advance if no more scenarios can lead to winning
  // TODO for example if there is only one or 2 empty cells, there are scnearios that are stuck and that we do not detect yet
  void detectWinOrStuck() {
    getPlayerFromStateImage(GridCellState state) => state == GridCellState.cross ? 1 : 2;

    // check diagonals
    // if the center is not empty, and a diagonal is equal
    if (gridCells[1][1].value != GridCellState.empty && ((gridCells[0][0].value == gridCells[1][1].value && gridCells[0][0].value == gridCells[2][2].value)
    || (gridCells[2][0].value == gridCells[1][1].value && gridCells[2][0].value == gridCells[0][2].value))) {
      int winnerPlayer = getPlayerFromStateImage(gridCells[1][1].value);
      declareWinner(winnerPlayer);
      return;
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
    eraseHistoryData();
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
    if (onePlayerWon.value || isGameStuck.value) {
      // 1 and 2 are permuted
      whichPlayerShouldPlay.value = 3 - lastStartingPlayer;
      lastStartingPlayer = 3 - lastStartingPlayer;
    }
    onePlayerWon.value = false;
    isGameStuck.value = false;
  }

  int randomNumberZeroOrOne() {
    Random random = Random(DateTime.now().millisecondsSinceEpoch);
    return random.nextInt(2); // from 0 up to 1 included
  }

  void eraseHistoryData() {
    final box = GetStorage();
    box.erase();
  }

  void storeHistoryData() {
    final box = GetStorage();
    box.write('scorePlayer1', scorePlayer1.value);
    box.write('scorePlayer2', scorePlayer2.value);
    box.write('lastStartingPlayer', lastStartingPlayer);
    // get_storage is very lightweight and simple (less memory than a database)
    // but a database like SQLite or Realm could be more powerful (for real queries)
    /*
    // we could add all variables below in this data storage
    var whichPlayerShouldPlay = 1.obs;
    var scorePlayer1 = 0.obs;
    var scorePlayer2 = 0.obs;
    List<List<Rx<GridCellState>>> gridCells
    var onePlayerWon = false.obs;
    var winnerIndexIfWon = 1;
    var isGameStuck = false.obs;*/
  }

  void retrieveHistoryData() {
    final box = GetStorage();
    getValue(String key, Function fun) {
      var dyn = box.read(key);
      // key is not found
      if (dyn.runtimeType == Null) {
        return;
      }
      fun(dyn);
    }
    getValue('scorePlayer1', (dynamic dyn) { scorePlayer1.value = dyn; });
    getValue('scorePlayer2', (dynamic dyn) { scorePlayer2.value = dyn; });
    getValue('lastStartingPlayer', (dynamic dyn) { lastStartingPlayer = dyn; });
  }
}
