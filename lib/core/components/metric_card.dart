import 'package:flutter/material.dart';

class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    this.margin,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // child: CustomCard(
      //   margin: const EdgeInsets.all(16),
      //   padding: EdgeInsets.zero,
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Row(
      //         children: [
      //           Icon(icon, color: color, size: 20),
      //           const SizedBox(width: 8),
      //           Text(
      //             title,
      //             style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      //           ),
      //         ],
      //       ),
      //       const SizedBox(height: 12),
      //       Text(
      //         value,
      //         style: TextStyle(
      //           fontSize: 24,
      //           fontWeight: FontWeight.bold,
      //           color: Colors.grey.shade800,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
