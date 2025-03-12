import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/screen_size.dart';
import 'package:inventory_management_app_task/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppDependencies.setup();

  // final container = ProviderContainer();
  // container.read(loginStatusProvider.notifier).state =
  //     await getIt.get<UserServices>().checkLoginStatus();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppScreenSize.initialize(context);
    // return FutureBuilder<bool>(
    //   future: getIt.get<UserServices>().checkLoginStatus(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const MaterialApp(
    //         home: Scaffold(body: Center(child: CircularProgressIndicator())),
    //       );
    //     }
    return MaterialApp.router(
      theme: ThemeData(scaffoldBackgroundColor: AppColors.scaffoldBackground),
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router,
    );
    //   },
    // );
  }
}
