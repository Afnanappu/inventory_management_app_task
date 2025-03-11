import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/format_date.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/autocomplete_name_builder.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/current_sale_item_list_for_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sale_add_item.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/total_amount_section_for_sale_add_item_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

class ScreenSaleAdd extends ConsumerWidget {
  final bool isView;
  final String? saleId;

  ScreenSaleAdd({super.key, required this.isView, this.saleId});

  final dateController = TextEditingController(
    text: formatDateTime2(date: DateTime.now()),
  );

  final _formKey = GlobalKey<FormState>();
  final selectedCustomerProvider = StateProvider<CustomerModel?>((ref) => null);
  final selectedDateProvider = StateProvider<DateTime>(
    (ref) => DateTime.now(),
  ); // Default to today

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerSuggestions = ref.watch(customerProvider).value;
    final selectedDate = ref.watch(selectedDateProvider);

    //Trying to get data if in view mode
    final saleModel =
        saleId == null
            ? null
            : ref.read(salesProvider.notifier).getSaleById(saleId!);

    final customer =
        saleModel == null
            ? null
            : ref
                .read(customerProvider.notifier)
                .getCustomerById(saleModel.customerId);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (saleModel != null) {
        final picked = saleModel.date;
        ref.read(selectedDateProvider.notifier).state = picked;
        dateController.text = formatDateTime2(date: picked);

        ref.read(selectedCustomerProvider.notifier).state = customer;
      }
    });

    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        ref.read(selectedSaleItemProvider.notifier).state = [];
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(isView ? 'View Sale' : 'Add Sale'),
          backgroundColor: AppColors.scaffoldBackground,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Customer Autocomplete
                AutocompleteNameBuilder(
                  ref: ref,
                  customerSuggestions: customerSuggestions,
                  selectedCustomerProvider: selectedCustomerProvider,
                  customer: customer,
                  isView: isView,
                ),
                const SizedBox(height: 15),

                // Date Picker Field
                GestureDetector(
                  onTap:
                      isView
                          ? null
                          : () {
                            _pickDate(context: context, ref: ref);
                          },
                  child: CustomTextFormField(
                    readOnly: true,
                    enabled: isView,
                    hintText: 'Sale Date',
                    prefixIcon: Icons.calendar_today_outlined,
                    controller: dateController,
                  ),
                ),
                const SizedBox(height: 15),

                // Sale Item List
                CurrentSaleItemListForSaleScreen(
                  isView: isView,
                  saleItem: saleModel?.saleItems ?? [],
                ),
                const SizedBox(height: 15),

                // Add Item Button
                if (!isView)
                  saleAddItem(
                    onTap: () {
                      _showAddItemDialog(context);
                    },
                  ),
                const SizedBox(height: 15),

                // Total Amount
                const TotalAmountSectionForSaleAddItemScreen(),
              ],
            ),
          ),
        ),
        bottomNavigationBar:
            isView
                ? null
                : ButtonsForAddNewSaleScreen(
                  selectedDate: selectedDate,
                  selectedCustomerProvider: selectedCustomerProvider,
                ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => const SaleAddItem(),
    );
  }

  void _pickDate({
    required BuildContext context,
    required WidgetRef ref,
  }) async {
    final selectedDate = ref.read(selectedDateProvider);
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000), // Reasonable past limit
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.textOnPrimary,
              surface: AppColors.surfaceWhite,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      // picked =picked.add(Duration(days: 1));
      ref.read(selectedDateProvider.notifier).state = picked;
      dateController.text = formatDateTime2(date: picked);
    }
  }
}
