import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state/game_view_state_container.dart';
import 'score_banner_view.dart';
import 'game_grid_view.dart';
import 'player_interaction_view.dart';

class GameView extends StatelessWidget {
  const GameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    final GameViewStateContainer mainStateContainer = Get.put(GameViewStateContainer());

    return Container(
        margin: const EdgeInsets.all(4),
        child: const Column(
            children: [
              ScoreBannerView(),
              GameGridView(),
              PlayerInteractionView()
            ]
      )
    );
  }
}
