import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/show_add_customer_dialog.dart';

class AutocompleteNameBuilder extends StatelessWidget {
  const AutocompleteNameBuilder({
    super.key,
    required this.customerSuggestions,
    required this.selectedCustomerProvider,
    required this.customer,
    required this.isView,
    required this.ref,
  });

  final List<CustomerModel>? customerSuggestions;
  final StateProvider<CustomerModel?> selectedCustomerProvider;
  final CustomerModel? customer;
  final bool isView;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<CustomerModel>(
      displayStringForOption: (option) => option.name,
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
                padding: const EdgeInsets.symmetric(vertical: 3),
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
        ref.read(selectedCustomerProvider.notifier).state = selected;
      },
      initialValue: TextEditingValue(text: customer?.name ?? ''),
      fieldViewBuilder: (context, controller, focusNode, onSubmit) {
        return CustomTextFormField(
          prefixIcon: isView ? Icons.person : null,
          suffix:
              isView
                  ? null
                  : IconButton(
                    onPressed: () {
                      showAddCustomerDialog(context, ref, null);
                    },
                    icon: const Icon(Icons.person_add),
                  ),
          readOnly: isView,
          hintText: 'Customer name',
          controller: controller,
          focusNode: focusNode,
          validator: (value) {
            if (value == null || CustomRegExp.checkEmptySpaces(value)) {
              return 'Customer name is empty';
            } else if (!CustomRegExp.checkName(value)) {
              return 'Enter a valid name (use letter and space only)';
            } else {
              return null;
            }
          },
        );
      },
    );
  }
}
