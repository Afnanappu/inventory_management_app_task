import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/view/components/inventory_item_list_tile.dart';

class InventoryReportItemBuildWidget extends StatelessWidget {
  const InventoryReportItemBuildWidget({super.key, required this.inventory});

  final List<InventoryItemModel> inventory;

  @override
  Widget build(BuildContext context) {
    if (inventory.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Inventory List',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: inventory.length,
            itemBuilder: (context, index) {
              final item = inventory[index];
              return InventoryItemListTile(
                index: index,
                itemModel: item,
                trailing: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
