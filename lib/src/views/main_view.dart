import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'game_view.dart';
import '../theme/theme.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  static const routeName = '/';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: Text('Tic Tac Toe',
            style: MyTextTheme.appBarText,
        ),
        centerTitle: true,
        backgroundColor: MyColorTheme.appBar
      ),
      backgroundColor: MyColorTheme.closeToWhiteBackground,
      body: const SizedBox(
        width: double.infinity,
        child: GameView(),
      )
    );
  }
}
