import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:realm/realm.dart';

void showAddCustomerDialog(
  BuildContext context,
  WidgetRef ref,
  CustomerModel? customer,
) {
  final nameController = TextEditingController(text: customer?.name);
  final addressController = TextEditingController(text: customer?.address);
  final phoneController = TextEditingController(text: customer?.phone);
  final formKey = GlobalKey<FormState>();
  
  showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: AppColors.scaffoldBackground,
          title: Text(
            customer == null ? 'Add Customer' : 'Update Customer',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 10,
              children: [
                CustomTextFormField(
                  controller: nameController,
                  hintText: 'Name',
                  validator: (value) {
                    if (!CustomRegExp.checkName(value)) {
                      return 'Name is not valid';
                    }
                    return null;
                  },
                ),
                CustomTextFormField(
                  controller: addressController,
                  hintText: 'Address',
                  validator: (value) {
                    if (!CustomRegExp.checkName(value)) {
                      return 'Name is not valid';
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  controller: phoneController,
                  hintText: 'Phone',
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (!CustomRegExp.checkPhoneNumber(value)) {
                      return 'number is not valid';
                    }
                    return null;
                  },
                ),
              ],
            ),
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
                if (!formKey.currentState!.validate()) {
                  return;
                }
                final name = nameController.text.trim();
                final phone = phoneController.text.trim();
                final address = addressController.text.trim();
                if (name.isNotEmpty && phone.isNotEmpty) {
                  if (customer == null) {
                    //Creating new customer
                    ref
                        .read(customerProvider.notifier)
                        .addCustomer(
                          CustomerModel(
                            ObjectId().toJson(),
                            name,
                            address,
                            phone,
                          ),
                        );
                  } else {
                    //Updating customer
                    ref
                        .read(customerProvider.notifier)
                        .updateCustomer(
                          CustomerModel(customer.id, name, address, phone),
                        );
                  }
                }
                context.pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
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
