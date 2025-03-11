import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_card.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu_button.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/font_styles.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class InventoryItemListTile extends ConsumerWidget {
  final int index;
  final InventoryItemModel itemModel;
  final void Function()? onTap;

  const InventoryItemListTile({
    super.key,
    required this.index,
    required this.itemModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(inventoryProvider.notifier);

    // Determine stock status color
    Color stockColor;
    if (itemModel.quantity > 10) {
      stockColor = AppColors.success;
    } else if (itemModel.quantity >= 1) {
      stockColor = AppColors.warning;
    } else {
      stockColor = AppColors.error;
    }

    return CustomCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Index/Avatar
            CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
              child: Text(
                '#${index + 1}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Item Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 18,
                        color: AppColors.accent, // Teal accent for icon
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          itemModel.name,
                          style: AppFontStyle.saleTile.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.store_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        itemModel.quantity >= 1
                            ? '${itemModel.quantity} in stock'
                            : 'Out of stock',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: stockColor, // Dynamic stock color
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        formatMoney(number: itemModel.price),
                        style: AppFontStyle.saleTile.copyWith(
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            CustomPopupMenuButton(
              onEditPressed: () {
                context.push(
                  AppRoutes.addOrUpdateItem,
                  extra: {"isEdit": true, "itemModel": itemModel},
                );
              },
              onDeletePressed: () {
                provider.deleteItem(itemModel.id);
              },
              title: 'item',
            ),
          ],
        ),
      ),
    );
  }
}
