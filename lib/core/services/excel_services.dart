import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/utils/format_date.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class ExcelServices {
  Future<File?> generateExcelReport(
    List<SalesModel> sales,
    WidgetRef ref,
  ) async {
    final Workbook workbook = Workbook();
    final Worksheet sheet = workbook.worksheets[0];
    sheet.name = 'Sales Report';
    // Increase size and bolden headers
    final Style style = workbook.styles.add('HeaderStyle');
    style.fontSize = 14;
    style.bold = true;

    sheet.getRangeByName('A1').cellStyle = style;
    sheet.getRangeByName('B1').cellStyle = style;
    sheet.getRangeByName('C1').cellStyle = style;

    // Add headers

    sheet.getRangeByName('A1').setText('Date');
    sheet.autoFitColumn(1);
    sheet.getRangeByName('B1').setText('Customer');
    sheet.autoFitColumn(2);
    sheet.getRangeByName('C1').setText('Total Amount');
    sheet.autoFitColumn(3);

    // Add sales data
    for (int i = 0; i < sales.length; i++) {
      final customerName =
          ref
              .read(customerProvider.notifier)
              .getCustomerById(sales[i].customerId)!
              .name;
      sheet
          .getRangeByIndex(i + 2, 1)
          .setText(formatDateTime3(date: sales[i].date));
      sheet.getRangeByIndex(i + 2, 2).setText(customerName);
      sheet.getRangeByIndex(i + 2, 3).setNumber(sales[i].totalAmount);
    }

    // Save Excel file in Downloads folder
    // final downloadsPath = await PathProviderWindows().getDownloadsPath();
    // if (downloadsPath == null) {
    //   print("Couldn't get downloads folder");
    //   return;
    // }

    // final filePath = '$downloadsPath/sales_report.xlsx';
    // final file = File(filePath);
    // file.writeAsBytesSync(workbook.saveAsStream());

    // workbook.dispose();
    // print('Excel saved to $filePath');

    return await _saveExcelWithFilePicker(workbook);
  }

  Future<File?> _saveExcelWithFilePicker(Workbook workbook) async {
    String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Save Excel Report',
      fileName: 'sales_report.xlsx',
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (outputFile != null) {
      final file = File(outputFile);
      file.writeAsBytesSync(workbook.saveAsStream());
      print('Excel saved to $outputFile');
      return file;
    } else {
      print('User canceled the save dialog.');
    }

    workbook.dispose();

    return null;
  }
}
