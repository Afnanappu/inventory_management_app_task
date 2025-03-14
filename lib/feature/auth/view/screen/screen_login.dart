// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart'
    as clipper;
import 'package:inventory_management_app_task/core/constants/screen_size.dart';
import 'package:inventory_management_app_task/feature/auth/view/widgets/login_card_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ClipPath(
            clipper: clipper.WaveClipperOne(),
            child: Container(
              height: AppScreenSize.screenHeight * 0.35,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.primary, AppColors.primaryDark],
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.inventory_2_rounded,
                      size: 60,
                      color: AppColors.textOnPrimary,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'StockSync',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textOnPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          LoginCardWidget(
            formKey: formKey,
            emailController: _emailController,
            emailFocusNode: _emailFocusNode,
            passwordController: _passwordController,
            passwordFocusNode: _passwordFocusNode,
          ),
        ],
      ),
    );
  }
}
