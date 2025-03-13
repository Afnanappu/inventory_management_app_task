import 'package:fl_chart/fl_chart.dart';

class SalesMetrics {
  final int totalSales;
  final double totalRevenue;
  final Map<String, int> productSales;
  final List<MapEntry<String, int>> topProducts;
  final List<FlSpot> dailySalesData;

  SalesMetrics({
    required this.totalSales,
    required this.totalRevenue,
    required this.productSales,
    required this.topProducts,
    required this.dailySalesData,
  });

  factory SalesMetrics.empty() {
    return SalesMetrics(
      totalSales: 0,
      totalRevenue: 0,
      productSales: {},
      topProducts: [],
      dailySalesData: [],
    );
  }
}
