import 'package:maingames_flutter_test/global.dart';
import 'package:flutter/material.dart';

mixin TextThemeMixin {
  TextTheme get textTheme => Theme.of(Global.context).textTheme;
}
