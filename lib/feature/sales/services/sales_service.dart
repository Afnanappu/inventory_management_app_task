import 'dart:developer';

import 'package:inventory_management_app_task/feature/inventory/services/inventory_services.dart';
import 'package:realm/realm.dart';
import '../models/sales_model.dart';

class SalesService {
  final InventoryServices _inventoryServices;
  late final Realm _realm;

  SalesService(this._inventoryServices) {
    final config = Configuration.local([
      SalesModel.schema,
      SaleItemModel.schema,
    ]);
    _realm = Realm(config);
  }

  /// Adds a new sale record
  Future<void> addSale(SalesModel sale) async {
    try {
      _realm.write(() {
        _realm.add(sale);
      });
      _inventoryServices.deductItemQuantity(sale.saleItems);
    } on RealmException catch (e, stack) {
      log('${e.message}\n${e.helpLink}', stackTrace: stack);
    } on RealmError catch (e, stack) {
      log(e.message.toString(), stackTrace: stack);
    }
  }

  /// Retrieves all sales records
  Future<List<SalesModel>> getAllSales() async {
    return _realm.all<SalesModel>().toList();
  }

  /// Retrieves a specific sale by ID
  Future<SalesModel?> getSaleById(String id) async {
    return _realm.find<SalesModel>(id);
  }

  /// Updates an existing sale record
  Future<void> updateSale(SalesModel updatedSale) async {
    _realm.write(() {
      _realm.add(updatedSale, update: true);
    });
  }

  /// Deletes a sale record
  Future<void> deleteSale(String id) async {
    final sale = _realm.find<SalesModel>(id);
    if (sale != null) {
      _realm.write(() {
        _realm.delete(sale);
      });
    }
  }

  /// Closes the Realm instance
  void close() {
    _realm.close();
  }
}
