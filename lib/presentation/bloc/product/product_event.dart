part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
}

final class FetchProductsEvent extends ProductEvent {
  @override
  List<Object> get props => [];
}