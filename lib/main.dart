import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/screen_size.dart';
import 'package:inventory_management_app_task/routes/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //Initialize screen size
    AppScreenSize.initialize(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
