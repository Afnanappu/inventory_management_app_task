import 'dart:developer';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_metrics.dart';
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

  /// Get sales data based on the [dateRange]
  Future<List<SalesModel>> fetchFilteredSalesByDateRange(
    DateTimeRange dateRange,
  ) async {
    return await _repository.fetchFilteredSalesByDateRange(dateRange);
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

// Date Range Provider
final dateRangeProvider = StateProvider<DateTimeRange>((ref) {
  return DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );
});

// Sales Data Provider
final salesDataProvider = FutureProvider<List<SalesModel>>((ref) async {
  final dateRange = ref.watch(dateRangeProvider);
  final salesQuery = ref
      .watch(salesProvider.notifier)
      .fetchFilteredSalesByDateRange(dateRange);

  return salesQuery;
});

// Sales Metrics Provider
final salesMetricsProvider = Provider<SalesMetrics>((ref) {
  final salesData = ref.watch(salesDataProvider);

  // Return loading state if data is still loading
  if (salesData is AsyncLoading) {
    return SalesMetrics.empty();
  }

  // Return empty state if there's an error
  if (salesData is AsyncError) {
    return SalesMetrics.empty();
  }

  // Process data if available
  final sales = salesData.value ?? [];
  final totalSales = sales.length;
  final totalRevenue = sales.fold(0.0, (sum, sale) => sum + sale.totalAmount);

  // Calculate product sales
  final productSales = <String, int>{};
  for (final sale in sales) {
    for (final item in sale.saleItems) {
      productSales[item.productId] =
          (productSales[item.productId] ?? 0) + item.quantity;
    }
  }

  // Sort products by quantity sold
  final topProducts =
      productSales.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  // Calculate daily sales
  final dateRange = ref.watch(dateRangeProvider);
  final dailySales = _calculateDailySales(sales, dateRange);

  return SalesMetrics(
    totalSales: totalSales,
    totalRevenue: totalRevenue,
    productSales: productSales,
    topProducts: topProducts.take(5).toList(),
    dailySalesData: dailySales,
  );
});

List<FlSpot> _calculateDailySales(
  List<SalesModel> sales,
  DateTimeRange dateRange,
) {
  // Group sales by date
  final Map<DateTime, double> dailySales = {};

  // Initialize all days in the range with zero
  for (int i = 0; i <= dateRange.duration.inDays; i++) {
    final date = DateTime(
      dateRange.start.year,
      dateRange.start.month,
      dateRange.start.day,
    ).add(Duration(days: i));

    dailySales[date] = 0;
  }

  // Add sales data
  for (final sale in sales) {
    final saleDate = DateTime(sale.date.year, sale.date.month, sale.date.day);

    dailySales[saleDate] = (dailySales[saleDate] ?? 0) + sale.totalAmount;
  }

  // Convert to chart data points
  final chartData =
      dailySales.entries
          .map(
            (entry) => FlSpot(
              entry.key.millisecondsSinceEpoch.toDouble(),
              entry.value,
            ),
          )
          .toList()
        ..sort((a, b) => a.x.compareTo(b.x));

  return chartData;
}
