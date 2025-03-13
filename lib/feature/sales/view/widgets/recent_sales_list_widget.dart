import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/sale_list_tile.dart';

class RecentSalesListWidget extends StatelessWidget {
  const RecentSalesListWidget({
    super.key,
    required this.ref,
    required this.sales,
  });

  final WidgetRef ref;
  final List<SalesModel> sales;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: sales.length,
      itemBuilder: (context, index) {
        final saleModel = sales[index];
        final customerName =
            ref
                .read(customerProvider.notifier)
                .getCustomerById(saleModel.customerId)!
                .name;
        return SaleListTile(saleModel: saleModel, customerName: customerName);
      },
    );
  }
}
