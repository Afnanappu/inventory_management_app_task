// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu.dart';
import 'package:inventory_management_app_task/core/components/show_delete_confirmation_dialog.dart';

class PopupMenuButtonWithEditAndDelete extends StatelessWidget {
  final void Function() onEditPressed;
  final void Function() onDeletePressed;
  final Color? iconColor;
  final Color? menuBackgroundColor;
  final String title;

  const PopupMenuButtonWithEditAndDelete({
    super.key,
    required this.onEditPressed,
    required this.onDeletePressed,
    this.iconColor,
    this.menuBackgroundColor,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPopUpMenu(
      menuBackgroundColor: menuBackgroundColor,
      iconColor: iconColor,
      itemBuilder:
          (context) => [
            customPopupMenuItemBuild(
              title: 'Edit',
              icon: Icons.edit_outlined,
              onTap: () {
                // Schedule the edit action after the current build phase
                Future.microtask(() => onEditPressed());
              },
              iconColor: Colors.blue,
            ),
            PopupMenuDivider(height: 0.5),
            customPopupMenuItemBuild(
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
}
