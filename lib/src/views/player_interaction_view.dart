import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../reusable_components/custom_button.dart';
import '../theme/theme.dart';
import '../state/game_view_state_container.dart';

const _paddingValue = 8.0;

class PlayerInteractionView extends StatelessWidget {
  PlayerInteractionView({
    super.key,
  });

  final GameViewStateContainer gameViewStateContainer = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: _paddingValue)),
          // we set a constant size on the SizedBox
          // because different results have different font sizes
          SizedBox(
              height: 40.0,
              child: Center(
                child: GetX<GameViewStateContainer>(
                    builder: (_) {
                      if (gameViewStateContainer.isGameStuck.value) {
                        // text spelling is corrected compared to the assignment, IN and not ON
                        return Text("No winner in this game", style: MyTextTheme.blueTextNoWinner);
                      }
                      if (gameViewStateContainer.onePlayerWon.value) {
                        //TODO in the text, review punctuation errors with the designers
                        return Text("Congratulation Player ${gameViewStateContainer.winnerIndexIfWon}, you win !", style: MyTextTheme.redTextWinner);
                      }
                      return Text("Player ${gameViewStateContainer.whichPlayerShouldPlay.value} : Your Turn", style: MyTextTheme.closeToBlackText);
                    }),
              )
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: _paddingValue)),
          CustomButton(
            text: "New Game",
            onPressed: () { gameViewStateContainer.newGame(); },
            backgroundColor: MyColorTheme.blueButton,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: _paddingValue)),
          CustomButton(
            text: "Reset History",
            onPressed: () { gameViewStateContainer.resetHistory(); },
            backgroundColor: MyColorTheme.redButton,
          )
        ]
    );
  }
}
