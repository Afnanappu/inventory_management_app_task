import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/view/widgets/customer_report_financial_summary_widget.dart';
import 'package:inventory_management_app_task/feature/customers/view/widgets/customer_report_sale_list_widget.dart';
import 'package:inventory_management_app_task/feature/customers/view_model/customer_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

class ScreenCustomerReport extends ConsumerStatefulWidget {
  final CustomerModel customer;
  const ScreenCustomerReport({super.key, required this.customer});

  @override
  ConsumerState<ScreenCustomerReport> createState() =>
      _ScreenCustomerReportState();
}

class _ScreenCustomerReportState extends ConsumerState<ScreenCustomerReport> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Call _loadSales once when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSales();
    });
  }

  void _loadSales() {
    // Query sales for this customer, sorted by date (newest first)
    final sales = ref
        .read(salesProvider.notifier)
        .getSalesByCustomer(widget.customer.id);
    ref.read(customerSalesProvider.notifier).state = sales;

    // Calculate total sales amount
    double total = 0.0;
    for (var sale in sales) {
      total += sale.totalAmount;
    }
    ref.read(totalSalesAmountProvider.notifier).state = total;

    // Update loading state after data is fetched
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final sales = ref.watch(customerSalesProvider);
    final totalSales = ref.watch(totalSalesAmountProvider);
    log('Page built for customer: ${widget.customer.name}');

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.customer.name} - Ledger'),
        elevation: 0,
        actions: [
          
          // IconButton(
          //   icon: const Icon(Icons.refresh),
          //   onPressed:
          //       _isLoading
          //           ? null
          //           : () {
          //             setState(() => _isLoading = true);
          //             _loadSales();
          //           },
          // ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  // Modern financial summary
                  CustomerReportFinancialSummaryWidget(
                    sales: sales,
                    totalSales: totalSales,
                  ),
                  // Sales transactions list
                  Expanded(
                    child: CustomerReportSaleListWidget(
                      sales: sales,
                      totalSales: totalSales,
                    ),
                  ),
                ],
              ),
    );
  }
}
