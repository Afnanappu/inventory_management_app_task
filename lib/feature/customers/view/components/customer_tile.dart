import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu_button.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/show_add_customer_dialog.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';

class CustomerTile extends ConsumerWidget {
  final CustomerModel customer;
  final void Function()? onTap;

  const CustomerTile({super.key, required this.customer, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(customerProvider.notifier);
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        onTap: onTap,
        title: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            customer.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(
          customer.phone,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
        trailing: CustomPopupMenuButton(
          onEditPressed: () {
            showAddCustomerDialog(context, ref, customer);
          },
          onDeletePressed: () {
            provider.deleteCustomer(customer.id);
          }, title: 'customer',
        ),
      ),
    );
  }
}
