import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/presentation/screens/cart/cart_screen.dart';
import 'package:fake_store/presentation/widgets/cart/cart_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fake_store/presentation/bloc/cart/cart_bloc.dart';

class ProductDetailsPage extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.title, overflow: TextOverflow.ellipsis),
        elevation: 0,
        actions: [
          Row(children: [CartIcon(), const SizedBox(width: 12)]),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Ajouter le produit au panier
          context.read<CartBloc>().add(
            AddToCartEvent(product: product, quantity: 1),
          );

          // Afficher un message de confirmation
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${product.title} a été ajouté au panier'),
              action: SnackBarAction(
                label: 'Voir le panier',
                onPressed: () {
                  // Navigation vers le panier
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
              ),
              duration: const Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart),
        label: const Text('Ajouter au panier'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Hero(
                  tag: '${product.id}',
                  child: Image.network(
                    product.image,
                    height: 250,
                    fit: BoxFit.contain,
                    errorBuilder:
                        (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      product.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text(
                  product.category,
                  style: const TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.blueGrey,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  Text(
                    ' ${product.rating.rate}/5',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    ' (${product.rating.count} reviews)',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 28,
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                product.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 80), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }
}
