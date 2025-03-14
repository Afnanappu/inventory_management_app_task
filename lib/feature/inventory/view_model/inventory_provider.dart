import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_metrics.dart';
import 'package:inventory_management_app_task/feature/inventory/repository/inventory_repository.dart';
import 'package:inventory_management_app_task/feature/inventory/services/inventory_services.dart';

class InventoryProvider
    extends StateNotifier<AsyncValue<List<InventoryItemModel>>> {
  final InventoryRepository _repository;
  InventoryProvider(this._repository) : super(const AsyncValue.loading()) {
    fetchAllItems(); // Load data initially
  }

  /// Get loaded data
  List<InventoryItemModel> get data => state.asData?.value ?? [];

  ///Fetch all items from the inventory. use value to search
  Future<void> fetchAllItems([String? value]) async {
    try {
      state = const AsyncValue.loading(); // loading

      final items = await _repository.getAllItems(); //fetching data

      //Filter items based on search
      if (value != null && !CustomRegExp.checkEmptySpaces(value)) {
        final filteredList =
            items
                .where(
                  (element) =>
                      element.name.contains(value) ||
                      element.description.contains(value),
                )
                .toList();
        state = AsyncValue.data(filteredList);
        return;
      }
      state = AsyncValue.data(items); // updating the state with new data
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace); // set state as error
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  ///Add an item to the inventory
  Future<void> addItem(InventoryItemModel item) async {
    try {
      await _repository.addItem(item);
      fetchAllItems(); // Refresh data
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  ///Delete an item from the inventory
  Future<void> deleteItem(String id) async {
    try {
      await _repository.deleteItem(id);
      fetchAllItems(); // Refresh data
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  ///Update an item from the inventory
  Future<void> updateItem(InventoryItemModel item) async {
    try {
      await _repository.updateItem(item);
      fetchAllItems(); // Refresh data
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      log(e.toString(), stackTrace: stackTrace);
    }
  }

  ///Get an item with id from the inventory
  InventoryItemModel? getItemById(String id) {
    try {
      return _repository.getItemById(id);
    } catch (e, stackTrace) {
      log(e.toString(), stackTrace: stackTrace);
      return null;
    }
  }
}

///Inventory provider that provide inventory functions
final inventoryProvider = StateNotifierProvider<
  InventoryProvider,
  AsyncValue<List<InventoryItemModel>>
>((ref) {
  final repository = ref.watch<InventoryRepository>(
    _inventoryRepositoryProvider,
  );

  return InventoryProvider(repository);
});

//inventory repository provider
final _inventoryRepositoryProvider = Provider((_) {
  final service = getIt.get<InventoryServices>();
  return InventoryRepository(service);
});

//=========================

final lowStockItemProvider = Provider<int>((ref) {
  final inventoryState = ref.watch(inventoryProvider);
  final count =
      inventoryState.asData?.value.where((item) => item.quantity <= 0).length;
  log('low stock count: $count');
  return count ?? 0;
});

// Inventory Metrics Provider
final inventoryMetricsProvider = Provider<InventoryMetrics>((ref) {
  final inventoryDataAsync = ref.watch(inventoryProvider);

  if (inventoryDataAsync is AsyncLoading || inventoryDataAsync is AsyncError) {
    return InventoryMetrics.empty();
  }

  final inventoryData = inventoryDataAsync.value ?? [];

  if (inventoryData.isEmpty) {
    return InventoryMetrics.empty();
  }

  // Calculate metrics
  final totalItems = inventoryData.length;
  final totalQuantity = inventoryData.fold<int>(
    0,
    (sum, item) => sum + item.quantity,
  );
  final totalValue = inventoryData.fold<double>(
    0,
    (sum, item) => sum + (item.price * item.quantity),
  );

  // Items with low stock (less than 10 units)
  final lowStockItems =
      inventoryData.where((item) => item.quantity < 10).toList();

  // Calculate stock level distribution for pie chart
  final stockLevels = [
    PieChartSectionData(
      value: lowStockItems.length.toDouble(),
      title: 'Low',
      color: Colors.red.shade400,
      radius: 60,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value:
          inventoryData
              .where((item) => item.quantity >= 10 && item.quantity < 50)
              .length
              .toDouble(),
      title: 'Medium',
      color: Colors.amber.shade400,
      radius: 60,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    PieChartSectionData(
      value:
          inventoryData.where((item) => item.quantity >= 50).length.toDouble(),
      title: 'High',
      color: Colors.green.shade400,
      radius: 60,
      titleStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  ];

  return InventoryMetrics(
    totalItems: totalItems,
    totalQuantity: totalQuantity,
    totalValue: totalValue,
    lowStockItems: lowStockItems,
    stockLevelSections: stockLevels,
  );
});
