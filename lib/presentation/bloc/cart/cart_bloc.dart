import 'package:equatable/equatable.dart';
import 'package:fake_store/data/models/cart_model.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartInitial()) {
    on<AddToCartEvent>(_onAddToCart);
    on<UpdateQuantityEvent>(_onUpdateQuantity);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  void _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);

    // Vérifier si le produit est déjà dans le panier
    final existingItemIndex = currentItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (existingItemIndex != -1) {
      // Mettre à jour la quantité si le produit existe déjà
      final existingItem = currentItems[existingItemIndex];
      currentItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
      );
    } else {
      // Ajouter un nouvel élément au panier
      currentItems.add(
        CartItem(product: event.product, quantity: event.quantity),
      );
    }

    emit(CartInitial(items: currentItems));
  }

  void _onUpdateQuantity(UpdateQuantityEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);

    final itemIndex = currentItems.indexWhere(
      (item) => item.product.id == event.product.id,
    );

    if (itemIndex != -1) {
      if (event.quantity <= 0) {
        // Supprimer l'élément si la quantité est 0 ou moins
        currentItems.removeAt(itemIndex);
      } else {
        // Mettre à jour la quantité
        currentItems[itemIndex] = currentItems[itemIndex].copyWith(
          quantity: event.quantity,
        );
      }

      emit(CartInitial(items: currentItems));
    }
  }

  void _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);

    final updatedItems =
        currentItems
            .where((item) => item.product.id != event.product.id)
            .toList();

    emit(CartInitial(items: updatedItems));
  }

  void _onClearCart(ClearCartEvent event, Emitter<CartState> emit) {
    emit(const CartInitial());
  }
}
