import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';
import 'package:realm/realm.dart';

Widget saleAddItem({required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        border: Border.all(color: const Color.fromARGB(255, 228, 228, 228)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_rounded, color: AppColors.primary),
          SizedBox(width: 10),
          Text('Add Items', style: TextStyle(color: AppColors.primary)),
        ],
      ),
    ),
  );
}

class SaleAddItem extends ConsumerWidget {
  const SaleAddItem({super.key});

  // Define providers outside the widget for proper scope
  static final selectedItemProvider = StateProvider<String?>((ref) => null);
  static final quantityProvider = StateProvider<String>((ref) => '1');
  static final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryProvider);
    final selectedItem = ref.watch(selectedItemProvider);
    final quantity = ref.watch(quantityProvider);
    final saleItems = ref.watch(selectedSaleItemProvider);

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(quantityProvider.notifier).state = '1'; //resetting the value
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Item',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              // Handle loading and error states for inventory
              itemsAsync.when(
                data:
                    (items) => DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Select Item',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      value: selectedItem,
                      items:
                          items.map((item) {
                            return DropdownMenuItem<String>(
                              value: item.name,
                              child: Text(item.name),
                            );
                          }).toList(),
                      onChanged: (value) {
                        ref.read(selectedItemProvider.notifier).state = value;
                      },
                    ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Text('Error: $error'),
              ),
              const SizedBox(height: 20),
              Form(
                key: formKey,
                child: TextFormField(
                  initialValue: quantity,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    errorText:
                        int.tryParse(quantity) == null
                            ? 'Invalid number'
                            : null,
                  ),
                  onChanged: (value) {
                    ref.read(quantityProvider.notifier).state =
                        value.isEmpty ? '0' : value;
                  },
                  validator: (value) {
                    //
                    final item = itemsAsync.value!.firstWhere(
                      (i) => i.name == selectedItem,
                    );

                    final qty = int.parse(
                      quantity,
                    ); // Safe to parse since validated
                    final alreadySelectedQty = saleItems
                        .where((element) => element.productId == item.id)
                        .fold(
                          0,
                          (previousValue, element) =>
                              element.quantity + previousValue,
                        );
                    dev.log(alreadySelectedQty.toString());
                    final itemQty = item.quantity - alreadySelectedQty;

                    dev.log('if($qty > $itemQty: ${qty > itemQty})');
                    if (qty > itemQty) {
                      return 'Insufficient item, current item quantity: $itemQty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed:
                    selectedItem == null ||
                            int.tryParse(quantity) == null ||
                            int.parse(quantity) <= 0
                        ? null // Disable button if conditions aren't met
                        : () {
                          try {
                            if (!formKey.currentState!.validate()) {
                              return;
                            }
                            final item = itemsAsync.value!.firstWhere(
                              (i) => i.name == selectedItem,
                            );
                            final qty = int.parse(
                              quantity,
                            ); // Safe to parse since validated

                            final selectedModel = SaleItemModel(
                              ObjectId().toString(),
                              item.id,
                              qty,
                              item.price,
                            );

                            //If same sale item exist, override the old one with new quantify
                            if (saleItems.any(
                              (element) => element.productId == item.id,
                            )) {
                              ref
                                  .read(selectedSaleItemProvider.notifier)
                                  .state = saleItems
                                      .map(
                                        (e) =>
                                            e.productId ==
                                                    selectedModel.productId
                                                ? e.copyWith(
                                                  quantity:
                                                      selectedModel.quantity +
                                                      e.quantity,
                                                )
                                                : e,
                                      )
                                      .toList();
                            } else {
                              ref
                                  .read(selectedSaleItemProvider.notifier)
                                  .state = [...saleItems, selectedModel];
                            }

                            context.pop();
                            dev.log('Item added: $selectedModel');
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error adding item: $e')),
                            );
                          }
                        },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
                child: const Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
