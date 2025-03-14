import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/components/custom_card.dart';
import 'package:inventory_management_app_task/core/components/popup_menu_button_with_edit_and_delete.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/show_add_customer_dialog.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';

class CustomerTile extends ConsumerWidget {
  final CustomerModel customer;
  final void Function()? onTap;

  const CustomerTile({super.key, required this.customer, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(customerProvider.notifier);

    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 8),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // Customer Avatar
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.primaryLight.withValues(
                alpha: 0.2,
              ), // Subtle green background
              child: Text(
                customer.name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary, // Main green for text
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Customer Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 18,
                        color: AppColors.accent, // Teal accent for icons
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          customer.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary, // Primary text color
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color:
                            AppColors
                                .textSecondary, // Secondary text color for icons
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          customer.address,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                AppColors
                                    .textSecondary, // Grey for secondary info
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone_outlined,
                        size: 16,
                        color: AppColors.textSecondary, // Secondary text color
                      ),
                      const SizedBox(width: 8),
                      Text(
                        customer.phone,
                        style: TextStyle(
                          fontSize: 16,
                          color:
                              AppColors
                                  .textSecondary, // Grey for secondary info
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            PopupMenuButtonWithEditAndDelete(
              onEditPressed: () {
                showAddCustomerDialog(context, ref, customer);
              },
              onDeletePressed: () {
                provider.deleteCustomer(customer.id);
              },
              title: 'customer',
            ),
          ],
        ),
      ),
    );
  }
}
