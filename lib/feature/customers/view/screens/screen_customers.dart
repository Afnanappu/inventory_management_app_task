import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_floating_action_button.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/customer_tile.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/show_add_customer_dialog.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';

class ScreenCustomers extends ConsumerWidget {
  const ScreenCustomers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
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
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: CustomerTile(customer: customer),
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
