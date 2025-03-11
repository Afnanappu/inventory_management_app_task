import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/services/user_services.dart';
import 'package:inventory_management_app_task/core/widgets/bottom_nav_bar.dart';
import 'package:inventory_management_app_task/feature/auth/view/screen/screen_login.dart';
import 'package:inventory_management_app_task/feature/customers/view/screens/screen_customers.dart';
import 'package:inventory_management_app_task/feature/home/view/screens/screen_home.dart';
import 'package:inventory_management_app_task/feature/inventory/view/screens/screen_add_or_update_inventory.dart';
import 'package:inventory_management_app_task/feature/inventory/view/screens/screen_inventory.dart';
import 'package:inventory_management_app_task/feature/sales/view/screens/screen_sale_add.dart';
import 'package:inventory_management_app_task/feature/sales/view/screens/screen_sales.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

final loginStatusProvider = StateProvider<bool>((ref) => false);

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation:
        AppRoutes.login, // Default starting point (will redirect if needed)
    // redirect: (context, state) async {
    //   // Check login status dynamically
    //   final isLoggedIn = true;
    //   // ProviderScope.containerOf(
    //   //   context,
    //   // ).read(loginStatusProvider);

    //   final String currentPath = state.matchedLocation;

    //   log('Redirect check: isLoggedIn=$isLoggedIn, currentPath=$currentPath');

    //   // If not logged in and trying to access a protected route, redirect to login
    //   if (!isLoggedIn && currentPath != AppRoutes.login) {
    //     return AppRoutes.login;
    //   }
    //   // If logged in and trying to access login, redirect to home
    //   if (isLoggedIn && currentPath == AppRoutes.login) {
    //     return AppRoutes.home;
    //   }
    //   // No redirect needed; proceed to the requested route
    //   return null;
    // },
    routes: [
      //Bottom Nav
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return Scaffold(
            body: navigationShell,
            bottomNavigationBar: BottomNavBar(
              selectedIndex: navigationShell.currentIndex,
            ),
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                builder: (context, state) => const ScreenHome(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.sales,
                builder: (context, state) => ScreenSales(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.inventory,
                builder: (context, state) => const ScreenInventory(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(
        path: AppRoutes.addOrUpdateItem,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;

          if (extra != null) {
            final isEdit = extra["isEdit"];
            final itemModel = extra["itemModel"];
            return ScreenAddOrUpdateInventory(
              isEdit: isEdit,
              itemModel: itemModel,
            );
          }
          return ScreenAddOrUpdateInventory();
        },
      ),
      GoRoute(
        path: AppRoutes.customers,
        builder: (context, state) => const ScreenCustomers(),
      ),
      GoRoute(
        path: AppRoutes.addSale,
        builder: (context, state) {
          final extra = (state.extra as Map<String, dynamic>);
          final isView = extra['isView'] as bool;
          final id = extra['id'] == null ? null : (extra['id']) as String;
          return ScreenSaleAdd(isView: isView, saleId: id);
        },
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => LoginScreen(),
      ),
      // GoRoute(
      //   path: '/sales_report',
      //   builder: (context, state) => const SalesReportScreen(),
      // ),
      // GoRoute(
      //   path: '/items_report',
      //   builder: (context, state) => const ItemsReportScreen(),
      // ),
      // GoRoute(path: '/export', builder: (context, state) => const ExportScreen()),
    ],
  );
}
