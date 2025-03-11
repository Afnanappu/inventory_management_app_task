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
  SalesModel? getSaleById(String id)  {
    return  _salesService.getSaleById(id);
  }

  /// Update a sale record
  Future<void> updateSale(SalesModel sale) async {
    await _salesService.updateSale(sale);
  }

  /// Delete a sale record
  Future<void> deleteSale(String id) async {
    await _salesService.deleteSale(id);
  }
}
