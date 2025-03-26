part of 'product_bloc.dart';

sealed class ProductState extends Equatable {
  const ProductState();
}

final class ProductInitial extends ProductState {
  @override
  List<Object> get props => [];
}

final class ProductLoading extends ProductState {
  @override
  List<Object> get props => [];
}

final class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

final class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
