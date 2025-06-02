// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:maingames_flutter_test/core/utils/app_colors.dart';
import 'package:maingames_flutter_test/core/utils/extensions/ui_extensions.dart';
import 'package:maingames_flutter_test/config/theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Payment Page',
            style: textTheme.titleMedium?.withColor(AppColors.white),
          ),
        ),
        body: const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text('Home Screen'),
            )),
      ),
    );
  }
}
