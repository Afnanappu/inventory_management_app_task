import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/repository/sales_repository.dart';
import 'package:inventory_management_app_task/feature/sales/services/sales_service.dart';

class SalesProvider extends StateNotifier<AsyncValue<List<SalesModel>>> {
  final SalesRepository _repository;

  // Constructor initializes the provider and fetches all sales data
  SalesProvider(this._repository) : super(const AsyncValue.loading()) {
    fetchAllSales();
  }

  /// Get loaded sales data
  List<SalesModel> get sales => state.asData?.value ?? [];

  /// Compute total sales sum dynamically
  double get totalSales =>
      sales.fold(0.0, (sum, sale) => sum + sale.totalAmount);

  /// Fetch all sales records from the repository
  Future<void> fetchAllSales() async {
    try {
      state = const AsyncValue.loading();
      final sales = await _repository.getAllSales();
      state = AsyncValue.data(sales);
      // sales.forEach((element) => log(element.toString()));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      log('Error fetching sales: $e', stackTrace: stackTrace);
    }
  }

  /// Add a new sale record
  Future<void> addSale(SalesModel sale) async {
    try {
      await _repository.addSale(sale);
      fetchAllSales(); // Refresh the sales list
    } catch (e, stackTrace) {
      log('Error adding sale: $e', stackTrace: stackTrace);
    }
  }

  /// Update an existing sale record
  Future<void> updateSale(SalesModel sale) async {
    try {
      await _repository.updateSale(sale);
      fetchAllSales();
    } catch (e, stackTrace) {
      log('Error updating sale: $e', stackTrace: stackTrace);
    }
  }

  /// Delete a sale record by ID
  Future<void> deleteSale(String saleId) async {
    try {
      await _repository.deleteSale(saleId);
      fetchAllSales();
    } catch (e, stackTrace) {
      log('Error deleting sale: $e', stackTrace: stackTrace);
    }
  }

  ///Get sales by ID
  SalesModel getSaleById(String id) {
    return _repository.getSaleById(id)!;
  }
}

/// provides list of sales data and functions.
final salesProvider = StateNotifierProvider(
  (ref) => SalesProvider(ref.watch(_salesRepositoryProvider)),
);

final _salesRepositoryProvider = Provider((ref) {
  final service = getIt.get<SalesService>();
  return SalesRepository(service);
});

// =========

final selectedSaleItemProvider = StateProvider<List<SaleItemModel>>((ref) {
  return [];
});

///This provider will provide the total sale
final totalSalesProvider = Provider<double>((ref) {
  final saleState = ref.watch(salesProvider);
  return saleState.asData?.value.fold(
        0.0,
        (sum, sale) => sum! + sale.totalAmount,
      ) ??
      0;
});
