import 'package:fl_chart/fl_chart.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';

class InventoryMetrics {
  final int totalItems;
  final int totalQuantity;
  final double totalValue;
  final List<InventoryItemModel> lowStockItems;
  final List<PieChartSectionData> stockLevelSections;

  InventoryMetrics({
    required this.totalItems,
    required this.totalQuantity,
    required this.totalValue,
    required this.lowStockItems,
    required this.stockLevelSections,
  });

  factory InventoryMetrics.empty() {
    return InventoryMetrics(
      totalItems: 0,
      totalQuantity: 0,
      totalValue: 0,
      lowStockItems: [],
      stockLevelSections: [],
    );
  }
}
