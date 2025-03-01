
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/widgets/bottom_nav_bar.dart';
import 'package:inventory_management_app_task/feature/customers/view/screens/screen_customers.dart';
import 'package:inventory_management_app_task/feature/home/view/screens/screen_home.dart';
import 'package:inventory_management_app_task/feature/inventory/view/screens/screen_add_or_update_inventory.dart';
import 'package:inventory_management_app_task/feature/inventory/view/screens/screen_inventory.dart';
import 'package:inventory_management_app_task/feature/sales/view/screens/screen_sales.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.home,
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
              builder: (context, state) => const ScreenSales(),
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
    // GoRoute(
    //   path: '/customers',
    //   builder: (context, state) => const CustomersScreen(),
    // ),
    // GoRoute(
    //   path: '/customer_details',
    //   builder: (context, state) => const CustomerDetailsScreen(),
    // ),
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
