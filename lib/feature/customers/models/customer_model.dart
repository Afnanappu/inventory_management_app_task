import 'package:realm/realm.dart';
part 'customer_model.realm.dart';

@RealmModel()
class _CustomerModel {
  @PrimaryKey()
  late final String id;
  late final String name;
  late final String address;
  late final String phone;
}
