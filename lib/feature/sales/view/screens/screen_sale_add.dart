import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/current_sale_item_list_for_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sale_add_item.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/total_amount_section_for_sale_add_item_screen.dart';

class ScreenSaleAdd extends ConsumerWidget {
  ScreenSaleAdd({super.key});

  final _customerNameController = TextEditingController();

  final _customerPhoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerSuggestions = ref
        .watch(customerProvider)
        .value
        ?.map((e) => e.name);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Autocomplete<String>(
                optionsBuilder: (textEditingValue) {
                  if (textEditingValue.text.isEmpty) return [];
                  log(customerSuggestions.toString());
                  return customerSuggestions?.where(
                        (customer) => customer.toLowerCase().contains(
                          textEditingValue.text.toLowerCase(),
                        ),
                      ) ??
                      [];
                },
                onSelected: (selectedCustomer) {
                  _customerNameController.text = selectedCustomer;
                },
                fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                  _customerNameController.text = controller.text;
                  return CustomTextFormField(
                    prefixIcon: Icons.person,
                    suffix: IconButton(
                      onPressed: () {
                       
                      },
                      icon: Icon(Icons.person_add),
                    ),
                    hintText: 'Customer name',
                    controller: controller,
                    focusNode: focusNode,
                    validator: (value) {
                      if (value == null ||
                          CustomRegExp.checkEmptySpaces(value)) {
                        return 'Customer name is empty';
                      } else if (!CustomRegExp.checkName(value)) {
                        return 'Enter a valid name (use letter and space only)';
                      } else {
                        return null;
                      }
                    },
                  );
                },
              ),

              const SizedBox(height: 15),

              // CustomTextFormField(
              //   prefixIcon: Icons.phone,
              //   hintText: 'Phone no',
              //   controller: _customerPhoneController,
              //   keyboardType: TextInputType.phone,
              //   validator: (value) {
              //     if (value == null || CustomRegExp.checkEmptySpaces(value)) {
              //       return 'phone no is empty';
              //     } else if (!CustomRegExp.checkPhoneNumber(value)) {
              //       return 'Enter a valid phone number';
              //     } else if (value.length < 10) {
              //       return 'Enter 10 digit number';
              //     } else if (value.length > 10) {
              //       return 'Too many digits, try again';
              //     } else {
              //       return null;
              //     }
              //   },
              // ),

              // //sale added list
              CurrentSaleItemListForSaleScreen(),

              const SizedBox(height: 15),
              saleAddItem(
                onTap: () {
                  _showAddItemDialog(context);
                },
              ),
              // : const SizedBox(),
              const SizedBox(height: 15),

              //total Amount
              const TotalAmountSectionForSaleAddItemScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ButtonsForAddNewSaleScreen(
        // saleWidget: widget,
        formKey: _formKey,
        nameController: _customerNameController,
        phoneController: _customerPhoneController,
      ),
    );
  }
}

void _showAddItemDialog(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => SaleAddItem(onItemAdded: (item) {}),
  );
}
