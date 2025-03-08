// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class SalesModel extends _SalesModel
    with RealmEntity, RealmObjectBase, RealmObject {
  SalesModel(
    String id,
    String customerId,
    double totalAmount,
    DateTime date, {
    Iterable<SaleItemModel> saleItems = const [],
  }) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'customerId', customerId);
    RealmObjectBase.set<RealmList<SaleItemModel>>(
        this, 'saleItems', RealmList<SaleItemModel>(saleItems));
    RealmObjectBase.set(this, 'totalAmount', totalAmount);
    RealmObjectBase.set(this, 'date', date);
  }

  SalesModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get customerId =>
      RealmObjectBase.get<String>(this, 'customerId') as String;
  @override
  set customerId(String value) => throw RealmUnsupportedSetError();

  @override
  RealmList<SaleItemModel> get saleItems =>
      RealmObjectBase.get<SaleItemModel>(this, 'saleItems')
          as RealmList<SaleItemModel>;
  @override
  set saleItems(covariant RealmList<SaleItemModel> value) =>
      throw RealmUnsupportedSetError();

  @override
  double get totalAmount =>
      RealmObjectBase.get<double>(this, 'totalAmount') as double;
  @override
  set totalAmount(double value) => throw RealmUnsupportedSetError();

  @override
  DateTime get date => RealmObjectBase.get<DateTime>(this, 'date') as DateTime;
  @override
  set date(DateTime value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<SalesModel>> get changes =>
      RealmObjectBase.getChanges<SalesModel>(this);

  @override
  Stream<RealmObjectChanges<SalesModel>> changesFor([List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<SalesModel>(this, keyPaths);

  @override
  SalesModel freeze() => RealmObjectBase.freezeObject<SalesModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'customerId': customerId.toEJson(),
      'saleItems': saleItems.toEJson(),
      'totalAmount': totalAmount.toEJson(),
      'date': date.toEJson(),
    };
  }

  static EJsonValue _toEJson(SalesModel value) => value.toEJson();
  static SalesModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'customerId': EJsonValue customerId,
        'totalAmount': EJsonValue totalAmount,
        'date': EJsonValue date,
      } =>
        SalesModel(
          fromEJson(id),
          fromEJson(customerId),
          fromEJson(totalAmount),
          fromEJson(date),
          saleItems: fromEJson(ejson['saleItems']),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SalesModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, SalesModel, 'SalesModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('customerId', RealmPropertyType.string),
      SchemaProperty('saleItems', RealmPropertyType.object,
          linkTarget: 'SaleItemModel',
          collectionType: RealmCollectionType.list),
      SchemaProperty('totalAmount', RealmPropertyType.double),
      SchemaProperty('date', RealmPropertyType.timestamp),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}

class SaleItemModel extends _SaleItemModel
    with RealmEntity, RealmObjectBase, RealmObject {
  SaleItemModel(
    String id,
    String productId,
    int quantity,
    double price,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'productId', productId);
    RealmObjectBase.set(this, 'quantity', quantity);
    RealmObjectBase.set(this, 'price', price);
  }

  SaleItemModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get productId =>
      RealmObjectBase.get<String>(this, 'productId') as String;
  @override
  set productId(String value) => throw RealmUnsupportedSetError();

  @override
  int get quantity => RealmObjectBase.get<int>(this, 'quantity') as int;
  @override
  set quantity(int value) => throw RealmUnsupportedSetError();

  @override
  double get price => RealmObjectBase.get<double>(this, 'price') as double;
  @override
  set price(double value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<SaleItemModel>> get changes =>
      RealmObjectBase.getChanges<SaleItemModel>(this);

  @override
  Stream<RealmObjectChanges<SaleItemModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<SaleItemModel>(this, keyPaths);

  @override
  SaleItemModel freeze() => RealmObjectBase.freezeObject<SaleItemModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'productId': productId.toEJson(),
      'quantity': quantity.toEJson(),
      'price': price.toEJson(),
    };
  }

  static EJsonValue _toEJson(SaleItemModel value) => value.toEJson();
  static SaleItemModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'productId': EJsonValue productId,
        'quantity': EJsonValue quantity,
        'price': EJsonValue price,
      } =>
        SaleItemModel(
          fromEJson(id),
          fromEJson(productId),
          fromEJson(quantity),
          fromEJson(price),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(SaleItemModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, SaleItemModel, 'SaleItemModel', [
      SchemaProperty('id', RealmPropertyType.string),
      SchemaProperty('productId', RealmPropertyType.string),
      SchemaProperty('quantity', RealmPropertyType.int),
      SchemaProperty('price', RealmPropertyType.double),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
