import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/screen_size.dart';
import 'package:inventory_management_app_task/routes/router.dart';

void main() {
  AppDependencies.setup();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //Initialize screen size
    AppScreenSize.initialize(context);
    return MaterialApp.router(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
      ),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
