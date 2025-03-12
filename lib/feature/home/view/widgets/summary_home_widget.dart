import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/home/view/components/summary_card.dart';

class SummaryHomeWidget extends StatelessWidget {
  const SummaryHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          SummaryCard(
            title: 'Total Sales',
            value: '\$10,000',
            icon: Icons.attach_money_outlined,
            color: AppColors.success,
          ),
          SummaryCard(
            title: 'Low Stock Items',
            value: '5 Items',
            icon: Icons.warning_amber_outlined,
            color: AppColors.error,
          ),
          SummaryCard(
            title: 'Pending Payments',
            value: '\$2,500',
            icon: Icons.payment_outlined,
            color: AppColors.warning,
          ),
        ],
      ),
    );
  }
}
