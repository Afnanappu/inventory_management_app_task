import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/services/excel_services.dart';
import 'package:inventory_management_app_task/core/services/pdf_services.dart';
import 'package:inventory_management_app_task/core/services/share_services.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';

class InventoryExportWidget extends StatelessWidget {
  const InventoryExportWidget({super.key, required this.inventoryData});

  final AsyncValue<List<InventoryItemModel>> inventoryData;

  @override
  Widget build(BuildContext context) {
    return CustomPopUpMenu(
      itemBuilder: (context) {
        return [
          customPopupMenuItemBuild(
            title: 'Export as PDF',
            icon: Icons.picture_as_pdf,
            onTap: () async {
              final file = await getIt
                  .get<PdfService>()
                  .generateInventoryReport(inventoryData.value!);

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
                  .generateInventoryExcelReport(inventoryData.value!);

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
              await getIt.get<PdfService>().printInventoryReport(
                inventoryData.value!,
              );
            },
            iconColor: Colors.blue,
          ),
          customPopupMenuItemBuild(
            title: 'Share',
            icon: Icons.share,
            onTap: () async {
              await getIt.get<ShareServices>().shareInventoryReport(
                inventoryData.value!,
              );
            },
            iconColor: Colors.orange,
          ),
        ];
      },
    );
  }
}
