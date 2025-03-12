import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/custom_card.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu_button.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/font_styles.dart';
import 'package:inventory_management_app_task/core/utils/format_date.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/sale_badge.dart';

class SaleListTile extends StatelessWidget {
  final SalesModel saleModel; // Using the Realm model
  final String customerName; // Assuming this is passed from parent widget
  final void Function()? onTap;
  final void Function()? onEdit; // Optional edit callback
  final void Function()? onDelete; // Optional delete callback

  const SaleListTile({
    super.key,
    required this.saleModel,
    required this.customerName,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Sale Icon/Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryLight.withValues(alpha: 0.2),
              child: Icon(
                Icons.receipt_long_outlined,
                size: 24,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 12),

            // Sale Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 18,
                        color: AppColors.accent, // Teal for customer
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          customerName,
                          style: AppFontStyle.saleTile.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SaleBadge(
                        color: AppColors.success.withValues(alpha: 0.2),
                        text: 'SALE',
                        textColor: AppColors.success,
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        formatDateTime(date: saleModel.date),
                        style: AppFontStyle.smallLightGrey,
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${saleModel.saleItems.length} item${saleModel.saleItems.length != 1 ? 's' : ''}',
                        style: AppFontStyle.smallLightGrey,
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.currency_rupee_sharp,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '\$${saleModel.totalAmount.toStringAsFixed(2)}',
                        style: AppFontStyle.saleTile,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions (Optional)
            if (onEdit != null || onDelete != null)
              CustomPopupMenuButton(
                onEditPressed: onEdit!,
                onDeletePressed: onDelete!,
                title: 'sale',
              ),
          ],
        ),
      ),
    );
  }
}
