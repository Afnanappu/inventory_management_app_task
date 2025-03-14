import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:inventory_management_app_task/feature/sales/view_model/sales_provider.dart';

class SalesReportSelectDateWidget extends ConsumerWidget {
  SalesReportSelectDateWidget({super.key, required this.dateRange});

  final DateTimeRange dateRange;

  final dateFormat = DateFormat('MMM d, yyyy');
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today, size: 20),
          const SizedBox(width: 8),
          Text(
            '${dateFormat.format(dateRange.start)} - ${dateFormat.format(dateRange.end)}',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          const Spacer(),
          TextButton(
            onPressed: () => _selectDateRange(context, ref),
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDateRange(BuildContext context, WidgetRef ref) async {
    final currentRange = ref.read(dateRangeProvider);
    final pickedRange = await showDateRangePicker(
      context: context,
      initialDateRange: currentRange,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF2A6B96),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedRange != null) {
      ref.read(dateRangeProvider.notifier).state = pickedRange;
    }
  }
}
