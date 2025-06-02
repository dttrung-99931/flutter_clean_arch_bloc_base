import 'package:maingames_flutter_test/config/global.dart';
import 'package:flutter/material.dart';

mixin TextThemeMixin {
  TextTheme get textTheme => Theme.of(Global.context).textTheme;
}
