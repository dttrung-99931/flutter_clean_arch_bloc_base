import 'package:flutter/material.dart';

import 'screen_test_app.dart';

class MaingamesWidgetTestApp extends StatelessWidget {
  const MaingamesWidgetTestApp({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext _) {
    return MaingamesScreenTestApp(screen: Scaffold(body: widget));
  }
}
