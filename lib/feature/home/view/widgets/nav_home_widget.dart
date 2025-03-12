import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/home/view/components/home_nav_card.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class NavHomeWidget extends StatelessWidget {
  const NavHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        HomeNavCard(
          context: context,
          title: 'Sales Report',
          icon: Icons.bar_chart,
          color: AppColors.surfaceGrey,
          route: AppRoutes.sales,
        ),
        HomeNavCard(
          context: context,
          title: 'Items Report',
          icon: Icons.inventory_2_outlined,
          color: AppColors.surfaceGrey,
          route: AppRoutes.inventory,
        ),
        HomeNavCard(
          context: context,
          title: 'Customers',
          icon: Icons.people_outline,
          color: AppColors.surfaceGrey,
          route: AppRoutes.customers,
        ),
      ],
    );
  }
}
