part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCartEvent extends CartEvent {
  final ProductModel product;
  final int quantity;

  const AddToCartEvent({required this.product, this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];
}

class UpdateQuantityEvent extends CartEvent {
  final ProductModel product;
  final int quantity;

  const UpdateQuantityEvent({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];
}

class RemoveFromCartEvent extends CartEvent {
  final ProductModel product;

  const RemoveFromCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class ClearCartEvent extends CartEvent {}
