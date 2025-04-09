import 'package:fake_store/data/models/cart_model.dart';
import 'package:fake_store/presentation/bloc/cart/cart_bloc.dart';
import 'package:fake_store/presentation/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;

  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return Dismissible(
      key: Key(product.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        color: Colors.red,
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        context.read<CartBloc>().add(RemoveFromCartEvent(product: product));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${product.title} a été supprimé du panier'),
            action: SnackBarAction(
              label: 'Annuler',
              onPressed: () {
                context.read<CartBloc>().add(
                  AddToCartEvent(product: product, quantity: item.quantity),
                );
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Image du produit
              SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                ),
              ),
              const SizedBox(width: 16),
              // Informations du produit
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${product.price.toStringAsFixed(2)} €',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              // Contrôles de quantité
              Column(
                children: [
                  Row(
                    children: [
                      QuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          if (item.quantity > 1) {
                            context.read<CartBloc>().add(
                              UpdateQuantityEvent(
                                product: product,
                                quantity: item.quantity - 1,
                              ),
                            );
                          } else {
                            // Si la quantité est 1, on demande confirmation pour supprimer
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text('Supprimer du panier ?'),
                                    content: Text(
                                      'Voulez-vous supprimer ${product.title} de votre panier ?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Annuler'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          context.read<CartBloc>().add(
                                            RemoveFromCartEvent(
                                              product: product,
                                            ),
                                          );
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Supprimer',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      QuantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          context.read<CartBloc>().add(
                            UpdateQuantityEvent(
                              product: product,
                              quantity: item.quantity + 1,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Total: ${(product.price * item.quantity).toStringAsFixed(2)} €',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
