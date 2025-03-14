import 'dart:developer';

import 'package:flutter/material.dart';
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
  SalesModel? getSaleById(String id) {
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

  /// Compute total sales
  double getTotalSales() {
    return _realm.all<SalesModel>().fold(
      0.0,
      (sum, sale) => sum + sale.totalAmount,
    );
  }

  ///Get sales data based on the [dateRange]
  List<SalesModel> getFilteredSalesByDateRange(DateTimeRange dateRange) {
    final salesQuery = _realm
        .all<SalesModel>()
        .query('date >= \$0 AND date <= \$1', [
          dateRange.start,
          DateTime(
            dateRange.end.year,
            dateRange.end.month,
            dateRange.end.day + 1, //Added one to also get current day sales
            23,
            59,
            59,
          ),
        ]);

    return salesQuery.toList();
  }


  /// Retrieves a list of sales records for a specific customer.
  ///
  /// The sales records are sorted by date in descending order.
  ///
  /// [customerId] is the ID of the customer whose sales records are to be fetched.
  ///
  /// Returns a list of [SalesModel] associated with the given customer ID.
  List<SalesModel> getSalesByCustomer(String customerId) {
    return _realm.query<SalesModel>('customerId == \$0 SORT(date DESC)', [
      customerId,
    ]).toList();
  }

  /// Closes the Realm instance
  void close() {
    _realm.close();
  }
}
