// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  late final String id;
  late final String productId;
  late final int quantity;
  late final double price;

  @override
  String toString() {
    return 'SalesModel(customerId: $productId,'
        'quantity: $quantity,'
        'price: $price\n';
  }

  @override
  bool operator ==(covariant SaleItemModel other) {
    if (identical(this, other)) return true;

    return other.productId == productId &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode => productId.hashCode ^ quantity.hashCode ^ price.hashCode;

  SaleItemModel copyWith({
    String? id,
    String? productId,
    int? quantity,
    double? price,
  }) {
    return SaleItemModel(
      id ?? this.id,
      productId ?? this.productId,
      quantity ?? this.quantity,
      price ?? this.price,
    );
  }
}
