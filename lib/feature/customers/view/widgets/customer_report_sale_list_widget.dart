import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/metric_card.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/customers/view/components/customer_report_sales_card.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';

class CustomerReportSaleListWidget extends StatelessWidget {
  const CustomerReportSaleListWidget({
    super.key,
    required this.totalSales,
    required this.sales,
  });

  final double totalSales;
  final List<SalesModel> sales;

  @override
  Widget build(BuildContext context) {
    // Calculate metrics
    double averageSale = sales.isEmpty ? 0 : totalSales / sales.length;

    if (sales.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.receipt_long, size: 48, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No transactions found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MetricCard(
                title: 'Total Sales',
                value: formatMoney(number: totalSales),
                icon: Icons.attach_money,
                color: AppColors.primaryDark,
                margin: EdgeInsets.symmetric(horizontal: 8),
              ),
              MetricCard(
                title: 'Average Sale',
                value: formatMoney(number: averageSale),
                icon: Icons.attach_money,
                color: AppColors.primaryDark,
                margin: EdgeInsets.symmetric(horizontal: 8),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: sales.length,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              return CustomerReportSalesCard(sale: sales[index]);
            },
          ),
        ],
      ),
    );
  }
}
