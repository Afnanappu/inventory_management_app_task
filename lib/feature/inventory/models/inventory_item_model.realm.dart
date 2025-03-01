// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_item_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class InventoryItemModel extends _InventoryItemModel
    with RealmEntity, RealmObjectBase, RealmObject {
  InventoryItemModel(
    String id,
    String name,
    String description,
    int quantity,
    double price,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'price', price);
  }

  InventoryItemModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) => throw RealmUnsupportedSetError();

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => throw RealmUnsupportedSetError();

  @override
  double get price => RealmObjectBase.get<double>(this, 'price') as double;
  @override
  set price(double value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<InventoryItemModel>> get changes =>
      RealmObjectBase.getChanges<InventoryItemModel>(this);

  @override
  Stream<RealmObjectChanges<InventoryItemModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<InventoryItemModel>(this, keyPaths);

  @override
  InventoryItemModel freeze() =>
      RealmObjectBase.freezeObject<InventoryItemModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'description': description.toEJson(),
      'quantity': quantity.toEJson(),
      'price': price.toEJson(),
    };
  }

  static EJsonValue _toEJson(InventoryItemModel value) => value.toEJson();
  static InventoryItemModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'description': EJsonValue description,
        'quantity': EJsonValue quantity,
        'price': EJsonValue price,
      } =>
        InventoryItemModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(description),
          fromEJson(quantity),
          fromEJson(price),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(InventoryItemModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, InventoryItemModel, 'InventoryItemModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('quantity', RealmPropertyType.int),
      SchemaProperty('price', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
