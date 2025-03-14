import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/services/user_services.dart';
import 'package:inventory_management_app_task/feature/home/view/widgets/nav_home_widget.dart';
import 'package:inventory_management_app_task/feature/home/view/widgets/summary_home_widget.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class ScreenHome extends ConsumerWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.scaffoldBackground,
                AppColors.surfaceLight.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                backgroundColor: AppColors.scaffoldBackground,
                                title: Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                content: Text(
                                  'Do you want to logout?',
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
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.grey[800],
                                    ),
                                    child: const Text(
                                      'Cancel',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      getIt
                                          .get<UserServices>()
                                          .updateLoginStatus(false)
                                          .then((_) {
                                            if (context.mounted) {
                                              context.go(AppRoutes.login);
                                            }
                                          });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.error,
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
                                      'Logout',
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
                      },
                      icon: Icon(Icons.logout_outlined),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Navigation Cards
                NavHomeWidget(),

                const SizedBox(height: 24),

                // Summary Section
                SummaryHomeWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
