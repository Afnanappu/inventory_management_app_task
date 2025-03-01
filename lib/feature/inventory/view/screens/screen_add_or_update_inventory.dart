import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:realm/realm.dart';

class ScreenAddOrUpdateInventory extends ConsumerWidget {
  ScreenAddOrUpdateInventory({super.key, this.isEdit = false, this.itemModel});

  final bool isEdit;
  final InventoryItemModel? itemModel;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _quantityController = TextEditingController();
  final _priceController = TextEditingController();

  void _saveItem(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState!.validate()) {
      final newItem = InventoryItemModel(
        isEdit
            ? itemModel!.id
            : ObjectId()
                .toString(), //assigning Id based on newItem or updateItem
        _nameController.text,
        _descriptionController.text,
        int.parse(_quantityController.text),
        double.parse(_priceController.text),
      );

      if (isEdit) {
        // Here you would typically pass this back or save to your data source
        await ref.read(inventoryProvider.notifier).updateItem(newItem);
      } else {
        // Here you would typically pass this back or save to your data source
        await ref.read(inventoryProvider.notifier).addItem(newItem);
      }

      // ignore: use_build_context_synchronously
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (itemModel != null) {
      _nameController.text = itemModel!.name;
      _quantityController.text = itemModel!.quantity.toString();
      _priceController.text = itemModel!.price.toString();
      _descriptionController.text = itemModel!.description;
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        title: Text(
          isEdit ? 'Edit Inventory Item' : 'Add Inventory Item',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name field
                  CustomTextFormField(
                    label: 'Item Name',
                    controller: _nameController,
                    prefixIcon: Icons.label_outline,
                    hintText: 'Enter item name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter item name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Price and quantity in a row
                  Row(
                    children: [
                      // Price field
                      Expanded(
                        child: CustomTextFormField(
                          label: 'Price',
                          controller: _priceController,
                          prefixIcon: Icons.attach_money,
                          hintText: '0.00',
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter price';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Invalid price';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Quantity field
                      Expanded(
                        child: CustomTextFormField(
                          label: 'Quantity',
                          controller: _quantityController,
                          prefixIcon: Icons.inventory,
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Enter quantity';
                            }
                            if (int.tryParse(value) == null) {
                              return 'Invalid number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Description field
                  CustomTextFormField(
                    label: 'Description',
                    controller: _descriptionController,

                    hintText: 'Enter item description',
                    maxLines: 4,
                    prefixIcon: null,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter item description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => _saveItem(context, ref),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        elevation: 0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Save Item',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
