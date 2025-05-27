import 'package:maingames_flutter_test/global.dart';
import 'package:flutter/material.dart';

mixin NavigationMixin {
  NavigatorState get navigator => Global.globalKey.currentState!;
}
