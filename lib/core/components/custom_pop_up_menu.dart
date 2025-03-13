// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({
    super.key,
    this.menuBackgroundColor,
    this.iconColor,
    required this.itemBuilder,
  });

  final Color? menuBackgroundColor;
  final Color? iconColor;
  final List<PopupMenuEntry> Function(BuildContext context) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: menuBackgroundColor ?? Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      icon: Icon(Icons.more_vert, color: iconColor ?? Colors.black54),
      offset: const Offset(0, 40),
      itemBuilder: itemBuilder,
    );
  }
}

PopupMenuEntry customPopupMenuItemBuild({
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
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ],
    ),
  );
}
