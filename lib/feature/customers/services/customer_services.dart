import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:realm/realm.dart';

class CustomerServices {
  late final Realm _realm;

  CustomerServices() {
    // Initialize Realm with the CustomerModel schema
    final config = Configuration.local([CustomerModel.schema]);
    _realm = Realm(config);
  }

  /// Create - Add a new customer to the database
  void addCustomer(CustomerModel customer) {
    _realm.write(() {
      _realm.add(customer);
    });
  }

  /// Read - Get all customers from the database
  List<CustomerModel> getAllCustomers() {
    return _realm.all<CustomerModel>().toList();
  }

  /// Read - Get a specific customer by ID
  CustomerModel? getCustomerById(String id) {
    return _realm.find<CustomerModel>(id);
  }

  /// Update - Modify an existing customer
  void updateCustomer(CustomerModel customer) {
    _realm.write(() {
      _realm.add(customer, update: true);
    });
  }

  /// Delete - Remove a customer from the database
  void deleteCustomer(String id) {
    final customer = getCustomerById(id);
    if (customer != null) {
      _realm.write(() {
        _realm.delete(customer);
      });
    }
  }
}
