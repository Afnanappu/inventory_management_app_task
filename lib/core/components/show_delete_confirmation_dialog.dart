import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';

Future<void> showDeleteConfirmationDialog({
  required BuildContext context,
  required String title,
  required Function() onDeletePressed,
}) async => showDialog(
  context: context,
  builder:
      (context) => AlertDialog(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        title: Text(
          'Delete ${title.replaceFirst(title[0], title[0].toUpperCase())}', //This will change the first letter to uppercase
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        content: Text(
          'Are you sure you want to delete this $title?',
          style: TextStyle(fontSize: 16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
