import 'package:flutter_base_app/config/global.dart';
import 'package:flutter/material.dart';

mixin TextThemeMixin {
  TextTheme get textTheme => Theme.of(Global.context).textTheme;
}
