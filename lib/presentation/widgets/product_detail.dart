import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/presentation/bloc/cart/cart_bloc.dart';
import 'package:fake_store/presentation/screens/product/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailWidget extends StatelessWidget {
  final ProductModel product;
  final bool showAddToCartButton;
  final bool showFullDescription;
  final VoidCallback? onAddToCart;

  const ProductDetailWidget({
    super.key,
    required this.product,
    this.showAddToCartButton = true,
    this.showFullDescription = false,
    this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image du produit
            AspectRatio(
              aspectRatio: 1.5,
              child: Hero(
                tag: 'product-${product.id}',
                child: Image.network(
                  product.image,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (context, error, stackTrace) =>
                          const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titre
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: showFullDescription ? null : 2,
                    overflow:
                        showFullDescription
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Prix et rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(2)} €',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 18,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 18),
                          Text(
                            ' ${product.rating.rate} (${product.rating.count})',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Catégorie
                  Chip(
                    label: Text(
                      product.category,
                      style: const TextStyle(fontSize: 12),
                    ),
                    backgroundColor: Colors.grey.shade100,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),

                  // Description
                  if (showFullDescription) ...[
                    const SizedBox(height: 16),
                    const Text(
                      'Description:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      product.description,
                      style: const TextStyle(color: Colors.grey, height: 1.5),
                    ),
                  ],

                  // Bouton Ajouter au panier
                  if (showAddToCartButton) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (onAddToCart != null) {
                            onAddToCart!();
                          } else {
                            // Comportement par défaut: ajouter au panier
                            context.read<CartBloc>().add(
                              AddToCartEvent(product: product, quantity: 1),
                            );

                            // Feedback à l'utilisateur
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${product.title} a été ajouté au panier',
                                ),
                                duration: const Duration(seconds: 2),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        },
                        icon: const Icon(Icons.shopping_cart),
                        label: const Text('Ajouter au panier'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
