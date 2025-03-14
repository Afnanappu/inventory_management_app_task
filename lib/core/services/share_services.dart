import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/services/pdf_services.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:share_plus/share_plus.dart';

class ShareServices {
  Future<void> shareSalesReport(List<SalesModel> sales, WidgetRef ref) async {
    final pdfFile = await getIt<PdfService>().generateSalesReport(sales, ref);
    // final excelFile = await getIt<ExcelServices>().generateExcelReport(
    //   sales,
    //   ref,
    // );

    await Share.shareXFiles([
      // if (excelFile != null) XFile(excelFile.path),
      if (pdfFile != null) XFile(pdfFile.path),
    ], text: 'Sales Report');
  }

  Future<void> shareInventoryReport(
    List<InventoryItemModel> inventoryItems,
  ) async {
    final pdfFile = await getIt<PdfService>().generateInventoryReport(
      inventoryItems,
    );
    // final excelFile = await getIt<ExcelServices>().generateExcelReport(
    //   sales,
    //   ref,
    // );

    await Share.shareXFiles([
      // if (excelFile != null) XFile(excelFile.path),
      if (pdfFile != null) XFile(pdfFile.path),
    ], text: 'Inventory Report');
  }

  Future<void> shareCustomerReport(
    List<CustomerModel> customers,
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final pdfFile = await getIt<PdfService>().generateCustomerReportPdf(
      customers,
      sales,
      ref,
    );
    // final excelFile = await getIt<ExcelServices>().generateExcelReport(
    //   sales,
    //   ref,
    // );

    await Share.shareXFiles([
      // if (excelFile != null) XFile(excelFile.path),
      if (pdfFile != null) XFile(pdfFile.path),
    ], text: 'Customer Report');
  }
}
