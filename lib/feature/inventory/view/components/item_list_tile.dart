import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu_button.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/font_styles.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ItemListTile extends ConsumerWidget {
  final int index;
  final InventoryItemModel itemModel;
  final void Function()? onTap;

  const ItemListTile({
    super.key,
    required this.index,
    required this.itemModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(inventoryProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,

          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  itemModel.name,
                  style: AppFontStyle.saleTile,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              CustomPopupMenuButton(
                onEditPressed: () {
                  context.push(
                    AppRoutes.addOrUpdateItem,
                    extra: {"isEdit": true, "itemModel": itemModel},
                  );
                }, 
                onDeletePressed: () {
                  // provider to delete the item
                  provider.deleteItem(itemModel.id);
                },
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (itemModel.quantity >= 1)
                    ? '${itemModel.quantity} in stock'
                    : 'Out of stock',
                style: TextStyle(
                  color:
                      (itemModel.quantity > 10)
                          ? AppColors.green
                          : AppColors.red,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                formatMoney(number: itemModel.price),
                style: AppFontStyle.saleTile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
