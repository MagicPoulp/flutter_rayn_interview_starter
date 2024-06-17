import 'package:get/get.dart';

class GameViewStateContainer extends GetxController {
  var count = 0.obs;
  increment() => count++;
}
