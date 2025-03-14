import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_floating_action_button.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/customer_report_export_menu.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/customer_tile.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/show_add_customer_dialog.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ScreenCustomers extends ConsumerWidget {
  const ScreenCustomers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers'),
        actions: [
          CustomerReportExportMenu(
            customers: ref.read(customerProvider).value!,
            sales: ref.read(salesProvider).value!,
          ),
        ],
      ),
      body: customerState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data:
            (customers) =>
                customers.isEmpty
                    ? const Center(child: Text('No customers available'))
                    : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: ListView.builder(
                        itemCount: customers.length,
                        itemBuilder: (context, index) {
                          final customer = customers[index];
                          return CustomerTile(
                            customer: customer,
                            onTap: () {
                              context.push(
                                AppRoutes.customersReport,
                                extra: customer,
                              );
                            },
                          );
                        },
                      ),
                    ),
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () async {
          showAddCustomerDialog(context, ref, null);
        },
        text: 'Add customer',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
