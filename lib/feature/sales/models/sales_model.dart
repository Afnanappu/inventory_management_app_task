import 'package:realm/realm.dart';
part 'sales_model.realm.dart';

@RealmModel()
class _SalesModel {
  @PrimaryKey()
  late final String id;
  late final String customerId;
  late final List<_SaleItemModel> saleItems;
  late final double totalAmount;
  late final DateTime date;

  @override
  String toString() {
    return 'SalesModel(id: $id, customerId: $customerId, '
        'saleItems: ${saleItems.map((item) => item.toString()).toList()}, '
        'totalAmount: $totalAmount, date: $date)\n';
  }
}

@RealmModel()
class _SaleItemModel {
  late final String productId;
  late final int quantity;
  late final double price;

  @override
  String toString() {
    return 'SalesModel(customerId: $productId,'
        'quantity: $quantity,'
        'price: $price\n';
  }
}
