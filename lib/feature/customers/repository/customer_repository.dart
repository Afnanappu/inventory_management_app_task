import '../models/customer_model.dart';
import '../services/customer_services.dart';

class CustomerRepository {
  final CustomerServices _customerServices;

  CustomerRepository(this._customerServices);

  /// Add a new customer asynchronously
  Future<void> addCustomer(CustomerModel customer) async {
    _customerServices.addCustomer(customer);
  }

  /// Get all customers asynchronously
  Future<List<CustomerModel>> getAllCustomers() async {
    return _customerServices.getAllCustomers();
  }

  /// Get a customer by ID asynchronously
  Future<CustomerModel?> getCustomerById(String id) async {
    return _customerServices.getCustomerById(id);
  }

  /// Update a customer asynchronously
  Future<void> updateCustomer(CustomerModel customer) async {
    _customerServices.updateCustomer(customer);
  }

  /// Delete a customer by ID asynchronously
  Future<void> deleteCustomer(String id) async {
    _customerServices.deleteCustomer(id);
  }
}
