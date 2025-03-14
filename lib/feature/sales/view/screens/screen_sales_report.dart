import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sales_report_export_menu.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sales_report_metric_cards_widget.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sales_report_select_date_widget.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/recent_sales_list_widget.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sale_chart_widget.dart';

class ScreenSalesReport extends ConsumerWidget {
  const ScreenSalesReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(dateRangeProvider);
    final salesData = ref.watch(salesDataProvider);
    final metrics = ref.watch(salesMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
        actions: [SalesReportExportMenu(salesData: salesData)],
      ),
      body: salesData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error loading data: ${error.toString()}')),
        data:
            (sales) => RefreshIndicator(
              onRefresh: () async {
                return ref.refresh(salesDataProvider);
              },
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SalesReportSelectDateWidget(dateRange: dateRange),
                        const SizedBox(height: 16),
                        SalesReportMetricCardsWidget(metrics: metrics),
                        const SizedBox(height: 24),
                        SaleChartWidget(metrics: metrics),
                      ],
                    ),
                  ),
                  RecentSalesListWidget(ref: ref, sales: sales),
                  const SizedBox(height: 24),
                ],
              ),
            ),
      ),
    );
  }
}
