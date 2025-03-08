import 'package:flutter/material.dart';
import 'package:inventory_management_app_task/core/constants/colors.dart';
import 'package:inventory_management_app_task/core/constants/font_styles.dart';
import 'package:inventory_management_app_task/core/utils/format_date.dart';
import 'package:inventory_management_app_task/feature/sales/view/components/sale_badge.dart';

class SaleListTile extends StatelessWidget {
  final String customerName;
  final String itemPrice;
  final DateTime saleAddDate;
  final void Function()? onTap;

  const SaleListTile({
    super.key,
    required this.customerName,
    required this.itemPrice,
    required this.saleAddDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          onTap: onTap,
          title: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  customerName,
                  overflow: TextOverflow.ellipsis,
                  style: AppFontStyle.saleTile,
                ),
                SaleBadge(
                  color: const Color.fromARGB(146, 154, 255, 170),
                  text: 'SALE',
                  onTap: () {},
                ),
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatDateTime(date: saleAddDate),
                style: AppFontStyle.smallLightGrey,
              ),
              Text(itemPrice, style: AppFontStyle.saleTile),
            ],
          ),
        ),
      ),
    );
  }
}
