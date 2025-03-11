import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

// enum SaleType { sales, purchase }

class TotalAmountSectionForSaleAddItemScreen extends ConsumerWidget {
  const TotalAmountSectionForSaleAddItemScreen({
    super.key,
    this.total,
    // required this.type,
  });
  final double? total;
  // final SaleType type;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleItemProvider = ref.watch(selectedSaleItemProvider);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Total Amount',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),

        //total amount price
        Container(
          constraints: const BoxConstraints(maxWidth: 180, minWidth: 100),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.textPrimary,
                style: BorderStyle.solid,
              ),
            ),
          ),
          child: ListTile(
            leading: const Text(
              '₹',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Text(
                    formatMoney(
                      number:
                          total != null
                              ? total!
                              : _findTotalAmount(saleItemProvider),
                      haveSymbol: false,
                    ),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

double _findTotalAmount(List<SaleItemModel> itemList) {
  double sum = 0;
  for (var item in itemList) {
    sum += item.quantity * item.price;
  }
  return sum;
}
