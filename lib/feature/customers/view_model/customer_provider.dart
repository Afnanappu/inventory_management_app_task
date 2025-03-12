import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_management_app_task/app_dependencies.dart';
import 'package:inventory_management_app_task/feature/customers/models/customer_model.dart';
import 'package:inventory_management_app_task/feature/customers/repository/customer_repository.dart';
import 'package:inventory_management_app_task/feature/customers/services/customer_services.dart';

class CustomerProvider extends StateNotifier<AsyncValue<List<CustomerModel>>> {
  final CustomerRepository _repository;

  CustomerProvider(this._repository) : super(const AsyncValue.loading()) {
    fetchAllCustomers();
  }

  /// Fetch all customers from the database
  Future<void> fetchAllCustomers() async {
    try {
      state = const AsyncValue.loading();
      final customers = await _repository.getAllCustomers();
      state = AsyncValue.data(customers);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      log('Error fetching customers: $e', stackTrace: stackTrace);
    }
  }

  /// Add a new customer
  Future<void> addCustomer(CustomerModel customer) async {
    try {
      await _repository.addCustomer(customer);
      fetchAllCustomers(); // Refresh list after adding
    } catch (e, stackTrace) {
      log('Error adding customer: $e', stackTrace: stackTrace);
    }
  }

  /// Update an existing customer
  Future<void> updateCustomer(CustomerModel customer) async {
    try {
      await _repository.updateCustomer(customer);
      fetchAllCustomers(); // Refresh list after updating
    } catch (e, stackTrace) {
      log('Error updating customer: $e', stackTrace: stackTrace);
    }
  }

  /// Delete a customer by ID
  Future<void> deleteCustomer(String id) async {
    try {
      await _repository.deleteCustomer(id);
      fetchAllCustomers(); // Refresh list after deletion
    } catch (e, stackTrace) {
      log('Error deleting customer: $e', stackTrace: stackTrace);
    }
  }

  ///
  CustomerModel? getCustomerById(String id) {
    try {
      return _repository.getCustomerById(id);
    } catch (e, stackTrace) {
      log('Error deleting customer: $e', stackTrace: stackTrace);
      return null;
    }
  }
}

final customerProvider = StateNotifierProvider((ref) {
  final repository = ref.watch(_customerRepositoryProvider);
  return CustomerProvider(repository);
});

final _customerRepositoryProvider = Provider<CustomerRepository>((ref) {
  final service = getIt.get<CustomerServices>();
  return CustomerRepository(service);
});


//====================

