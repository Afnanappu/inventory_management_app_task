import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/core/utils/custom_reg_exp.dart';
import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/repository/inventory_repository.dart';
import 'package:inventory_management_app_task/feature/inventory/services/inventory_services.dart';
import 'package:inventory_management_app_task/main.dart';

class InventoryProvider
    extends StateNotifier<AsyncValue<List<InventoryItemModel>>> {
  final InventoryRepository _repository;
  InventoryProvider(this._repository) : super(const AsyncValue.loading()) {
    fetchAllItems(); // Load data initially
  }

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
  Future<void> getItemById(String id) async {
    try {
      await _repository.getItemById(id);
      fetchAllItems(); // Refresh data
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      log(e.toString(), stackTrace: stackTrace);
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
