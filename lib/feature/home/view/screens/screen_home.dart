
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/app_bar_for_main.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ScreenHome extends ConsumerWidget {
  const ScreenHome({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // debugPaintLayerBordersEnabled = true;
    // debugPaintSizeEnabled = true;

    return Scaffold(
      appBar: AppBarForMain(title: 'Home'),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              context.push(AppRoutes.customers);
            },
            child: Text('Customers'),
          ),
        ],
      ),
    );
  }
}
