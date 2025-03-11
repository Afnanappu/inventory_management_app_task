import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  const CustomCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Card(
        elevation: .3, // Subtle shadow for depth
        shadowColor: AppColors.surfaceGrey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.surfaceGrey.withValues(alpha: 0.5),
            width: 0.5,
          ), // Subtle border
        ),
        color: AppColors.surfaceWhite, // White background for contrast
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: AppColors.primary.withValues(
            alpha: 0.1,
          ), // Green splash effect
          child: child,
        ),
      ),
    );
  }
}
