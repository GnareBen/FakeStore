part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  final List<CartItem> items;

  const CartState({this.items = const []});

  int get totalItems => items.fold(0, (total, item) => total + item.quantity);
  double get totalPrice => items.fold(
    0,
    (total, item) => total + (item.product.price * item.quantity),
  );
  bool get isEmpty => items.isEmpty;

  @override
  List<Object> get props => [items];
}

final class CartInitial extends CartState {
  const CartInitial({super.items});
}
