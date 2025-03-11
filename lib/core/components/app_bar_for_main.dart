import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/font_styles.dart';

class AppBarForMain extends StatelessWidget implements PreferredSizeWidget {
  const AppBarForMain({
    super.key,
    required this.title,

    this.onPressed,
    this.haveBorder = true,
    this.isPopupMenuButton = false,
    this.popupMenuButton,
  });

  final String title;

  final void Function()? onPressed;
  final bool haveBorder;
  final bool isPopupMenuButton;
  final Widget? popupMenuButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title, style: AppFontStyle.main),
      // actions: [
      //   IconButton(
      //     onPressed: onPressed,
      //     icon: Container(
      //       padding: const EdgeInsets.all(5),
      //       decoration: BoxDecoration(
      //         border:
      //             (haveBorder == true)
      //                 ? Border.all(color: AppColors.textSecondary)
      //                 : null,
      //         borderRadius: BorderRadius.circular(20),
      //       ),
      //       child: isPopupMenuButton == false ? Icon(icon) : popupMenuButton,
      //     ),
      //   ),
      //   SizedBox(width: AppScreenSize.screenWidth * 0.03),
      // ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
