// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/services/excel_services.dart';
import 'package:inventory_management_app_task/core/services/pdf_services.dart';
import 'package:inventory_management_app_task/core/services/share_services.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';

class CustomerReportExportMenu extends ConsumerWidget {
  const CustomerReportExportMenu({
    super.key,
    required this.customers,
    required this.sales,
  });

  final List<CustomerModel> customers;
  final List<SalesModel> sales;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomPopUpMenu(
      itemBuilder: (context) {
        return [
          customPopupMenuItemBuild(
            title: 'Export as PDF',
            icon: Icons.picture_as_pdf,
            onTap: () async {
              final file = await getIt
                  .get<PdfService>()
                  .generateCustomerReportPdf(customers, sales, ref);

              if (file != null) {
                showCustomSnackBar(
                  context: context,
                  content: 'PDF saved to: ${file.path}',
                  bgColor: AppColors.surfaceDark,
                );
              } else {
                showCustomSnackBar(
                  context: context,
                  content: 'Failed to save PDF',
                );
              }
            },
            iconColor: Colors.red,
          ),
          customPopupMenuItemBuild(
            title: 'Export as Excel',
            icon: Icons.table_chart,
            onTap: () async {
              final file = await getIt
                  .get<ExcelServices>()
                  .generateCustomerReport(customers, sales, ref);

              if (file != null) {
                showCustomSnackBar(
                  context: context,
                  content: 'Excel saved to: ${file.path}',
                  bgColor: AppColors.surfaceDark,
                );
              } else {
                showCustomSnackBar(
                  context: context,
                  content: 'Failed to save Excel',
                );
              }
            },
            iconColor: Colors.green,
          ),
          customPopupMenuItemBuild(
            title: 'Print',
            icon: Icons.print,
            onTap: () async {
              await getIt.get<PdfService>().printCustomerReport(
                customers,
                sales,
                ref,
              );
            },
            iconColor: Colors.blue,
          ),
          customPopupMenuItemBuild(
            title: 'Share',
            icon: Icons.share,
            onTap: () async {
              await getIt.get<ShareServices>().shareCustomerReport(
                customers,
                sales,
                ref,
              );
            },
            iconColor: Colors.orange,
          ),
        ];
      },
    );
  }
}
