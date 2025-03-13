import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app_task/core/utils/format_date.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:printing/printing.dart';

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

    return await _savePdfWithFilePicker(pdf);
    // if (await Permission.storage.request().isGranted) {
    //   Directory? downloadsDir = Directory('/storage/emulated/0/Download');

    //   if (!downloadsDir.existsSync()) {
    //     downloadsDir = await getExternalStorageDirectory(); // Fallback
    //   }

    //   final filePath = '${downloadsDir!.path}/sales_report.pdf';
    //   final file = File(filePath);
    //   await file.writeAsBytes(await pdf.save());

    //   return file;
    // } else {
    //   return null; // Permission denied
    // }
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
                        '₹${sale.totalAmount}',
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

  Future<File?> _savePdfWithFilePicker(Uint8List pdf) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Save PDF',
      fileName: 'sales_report.pdf',
    );

    if (outputFile != null) {
      final file = File(outputFile);
      await file.writeAsBytes(pdf);
      print('Saved PDF to $outputFile');
      return file;
    } else {
      print('User canceled the save dialog.');
      return null;
    }
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
}
