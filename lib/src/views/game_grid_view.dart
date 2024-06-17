import 'package:flutter/material.dart';

import '../theme/theme.dart';
import '../reusable_components/assets.dart';

class MyGridCell extends StatelessWidget {
  const MyGridCell({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: MyColorTheme.gridBorder,
          width: 0.7,
        ),
      ),
      child: Center(
        child: SizedBox(
            width: 40,
            height: 40,
            child: crossImage
        ),
      ),
    );
  }
}

// inspired from:
// https://stackoverflow.com/questions/61568176/how-to-make-border-inside-gridview
class GameGridView extends StatelessWidget {
  const GameGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          children: List.generate(
            9, (index) => const MyGridCell(),
          ),
    );
  }
}
