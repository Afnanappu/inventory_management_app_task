import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_metrics.dart';

class LowStockItemReportWidget extends StatelessWidget {
  const LowStockItemReportWidget({super.key, required this.metrics});

  final InventoryMetrics metrics;

  @override
  Widget build(BuildContext context) {
    if (metrics.lowStockItems.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Low Stock Items',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: metrics.lowStockItems.length,
            itemBuilder: (context, index) {
              final item = metrics.lowStockItems[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('Quantity: ${item.quantity}'),
              );
            },
          ),
        ],
      ),
    );
  }
}
