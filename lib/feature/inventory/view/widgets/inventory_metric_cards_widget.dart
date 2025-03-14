import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/metric_card.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_metrics.dart';

class InventoryMetricCardsWidget extends StatelessWidget {
  const InventoryMetricCardsWidget({super.key, required this.metrics});

  final InventoryMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              MetricCard(
                title: 'Total Items',
                value: metrics.totalItems.toString(),
                icon: Icons.inventory_2_outlined,
                color: AppColors.accent,
              ),
              const SizedBox(width: 16),
              MetricCard(
                title: 'Total Quantity',
                value: metrics.totalQuantity.toString(),
                icon: Icons.category_outlined,
                color: AppColors.primaryDark,
              ),
            ],
          ),
          const SizedBox(height: 16),
          MetricCard(
            title: 'Total Inventory Value',
            value: formatMoney(number: metrics.totalValue),
            icon: Icons.attach_money,
            color: AppColors.primaryDark,
            // fullWidth: true,
          ),
        ],
      ),
    );
  }
}
