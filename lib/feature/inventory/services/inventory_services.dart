import 'package:inventory_management_app_task/feature/inventory/models/inventory_item_model.dart';
import 'package:realm/realm.dart';

class InventoryServices {
  late final Realm _realm;

  InventoryServices() {
    var config = Configuration.local([InventoryItemModel.schema]);
    _realm = Realm(config);
  }

  ///Add an item to the inventory db
  void addItem(InventoryItemModel item) {
    _realm.write(() {
      _realm.add(item);
    });
  }

  ///Get all items from the inventory db
  List<InventoryItemModel> getAllItems() {
    return _realm.all<InventoryItemModel>().toList();
  }

  ///Get inventory item by its ID
  InventoryItemModel? getItemById(String id) {
    return _realm.find<InventoryItemModel>(id);
  }

  ///Update item in db
  void updateItem(InventoryItemModel item) {
    _realm.write(() {
      _realm.add(item, update: true);
    });
  }

  ///Delete an item
  void deleteItem(String id) {
    _realm.write(() {
      final item = _realm.find<InventoryItemModel>(id);
      if (item != null) {
        _realm.delete(item);
      }
    });
  }
}
