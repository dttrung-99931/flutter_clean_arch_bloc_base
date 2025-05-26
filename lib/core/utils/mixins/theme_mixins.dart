import 'package:base_project/global.dart';
import 'package:flutter/material.dart';

mixin TextThemeMixin {
  TextTheme get textTheme => Theme.of(Global.context).textTheme;
}
