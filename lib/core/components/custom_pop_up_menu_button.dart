import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPopupMenuButton extends StatelessWidget {
  final Function() onEditPressed;
  final Function() onDeletePressed;
  final Color? iconColor;
  final Color? menuBackgroundColor;

  const CustomPopupMenuButton({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
    this.iconColor,
    this.menuBackgroundColor,
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
                Future.microtask(() => _showDeleteConfirmationDialog(context));
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

  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Delete Item',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            content: const Text(
              'Are you sure you want to delete this item?',
              style: TextStyle(fontSize: 16),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  context.pop();
                },
                style: TextButton.styleFrom(foregroundColor: Colors.grey[800]),
                child: const Text(
                  'Cancel',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  context.pop();
                  onDeletePressed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            actionsPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
    );
  }
}
