import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_floating_action_button.dart';
import 'package:inventory_management_app_task/core/components/custom_search_bar.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/inventory/view/components/item_list_tile.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ScreenInventory extends ConsumerWidget {
  const ScreenInventory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemProvider = ref.watch(inventoryProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: CustomSearchBar(
                onSearch: (value) {
                  ref
                      .read(inventoryProvider.notifier)
                      .fetchAllItems(value.trim());
                },
              ),
            ),
            itemProvider.when(
              data: (itemList) {
                return itemList.isEmpty
                    ? Expanded(child: Center(child: Text('No item found')))
                    : ListView.builder(
                      shrinkWrap: true,
                      itemCount: itemList.length,
                      itemBuilder: (context, index) {
                        return ItemListTile(
                          index: index,
                          itemModel: itemList[index],
                        );
                      },
                    );
              },
              error: (error, stackTrace) {
                return Expanded(child: Center(child: Text(error.toString())));
              },
              loading:
                  () => Expanded(
                    child: const CircularProgressIndicator.adaptive(),
                  ),
            ),
          ],
        ),
        floatingActionButton: CustomFloatingActionButton(
          onPressed: () {
            context.push(AppRoutes.addOrUpdateItem);
          },
          text: "Add new item",
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
