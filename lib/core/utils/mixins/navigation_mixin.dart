import 'package:base_project/global.dart';
import 'package:flutter/material.dart';

mixin NavigationMixin {
  NavigatorState get navigator => Global.globalKey.currentState!;
}
