import 'package:fake_store/data/models/product_model.dart';

class CartModel {
  int id;
  int userId;
  DateTime date;
  List<CartItem> cartItems;

  CartModel({
    required this.id,
    required this.userId,
    required this.date,
    required this.cartItems,
  });

  CartModel copyWith({
    int? id,
    int? userId,
    DateTime? date,
    List<CartItem>? cartItems,
  }) => CartModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    date: date ?? this.date,
    cartItems: cartItems ?? this.cartItems,
  );
}

class CartItem {
  ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  CartItem copyWith({ProductModel? product, int? quantity}) => CartItem(
    product: product ?? this.product,
    quantity: quantity ?? this.quantity,
  );
}
