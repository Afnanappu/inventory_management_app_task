// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/button_add_sale.dart';

class ButtonsForAddNewSaleScreen extends StatelessWidget {
  const ButtonsForAddNewSaleScreen({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController nameController,
    required TextEditingController phoneController,
  }) : _formKey = formKey,
       _nameController = nameController,
       _phoneController = phoneController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _nameController;
  final TextEditingController _phoneController;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 85,
      color: AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: buttonAddSale(
              text: 'Save&New',
              haveBorder: true,
              btnColor: AppColors.transparent,
              onTap: () {
                //TODO:
              },
            ),
          ),

          //Save
          Expanded(
            child: buttonAddSale(
              text: 'Save',
              onTap: () {
                //TODO:
              },
            ),
          ),
        ],
      ),
      // : buttonAddSale(
      //   text: 'Ok',
      //   onTap: () async {
      //     Navigator.of(context).pop();
      //   },
      // ),
    );
  }
}
