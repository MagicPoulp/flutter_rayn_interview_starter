import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state/game_view_state_container.dart';
import '../theme/theme.dart';
import '../reusable_components/assets.dart';

class MyGridCell extends StatelessWidget {
  MyGridCell({
    super.key,
    required this.cellPosition,
  });

  final GameViewStateContainer gameViewStateContainer = Get.find();
  final CellPosition cellPosition;

  @override
  Widget build(BuildContext context) {
    const borderWidth = 1.0;
    var top = const BorderSide(color: MyColorTheme.gridBorder, width: borderWidth);
    var left = const BorderSide(color: MyColorTheme.gridBorder, width: borderWidth);
    var bottom = cellPosition.row == 2 ? const BorderSide(color: MyColorTheme.gridBorder, width: borderWidth) : BorderSide.none;
    var right = cellPosition.col == 2 ? const BorderSide(color: MyColorTheme.gridBorder, width: borderWidth) : BorderSide.none;
    return GestureDetector(
        onTap: () {
          gameViewStateContainer.clickGridCell(cellPosition);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border(top: top, right: right, bottom: bottom, left: left)
            //border: Border.all(
            // color: MyColorTheme.gridBorder,
            //  width: 1.0,
            //),
          ),
          child: Center(
            child: SizedBox(
                width: 40,
                height: 40,
                child: GetX<GameViewStateContainer>(
                    builder: (_) {
                      var cellState = gameViewStateContainer.gridCells[cellPosition.row][cellPosition.col].value;
                      if (cellState == GridCellState.cross) {
                        // text spelling is corrected compared to the assignment, IN and not ON
                        return Container(child: crossImage);
                      }
                      if (cellState == GridCellState.circle) {
                        // text spelling is corrected compared to the assignment, IN and not ON
                        return Container(child: circleImage);
                      }
                      return Container(child: null);
                    }),
              // the Obx version below works too but with less performance than GetBuilder
              //child: Obx(() => Container(child: gameViewStateContainer.gridCells[cellPosition.row][cellPosition.col].value == GridCellState.empty ? null : (gameViewStateContainer.gridCells[cellPosition.row][cellPosition.col].value == GridCellState.cross ? crossImage : circleImage)))
            ),
          ),
        )
    );
  }
}

// inspired from:
// https://stackoverflow.com/questions/61568176/how-to-make-border-inside-gridview
class GameGridView extends StatelessWidget {
  GameGridView({
    super.key,
  });

  final GameViewStateContainer gameViewStateContainer = Get.find();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          // childAspectRatio: 1.0,
          children: List.generate(
            9, (index) => MyGridCell(cellPosition: CellPosition(col: index % 3, row: index ~/ 3)),
          ),
    );
  }
}
