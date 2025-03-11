import 'package:get_it/get_it.dart';
import 'package:inventory_management_app_task/core/services/user_services.dart';
import 'package:inventory_management_app_task/feature/customers/services/customer_services.dart';
import 'package:inventory_management_app_task/feature/inventory/services/inventory_services.dart';
import 'package:inventory_management_app_task/feature/sales/services/sales_service.dart';

final getIt = GetIt.instance;

class AppDependencies {
  ///Inject dependence
  static void setup() {
    getIt.registerSingleton<UserServices>(UserServices()); //
    getIt.registerSingleton<InventoryServices>(InventoryServices()); //
    getIt.registerSingleton<CustomerServices>(CustomerServices()); //
    getIt.registerSingleton<SalesService>(
      SalesService(getIt.get<InventoryServices>()),
    ); //
  }
}
