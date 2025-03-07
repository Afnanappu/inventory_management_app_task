import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

Widget saleAddItem({required void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: const Color.fromARGB(255, 228, 228, 228)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_rounded, color: AppColors.green),
          SizedBox(width: 10),
          Text('Add Items', style: TextStyle(color: AppColors.green)),
        ],
      ),
    ),
  );
}

class SaleAddItem extends ConsumerWidget {
  final Function(SaleItemModel) onItemAdded;

  const SaleAddItem({super.key, required this.onItemAdded});

  // Define providers outside the widget for proper scope
  static final selectedItemProvider = StateProvider<String?>((ref) => null);
  static final quantityProvider = StateProvider<String>((ref) => '1');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemsAsync = ref.watch(inventoryProvider);
    final selectedItem = ref.watch(selectedItemProvider);
    final quantity = ref.watch(quantityProvider);

    return Padding(
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
                color: Colors.blue[900],
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
            TextFormField(
              initialValue: quantity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                errorText:
                    int.tryParse(quantity) == null ? 'Invalid number' : null,
              ),
              onChanged: (value) {
                ref.read(quantityProvider.notifier).state =
                    value.isEmpty ? '0' : value;
              },
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
                          final item = itemsAsync.value!.firstWhere(
                            (i) => i.name == selectedItem,
                          );
                          final qty = int.parse(
                            quantity,
                          ); // Safe to parse since validated
                          final selectedModel = SaleItemModel(
                            item.id,
                            qty,
                            item.price,
                          );

                          ref.read(selectedSaleItemProvider.notifier).state = [
                            ...ref
                                .read(selectedSaleItemProvider.notifier)
                                .state,
                            selectedModel,
                          ];

                          Navigator.pop(context);
                          dev.log('Item added: $selectedModel');
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error adding item: $e')),
                          );
                        }
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
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
    );
  }
}
