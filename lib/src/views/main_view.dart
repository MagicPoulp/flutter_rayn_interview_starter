import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'game_view.dart';

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
            style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.secondary
      ),
      body: const GameView(),
    );
  }
}
