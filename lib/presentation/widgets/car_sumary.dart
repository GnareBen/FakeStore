import 'package:fake_store/data/models/cart_model.dart';
import 'package:fake_store/presentation/widgets/cart_sumary_row.dart';
import 'package:flutter/material.dart';

class CartSummary extends StatelessWidget {
  final List<CartItem> items;

  const CartSummary({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    // Calculer le sous-total, la TVA et le total
    final subtotal = items.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    final taxRate = 0.18; // TVA à 18%
    final tax = subtotal * taxRate;
    final total = subtotal + tax;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, -2),
            blurRadius: 4,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Résumé de la commande',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          buildSummaryRow('Sous-total', subtotal, context),
          buildSummaryRow('TVA (18%)', tax, context),
          const Divider(thickness: 1),
          buildSummaryRow('Total', total, context, isTotal: true),
        ],
      ),
    );
  }
}