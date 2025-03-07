import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:realm/realm.dart';

void showAddCustomerDialog(
  BuildContext context,
  WidgetRef ref,
  CustomerModel? customer,
) {
  final nameController = TextEditingController(text: customer?.name);
  final phoneController = TextEditingController(text: customer?.phone);
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          title: Text(
            customer == null ? 'Add Customer' : 'Update Customer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              style: TextButton.styleFrom(foregroundColor: Colors.grey[800]),
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final name = nameController.text.trim();
                final phone = phoneController.text.trim();
                if (name.isNotEmpty && phone.isNotEmpty) {
                  if (customer == null) {
                    //Creating new customer
                    ref
                        .read(customerProvider.notifier)
                        .addCustomer(
                          CustomerModel(ObjectId().toJson(), name, phone),
                        );
                  } else {
                    //Updating customer
                    ref
                        .read(customerProvider.notifier)
                        .updateCustomer(
                          CustomerModel(customer.id, name, phone),
                        );
                  }
                }
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.green,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                customer == null ? 'Add' : 'Update',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
  );
}
