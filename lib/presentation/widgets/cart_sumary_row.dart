import 'package:flutter/material.dart';

Widget buildSummaryRow(
  String label,
  double value,
  BuildContext context, {
  bool isTotal = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
          ),
        ),
        Text(
          '${value.toStringAsFixed(2)} €',
          style: TextStyle(
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            fontSize: isTotal ? 16 : 14,
            color: isTotal ? Theme.of(context).colorScheme.primary : null,
          ),
        ),
      ],
    ),
  );
}
