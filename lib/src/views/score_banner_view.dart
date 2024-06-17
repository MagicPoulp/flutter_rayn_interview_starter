import 'package:flutter/material.dart';

import '../theme/theme.dart';

// TODO use SVG assets and use the library flutter_svg so that images look better
var crossImage = Image.asset('assets/images/cross1.png');
var circleImage = Image.asset('assets/images/circle1.png');

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
                width: 40,
                height: 40,
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
  const ScoreBannerView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Expanded(
            flex:50,
            child: PlayerBadgeView(image: crossImage, name: 'Player 1', score: 1),
          ),
          Expanded(
            flex:50,
            child: PlayerBadgeView(image: circleImage, name: 'Player 2', score: 1),
          ),
        ]
    );
  }
}
