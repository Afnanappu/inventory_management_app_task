import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/feature/inventory/view/widgets/inventory_export_widget.dart';
import 'package:inventory_management_app_task/feature/inventory/view/widgets/inventory_metric_cards_widget.dart';
import 'package:inventory_management_app_task/feature/inventory/view/widgets/inventory_report_item_build_widget.dart';
import 'package:inventory_management_app_task/feature/inventory/view/widgets/inventory_stock_level_chart_widget.dart';
import 'package:inventory_management_app_task/feature/inventory/view/widgets/low_stock_item_report_widget.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';

class ScreenInventoryReport extends ConsumerWidget {
  const ScreenInventoryReport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventoryData = ref.watch(inventoryProvider);
    final metrics = ref.watch(inventoryMetricsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory Report'),
        actions: [InventoryExportWidget(inventoryData: inventoryData)],
      ),
      body: inventoryData.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error:
            (error, stackTrace) =>
                Center(child: Text('Error loading data: ${error.toString()}')),
        data:
            (inventory) => RefreshIndicator(
              onRefresh: () async {
                return ref.refresh(inventoryProvider);
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 24,
                  children: [
                    InventoryMetricCardsWidget(metrics: metrics),
                    InventoryStockLevelChartWidget(metrics: metrics),
                    LowStockItemReportWidget(metrics: metrics),
                    InventoryReportItemBuildWidget(inventory: inventory),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
