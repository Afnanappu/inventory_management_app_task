import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_metrics.dart';

class InventoryStockLevelChartWidget extends StatelessWidget {
  const InventoryStockLevelChartWidget({super.key, required this.metrics});

  final InventoryMetrics metrics;

  @override
  Widget build(BuildContext context) {
    if (metrics.stockLevelSections.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Stock Level Distribution',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: metrics.stockLevelSections,
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLegendItem(
                      text: 'Low Stock (<10)',
                      color: Colors.red.shade400,
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      text: 'Medium Stock (10-49)',
                      color: Colors.amber.shade400,
                    ),
                    const SizedBox(height: 12),
                    _buildLegendItem(
                      text: 'High Stock (50+)',
                      color: Colors.green.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _buildLegendItem({required String text, required Color color}) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
