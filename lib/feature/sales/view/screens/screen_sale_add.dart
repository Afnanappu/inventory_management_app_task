import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/show_add_customer_dialog.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/current_sale_item_list_for_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sale_add_item.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/total_amount_section_for_sale_add_item_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

class ScreenSaleAdd extends ConsumerWidget {
  ScreenSaleAdd({super.key});

  final _formKey = GlobalKey<FormState>();
  final selectedCustomerProvider = StateProvider<CustomerModel?>((ref) {
    return null;
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerSuggestions = ref.watch(customerProvider).value;

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(selectedSaleItemProvider.notifier).state = [];
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Autocomplete<CustomerModel>(
                  displayStringForOption: (option) {
                    return option.name;
                  },
                  optionsBuilder: (textEditingValue) {
                    if (textEditingValue.text.isEmpty) return [];
                    return customerSuggestions?.where(
                          (customer) => customer.name.toLowerCase().contains(
                            textEditingValue.text.toLowerCase(),
                          ),
                        ) ??
                        [];
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          height: 200,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(vertical: 3),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final customer = options.elementAt(index);
                              return ListTile(
                                title: Text(customer.name),
                                onTap: () => onSelected(customer),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                  onSelected: (selected) {
                    ref.read(selectedCustomerProvider.notifier).state =
                        selected; //updating the selected customer state
                  },
                  fieldViewBuilder: (context, controller, focusNode, onSubmit) {
                    return CustomTextFormField(
                      suffix: IconButton(
                        onPressed: () {
                          showAddCustomerDialog(context, ref, null);
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

                //Sale item list
                CurrentSaleItemListForSaleScreen(),

                const SizedBox(height: 15),

                saleAddItem(
                  onTap: () {
                    _showAddItemDialog(context);
                  },
                ),

                const SizedBox(height: 15),

                //total Amount
                const TotalAmountSectionForSaleAddItemScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: ButtonsForAddNewSaleScreen(
          selectedCustomerProvider: selectedCustomerProvider,
        ),
        
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
    builder: (context) => SaleAddItem(),
  );
}
