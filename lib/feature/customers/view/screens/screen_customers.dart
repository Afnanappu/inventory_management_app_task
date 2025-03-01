import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu_button.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:realm/realm.dart';

class ScreenCustomers extends ConsumerWidget {
  const ScreenCustomers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerState = ref.watch(customerProvider);

    return Scaffold(
      //TODO: change ui
      appBar: AppBar(title: const Text('Customers')),
      body: customerState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
        data:
            (customers) =>
                customers.isEmpty
                    ? const Center(child: Text('No customers available'))
                    : ListView.builder(
                      itemCount: customers.length,
                      itemBuilder: (context, index) {
                        final customer = customers[index];
                        return ListTile(
                          title: Text(customer.name),
                          subtitle: Text(customer.phone),
                          trailing: CustomPopupMenuButton(
                            onEditPressed: () {}, //TODO: add edit option
                            onDeletePressed: () {
                              ref
                                  .read(customerProvider.notifier)
                                  .deleteCustomer(customer.id);
                            },
                          ),
                        );
                      },
                    ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Example: Adding a dummy customer for testing
          final newCustomer = CustomerModel(
            ObjectId().toString(),
            'John Doe',
            '9947907247',
          );
          await ref.read(customerProvider.notifier).addCustomer(newCustomer);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
