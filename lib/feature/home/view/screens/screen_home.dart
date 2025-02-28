import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/app_bar_for_main.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarForMain(title: 'Home'),
      body: Center(child: Text('Home')),
    );
  }
}
