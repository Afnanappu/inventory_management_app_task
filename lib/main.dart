import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:inventory_management_app_task/core/constants/screen_size.dart';
import 'package:inventory_management_app_task/feature/inventory/services/inventory_services.dart';
import 'package:inventory_management_app_task/routes/router.dart';

void main() {
  setup();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //Initialize screen size
    AppScreenSize.initialize(context);
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: Colors.grey[50]),
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<InventoryServices>(InventoryServices()); //
}
