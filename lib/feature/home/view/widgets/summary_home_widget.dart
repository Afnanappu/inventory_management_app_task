import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/home/view/components/summary_card.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

class SummaryHomeWidget extends ConsumerWidget {
  const SummaryHomeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalSale = ref.watch(totalSalesProvider); //To get total sale amount
    final lowStockCount = ref.watch(
      lowStockItemProvider,
    ); //To get total sale amount
    final customer = ref.watch(customerProvider);

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SummaryCard(
              title: 'Total Sales',
              value: formatMoney(number: totalSale),
              icon: Icons.currency_rupee_outlined,
              color: AppColors.primary,
            ),
            SummaryCard(
              title: 'Low Stock Items',
              value: '$lowStockCount Items',
              icon: Icons.warning_amber_outlined,
              color: AppColors.error,
            ),
            SummaryCard(
              title: 'Customers',
              value: 'Total: ${customer.asData?.value.length ?? 0}',
              icon: Icons.people,
              color: AppColors.accent,
            ),
          ],
        ),
      ),
    );
  }
}
