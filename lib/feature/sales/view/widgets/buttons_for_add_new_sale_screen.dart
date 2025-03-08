// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/button_add_sale.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';
import 'package:realm/realm.dart';

class ButtonsForAddNewSaleScreen extends ConsumerWidget {
  final StateProvider<CustomerModel?> selectedCustomerProvider;

  const ButtonsForAddNewSaleScreen({
    super.key,
    required this.selectedCustomerProvider,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomAppBar(
      height: 85,
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: buttonAddSale(
              text: 'Save&New',
              haveBorder: true,
              btnColor: AppColors.transparent,
              onTap: () {
                addSale(context, ref); //Create new sale
                ref.read(selectedCustomerProvider.notifier).state =
                    null; //Resetting customer selection field
              },
            ),
          ),

          //Save
          Expanded(
            child: buttonAddSale(
              text: 'Save',
              onTap: () {
                addSale(context, ref).then((isSuccess) {
                  if (isSuccess) {
                    context.pop();
                  }
                }); //Create new sale
              },
            ),
          ),
        ],
      ),
      // : buttonAddSale(
      //   text: 'Ok',
      //   onTap: () async {
      //     Navigator.of(context).pop();
      //   },
      // ),
    );
  }

  Future<bool> addSale(BuildContext context, WidgetRef ref) async {
    final customerModel = ref.read(selectedCustomerProvider);
    if (customerModel == null) {
      showCustomSnackBar(context: context, content: 'Please select a customer');
      return false;
    }

    final customers = ref.read(customerProvider).value ?? [];
    if (!customers.contains(customerModel)) {
      showCustomSnackBar(
        context: context,
        content: 'Please select a valid customer',
      );
      return false;
    }

    final selectedSales = ref.read(selectedSaleItemProvider);
    if (selectedSales.isEmpty) {
      showCustomSnackBar(
        context: context,
        content: 'Please select items to sale',
      );
      return false;
    }
    final totalAmount = selectedSales.fold(
      0.0,
      (value, element) => value + (element.price * element.quantity),
    );
    final newSale = SalesModel(
      //Creating a saleModel with give datas
      ObjectId().toString(),
      customerModel.id,
      totalAmount,
      DateTime.now(),
      saleItems: selectedSales,
    );

    await ref.read(salesProvider.notifier).addSale(newSale); //Creating new sale
    ref.read(inventoryProvider.notifier).fetchAllItems();
    ref.read(selectedSaleItemProvider.notifier).state =
        []; //Resetting the selected items

    showCustomSnackBar(
      context: context,
      content: 'New sale added successfully',
      bgColor: AppColors.green,
    );

    return true;
  }
}

void showCustomSnackBar({
  required BuildContext context,
  required String content,
  Color bgColor = AppColors.red,
}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(content), backgroundColor: bgColor));
}
