import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/components/metric_card.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_metrics.dart';

class SalesReportMetricCardsWidget extends StatelessWidget {
  const SalesReportMetricCardsWidget({
    super.key,
    required this.metrics,
  });

  final SalesMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MetricCard(
          title: 'Total Sales',
          value: metrics.totalSales.toString(),
          icon: Icons.receipt_long,
          color: Colors.green,
        ),
        const SizedBox(width: 16),
        MetricCard(
          title: 'Revenue',
          value: formatMoney(number: metrics.totalRevenue),
          icon: Icons.currency_rupee,
          color: Colors.green,
        ),
      ],
    );
  }
}
