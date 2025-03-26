import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fake_store/data/models/product_model.dart';
import 'package:fake_store/data/repositories/product_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProductsEvent>(onFetchProducts);
  }

  Future<void> onFetchProducts(FetchProductsEvent event, Emitter<ProductState> emit) async {

    emit(ProductLoading());
    try {
      final products = await ProductRepository.getProducts();
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to fetch products : $e'));
    }
  }
}
