import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_floating_action_button.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/sale_list_tile.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ScreenSales extends ConsumerWidget {
  const ScreenSales({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saleState = ref.watch(salesProvider);
    final customerNotifier = customerProvider.notifier;
    return SafeArea(
      child: Scaffold(
        body: saleState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
          data:
              (customers) =>
                  customers.isEmpty
                      ? const Center(child: Text('No sale available'))
                      : ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final sale = customers[index];
                          final customer = ref
                              .read(customerNotifier)
                              .getCustomerById(sale.customerId);
                          return SaleListTile(
                            saleModel: sale,
                            customerName: customer?.name ?? 'Customer',
                            // saleAddDate: sale.date,
                            // itemPrice: sale.totalAmount.toString(),
                            onTap: () {
                              context.push(
                                AppRoutes.addSale,
                                extra: {'isView': true, 'id': sale.id},
                              );
                            },
                          );
                        },
                      ),
        ),
        floatingActionButton: CustomFloatingActionButton(
          onPressed: () {
            context.push(AppRoutes.addSale, extra: {'isView': false});
          },
          text: 'Add new sale',
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
