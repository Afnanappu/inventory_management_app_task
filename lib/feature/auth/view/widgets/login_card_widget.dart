// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/components/custom_text_form_field.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/screen_size.dart';
import 'package:inventory_management_app_task/core/services/user_services.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';
import 'package:inventory_management_app_task/routes/router_name.dart';

class LoginCardWidget extends StatelessWidget {
  const LoginCardWidget({
    super.key,
    required this.formKey,
    required TextEditingController emailController,
    required FocusNode emailFocusNode,
    required TextEditingController passwordController,
    required FocusNode passwordFocusNode,
  }) : _emailController = emailController,
       _emailFocusNode = emailFocusNode,
       _passwordController = passwordController,
       _passwordFocusNode = passwordFocusNode;

  final GlobalKey<FormState> formKey;
  final TextEditingController _emailController;
  final FocusNode _emailFocusNode;
  final TextEditingController _passwordController;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: AppScreenSize.screenHeight * 0.25),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: AppColors.surfaceWhite,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Welcome Back',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign in to manage your inventory',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      CustomTextFormField(
                        controller: _emailController,
                        focusNode: _emailFocusNode,
                        hintText: 'Email',
                        prefixIcon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (!CustomRegExp.email(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextFormField(
                        controller: _passwordController,
                        focusNode: _passwordFocusNode,
                        keyboardType: TextInputType.number,
                        hintText: 'Password',
                        prefixIcon: Icons.lock_outline,
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (await getIt.get<UserServices>().login(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            )) {
                              showCustomSnackBar(
                                context: context,
                                content: 'Login successful!',
                                bgColor: AppColors.primary,
                              );
                              context.pushReplacement(AppRoutes.home);
                            } else {
                              showCustomSnackBar(
                                context: context,
                                content: 'Incorrect email or password',
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textOnPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height:
                  MediaQuery.of(context).viewInsets.bottom +
                  AppScreenSize.screenHeight * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
