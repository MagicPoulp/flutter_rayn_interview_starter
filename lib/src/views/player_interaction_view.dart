import 'package:flutter/material.dart';

import '../reusable_components/custom_button.dart';
import '../theme/theme.dart';

const _paddingValue = 8.0;

class PlayerInteractionView extends StatelessWidget {
  const PlayerInteractionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: _paddingValue * 2),),
          // text spelling is corrected compared to the assignment, IN and not ON
          //Text("No winner in this game", style: MyTextTheme.blueTextNoWinner),
          //TODO review ponctuation errors with the designers
          //Text("No winner in this game", style: MyTextTheme.blueTextNoWinner),
          //Text("Congratulation Player 2, you win !", style: MyTextTheme.redTextWinner),
          Text("Player 1 : Your Turn", style: MyTextTheme.closeToBlackText),
          const Padding(padding: EdgeInsets.symmetric(vertical: _paddingValue),),
          CustomButton(
            text: "New Game",
            onPressed: () { },
            backgroundColor: MyColorTheme.blueButton,
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: _paddingValue),),
          CustomButton(
            text: "Reset History",
            onPressed: () { },
            backgroundColor: MyColorTheme.redButton,
          )
        ]
    );
  }
}
