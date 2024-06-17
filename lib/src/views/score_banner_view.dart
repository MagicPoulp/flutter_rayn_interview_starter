import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../state/game_view_state_container.dart';
import '../theme/theme.dart';
import '../reusable_components/assets.dart';

class PlayerBadgeView extends StatelessWidget {
  const PlayerBadgeView({
    super.key,
    required this.image, required this.name, required this.score,
  });
  final Image image;
  final String name;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
                width: 35,
                height: 35,
                child: image
            ),
          ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: MyTextTheme.closeToBlackTextBold,),
                Text(score.toString(), style: MyTextTheme.closeToBlackTextBold)
              ],
            ),
          ]
        )
    );
  }
}


class ScoreBannerView extends StatelessWidget {
  ScoreBannerView({
    super.key,
  });

  final GameViewStateContainer gameViewStateContainer = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex:50,
            child: Obx(() => PlayerBadgeView(image: crossImage, name: 'Player 1', score: gameViewStateContainer.scorePlayer1.value)),
          ),
          Expanded(
            flex:50,
            child: Obx(() => PlayerBadgeView(image: circleImage, name: 'Player 2', score: gameViewStateContainer.scorePlayer2.value)),
          ),
        ]
    );
  }
}
