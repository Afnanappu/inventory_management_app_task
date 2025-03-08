// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/show_delete_confirmation_dialog.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Function() onEditPressed;
  final Function() onDeletePressed;
  final Color? iconColor;
  final Color? menuBackgroundColor;
  final String title;

  const CustomPopupMenuButton({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
    this.iconColor,
    this.menuBackgroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: menuBackgroundColor ?? Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      icon: Icon(Icons.more_vert, color: iconColor ?? Colors.black54),
      offset: const Offset(0, 40),
      itemBuilder:
          (context) => [
            _buildPopupMenuItem(
              title: 'Edit',
              icon: Icons.edit_outlined,
              onTap: () {
                // Schedule the edit action after the current build phase
                Future.microtask(() => onEditPressed());
              },
              iconColor: Colors.blue,
            ),
            PopupMenuDivider(height: 0.5),
            _buildPopupMenuItem(
              title: 'Delete',
              icon: Icons.delete_outline,
              onTap: () {
                // Schedule the delete dialog after the current build phase
                Future.microtask(
                  () => showDeleteConfirmationDialog(
                    context: context,
                    onDeletePressed: onDeletePressed,
                    title: title,
                  ),
                );
              },
              iconColor: Colors.red,
            ),
          ],
    );
  }

  PopupMenuEntry _buildPopupMenuItem({
    required String title,
    required IconData icon,
    required Function() onTap,
    required Color iconColor,
  }) {
    return PopupMenuItem(
      onTap: onTap,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
