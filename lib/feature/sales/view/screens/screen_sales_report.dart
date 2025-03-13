// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/components/custom_pop_up_menu.dart';
import 'package:inventory_management_app_task/core/components/popup_menu_button_with_edit_and_delete.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/services/excel_services.dart';
import 'package:inventory_management_app_task/core/services/pdf_services.dart';
import 'package:inventory_management_app_task/core/services/share_services.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/buttons_for_add_new_sale_screen.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

import 'package:inventory_management_app_task/feature/sales/models/sales_metrics.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/metric_card.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/recent_sales_list_widget.dart';
import 'package:inventory_management_app_task/feature/sales/view/widgets/sale_chart_widget.dart';

class ScreenSalesReport extends ConsumerWidget {
  const ScreenSalesReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SalesReportScreen();
  }
}

class SalesReportScreen extends ConsumerWidget {
  const SalesReportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateRange = ref.watch(dateRangeProvider);
    final salesData = ref.watch(salesDataProvider);
    final metrics = ref.watch(salesMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sales Report'),
        actions: [
          CustomPopUpMenu(
            itemBuilder: (context) {
              return [
                customPopupMenuItemBuild(
                  title: 'Export as PDF',
                  icon: Icons.picture_as_pdf,
                  onTap: () async {
                    final file = await getIt
                        .get<PdfService>()
                        .generateSalesReport(salesData.value!, ref);

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
                        .generateExcelReport(salesData.value!, ref);

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
                    await getIt.get<PdfService>().printSalesReport(
                      salesData.value!,
                      ref,
                    );
                  },
                  iconColor: Colors.blue,
                ),
                customPopupMenuItemBuild(
                  title: 'Share',
                  icon: Icons.share,
                  onTap: () async {
                    await getIt.get<ShareServices>().shareSalesReport(
                      salesData.value!,
                      ref,
                    );
                  },
                  iconColor: Colors.orange,
                ),
              ];
            },
          ),

          // IconButton(
          //   icon: const Icon(Icons.picture_as_pdf),
          //   onPressed: () async {},
          //   tooltip: 'Select Date Range',
          // ),
        ],
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
                        _buildDateRangeHeader(context, dateRange, ref),
                        const SizedBox(height: 16),
                        _buildMetricCards(metrics),
                        const SizedBox(height: 24),
                        SaleChartWidget(metrics: metrics),
                        // _buildTopProductsList(metrics),
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

  Future<void> _selectDateRange(BuildContext context, WidgetRef ref) async {
    final currentRange = ref.read(dateRangeProvider);
    final pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: currentRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2A6B96),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      ref.read(dateRangeProvider.notifier).state = pickedRange;
    }
  }

  Widget _buildDateRangeHeader(
    BuildContext context,
    DateTimeRange dateRange,
    WidgetRef ref,
  ) {
    final dateFormat = DateFormat('MMM d, yyyy');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 20),
          const SizedBox(width: 8),
          Text(
            '${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _selectDateRange(context, ref),
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCards(SalesMetrics metrics) {
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
          value: '₹${metrics.totalRevenue.toStringAsFixed(2)}',
          icon: Icons.currency_rupee,
          color: Colors.green,
        ),
      ],
    );
  }
}
