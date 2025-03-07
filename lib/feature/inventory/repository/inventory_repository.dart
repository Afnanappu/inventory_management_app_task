import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:inventory_management_app_task/feature/inventory/services/inventory_services.dart';

class InventoryRepository {
  final InventoryServices _inventoryServices;

  InventoryRepository(this._inventoryServices);

  ///Add an item to the inventory
  Future<void> addItem(InventoryItemModel item) async {
    _inventoryServices.addItem(item);
  }

  ///Get all items
  Future<List<InventoryItemModel>> getAllItems() async {
    return _inventoryServices.getAllItems();
  }

  ///Get a single item by ID
  InventoryItemModel? getItemById(String id) {
    return _inventoryServices.getItemById(id);
  }

  ///Update an existing item
  Future<void> updateItem(InventoryItemModel item) async {
    _inventoryServices.updateItem(item);
  }

  ///Delete an item
  Future<void> deleteItem(String id) async {
    _inventoryServices.deleteItem(id);
  }
}
