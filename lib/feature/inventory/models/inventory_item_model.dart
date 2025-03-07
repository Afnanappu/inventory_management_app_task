// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:realm/realm.dart';

part 'inventory_item_model.realm.dart';

@RealmModel()
class _InventoryItemModel {
  @PrimaryKey()
  late final String id;

  late final String name;
  late final String description;
  late final int quantity;
  late final double price;

  InventoryItemModel copyWith({
    String? id,
    String? name,
    String? description,
    int? quantity,
    double? price,
  }) {
    return InventoryItemModel(
      id ?? this.id,
      name ?? this.name,
      description ?? this.description,
      quantity ?? this.quantity,
      price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'InventoryItemModel(id: $id, name: $name, description: $description, quantity: $quantity, price: $price)';
  }
}
