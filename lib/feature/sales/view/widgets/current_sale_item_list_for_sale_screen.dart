import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/utils/format_money.dart';
import 'package:inventory_management_app_task/feature/inventory/view_model/inventory_provider.dart';
import 'package:inventory_management_app_task/feature/sales/models/sales_model.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

class CurrentSaleItemListForSaleScreen extends ConsumerWidget {
  final bool isView;
  final List<SaleItemModel> saleItem;
  const CurrentSaleItemListForSaleScreen({
    super.key,
    required this.isView,
    required this.saleItem,
  });

  void customAlertBox({
    required BuildContext context,
    required String title,
    required String content,
    required Function onPressedYes,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () {
                  onPressedYes();
                },
                child: const Text('Yes'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isView) {
        ref.read(selectedSaleItemProvider.notifier).state = saleItem;
      }
    });
    final saleItems = ref.watch(selectedSaleItemProvider);
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: saleItems.length,
      itemBuilder: (context, index) {
        final sale = saleItems[index];
        final item =
            ref.read(inventoryProvider.notifier).getItemById(sale.productId)!;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Stack(
            children: [
              ListTile(
                onTap: null,
                tileColor: const Color.fromARGB(255, 243, 255, 227),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        softWrap: true,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      formatMoney(number: item.price * sale.quantity),
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Subtotal'),
                        Text(
                          '${sale.quantity} x ${formatMoney(number: item.price, haveSymbol: false)} = ${formatMoney(number: item.price * sale.quantity)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              if (!isView)
                FractionalTranslation(
                  translation: const Offset(0.06, -0.45),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: const Text('Remove selected item'),
                                content: const Text('Are you sure?'),
                                actions: [
                                  TextButton(
                                    onPressed: () => context.pop(),
                                    child: const Text('No'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      ref
                                          .read(
                                            selectedSaleItemProvider.notifier,
                                          )
                                          .state = ref
                                              .read(selectedSaleItemProvider)
                                              .where(
                                                (element) =>
                                                    element.id != sale.id,
                                              )
                                              .toList();
                                      context.pop();
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                        );
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
