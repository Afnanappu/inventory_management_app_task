import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/utils/format_date.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:printing/printing.dart';
import 'package:permission_handler/permission_handler.dart';

class PdfService {
  /// Generate a PDF sales report using the given [sales] and [ref] values.
  ///
  /// Returns a [File] if the PDF was successfully saved, or null if permission
  /// was denied.
  ///
  /// [sales] is the list of [SalesModel] objects to include in the report.
  ///
  /// [ref] is the [WidgetRef] to use for accessing the application's state.
  Future<File?> generateSalesReport(
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final pdf = await _generateSalesReport(sales, ref);

    return await _savePdf(pdf, 'sales_report.pdf');
  }

  Future<Uint8List> _generateSalesReport(
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final pdf = pw.Document();
    // pdf.
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Sales Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['Date', 'Customer', 'Amount'],
                data:
                    sales.map((sale) {
                      final customerName =
                          ref
                              .read(customerProvider.notifier)
                              .getCustomerById(sale.customerId)!
                              .name;
                      return [
                        formatDateTime3(date: sale.date),
                        customerName,
                        formatMoney(
                          number: sale.totalAmount,
                          haveSymbol: false,
                        ),
                      ];
                    }).toList(),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
              ),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }

  Future<File?> _savePdf(Uint8List pdf, String fileName) async {
    if (await Permission.storage.request().isGranted) {
      Directory? downloadsDir = Directory('/storage/emulated/0/Download');

      if (!downloadsDir.existsSync()) {
        downloadsDir = await getExternalStorageDirectory(); // Fallback
      }

      final filePath = '${downloadsDir!.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(pdf);
      return file;
    } else {
      return null; // Permission denied
    }
    // String? outputFile = await FilePicker.platform.saveFile(
    //   dialogTitle: 'Save PDF',
    //   fileName: fileName,
    // );

    // if (outputFile != null) {
    //   final file = File(outputFile);
    //   await file.writeAsBytes(pdf);
    //   print('Saved PDF to $outputFile');
    //   return file;
    // } else {
    //   print('User canceled the save dialog.');
    //   return null;
    // }
  }

  /// Print the sales report as a PDF.
  ///
  /// [sales] is the list of [SalesModel] objects to include in the report.
  ///
  /// [ref] is the [WidgetRef] to use for accessing the application's state.
  Future<void> printSalesReport(List<SalesModel> sales, WidgetRef ref) async {
    final pdf = await _generateSalesReport(sales, ref);
    // Print the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
  }

  //====================

  /// Generate a PDF inventory report
  Future<File?> generateInventoryReport(
    List<InventoryItemModel> inventory,
  ) async {
    final pdf = await _generateInventoryReport(inventory);
    return await _savePdf(pdf, 'inventory_report.pdf');
  }

  /// Generate the inventory report in PDF format
  Future<Uint8List> _generateInventoryReport(
    List<InventoryItemModel> inventory,
  ) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Inventory Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 20),
              pw.TableHelper.fromTextArray(
                headers: ['ID', 'Name', 'Description', 'Quantity', 'Price'],
                data:
                    inventory.map((item) {
                      return [
                        item.id,
                        item.name,
                        item.description,
                        item.quantity.toString(),
                        formatMoney(number: item.price, haveSymbol: false),
                      ];
                    }).toList(),
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,
              ),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }

  /// Print Inventory Report
  Future<void> printInventoryReport(List<InventoryItemModel> inventory) async {
    final pdf = await _generateInventoryReport(inventory);
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
  }

  //===================

  Future<File?> generateCustomerReportPdf(
    List<CustomerModel> customers,
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final pdf = await _generateCustomerReportPdf(customers, sales, ref);
    return await _savePdf(pdf, 'customer_report.pdf');
  }

  Future<Uint8List> _generateCustomerReportPdf(
    List<CustomerModel> customers,
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final pdf = pw.Document();
    // Title
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Customer Report',
                style: pw.TextStyle(
                  fontSize: 20,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              _buildCustomerTable(customers, sales),
            ],
          );
        },
      ),
    );

    return await pdf.save();
  }

  pw.Widget _buildCustomerTable(
    List<CustomerModel> customers,
    List<SalesModel> sales,
  ) {
    // Calculate total purchases per customer
    Map<String, double> customerTotalPurchases = {};
    for (var sale in sales) {
      customerTotalPurchases[sale.customerId] =
          (customerTotalPurchases[sale.customerId] ?? 0) + sale.totalAmount;
    }

    return pw.TableHelper.fromTextArray(
      border: pw.TableBorder.all(),
      cellAlignment: pw.Alignment.centerLeft,
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      headers: ['Customer Name', 'Address', 'Phone', 'Total Purchases'],
      data:
          customers.map((customer) {
            final totalPurchases = customerTotalPurchases[customer.id] ?? 0.0;
            return [
              customer.name,
              customer.address,
              customer.phone,
              formatMoney(number: totalPurchases, haveSymbol: false),
            ];
          }).toList(),
    );
  }

  Future<void> printCustomerReport(
    List<CustomerModel> customers,
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final pdf = await _generateCustomerReportPdf(customers, sales, ref);
    // Print the PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdf);
  }
}
