import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/feature/inventory/view/components/item_list_tile.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ScreenInventory extends ConsumerWidget {
  const ScreenInventory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(inventoryProvider);
    return Scaffold(
      body: itemProvider.when(
        data: (itemList) {
          return itemList.isEmpty
              ? Center(child: Text('No item found'))
              : ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (context, index) {
                  return ItemListTile(index: index, itemModel: itemList[index]);
                },
              );
        },
        error: (error, stackTrace) {
          return Center(child: Text(error.toString()));
        },
        loading: () => const CircularProgressIndicator.adaptive(),
      ),
      floatingActionButton: ElevatedButton.icon(
        icon: Icon(Icons.add),
        onPressed: () {
          context.push(AppRoutes.addOrUpdateItem);
        },
        label: Text("Add new item"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
