// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_model.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class CustomerModel extends _CustomerModel
    with RealmEntity, RealmObjectBase, RealmObject {
  CustomerModel(
    String id,
    String name,
    String address,
    String phone,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'address', address);
    RealmObjectBase.set(this, 'phone', phone);
  }

  CustomerModel._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => throw RealmUnsupportedSetError();

  @override
  String get address => RealmObjectBase.get<String>(this, 'address') as String;
  @override
  set address(String value) => throw RealmUnsupportedSetError();

  @override
  String get phone => RealmObjectBase.get<String>(this, 'phone') as String;
  @override
  set phone(String value) => throw RealmUnsupportedSetError();

  @override
  Stream<RealmObjectChanges<CustomerModel>> get changes =>
      RealmObjectBase.getChanges<CustomerModel>(this);

  @override
  Stream<RealmObjectChanges<CustomerModel>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<CustomerModel>(this, keyPaths);

  @override
  CustomerModel freeze() => RealmObjectBase.freezeObject<CustomerModel>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'address': address.toEJson(),
      'phone': phone.toEJson(),
    };
  }

  static EJsonValue _toEJson(CustomerModel value) => value.toEJson();
  static CustomerModel _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'address': EJsonValue address,
        'phone': EJsonValue phone,
      } =>
        CustomerModel(
          fromEJson(id),
          fromEJson(name),
          fromEJson(address),
          fromEJson(phone),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(CustomerModel._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, CustomerModel, 'CustomerModel', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('address', RealmPropertyType.string),
      SchemaProperty('phone', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
