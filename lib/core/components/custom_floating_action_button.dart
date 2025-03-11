import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/screen_size.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final IconData icon;
  final Color color;

  const CustomFloatingActionButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon = Icons.add,
    this.color = AppColors.primary, // Default to primary green
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder:
          (context, constraints) => SizedBox(
            width:
                (constraints.maxWidth < 600)
                    ? AppScreenSize.screenWidth * 0.41
                    : AppScreenSize.screenWidth * 0.2,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: FloatingActionButton(
                heroTag: null,
                onPressed: onPressed,
                backgroundColor: color,
                elevation: 2, // Added subtle elevation for depth
                hoverColor: AppColors.primaryDark.withValues(
                  alpha: 0.2,
                ), // Hover effect
                splashColor: AppColors.primaryLight.withValues(
                  alpha: 0.3,
                ), // Tap feedback
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color:
                          AppColors
                              .textOnPrimary, // White for contrast on primary
                    ),
                    const SizedBox(width: 5),
                    Text(
                      text,
                      style: TextStyle(
                        color: AppColors.textOnPrimary, // White for contrast
                        fontSize: 16,
                        fontWeight:
                            FontWeight.w500, // Slightly bold for readability
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
    );
  }
}
