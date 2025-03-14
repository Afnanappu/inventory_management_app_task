import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/services/sales_service.dart';

class SalesRepository {
  final SalesService _salesService;

  SalesRepository(this._salesService);

  /// Add a new sale record
  Future<void> addSale(SalesModel sale) async {
    await _salesService.addSale(sale);
  }

  /// Get all sales records
  Future<List<SalesModel>> getAllSales() async {
    return await _salesService.getAllSales();
  }

  /// Get a sale by ID
  SalesModel? getSaleById(String id) {
    return _salesService.getSaleById(id);
  }

  /// Update a sale record
  Future<void> updateSale(SalesModel sale) async {
    await _salesService.updateSale(sale);
  }

  /// Get total sales amount
  double fetchTotalSales() {
    return _salesService.getTotalSales();
  }

  /// Delete a sale record
  Future<void> deleteSale(String id) async {
    await _salesService.deleteSale(id);
  }

  ///Get sales data based on the [dateRange]
  Future<List<SalesModel>> fetchFilteredSalesByDateRange(
    DateTimeRange dateRange,
  ) async {
    return _salesService.getFilteredSalesByDateRange(dateRange);
  }

  /// Retrieves a list of sales records for a specific customer.
  List<SalesModel> getSalesByCustomer(String customerId) {
    return _salesService.getSalesByCustomer(customerId);
  }
}
