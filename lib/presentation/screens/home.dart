import 'package:fake_store/presentation/bloc/product/product_bloc.dart';
import 'package:fake_store/presentation/widgets/cart_icon.dart';
import 'package:fake_store/presentation/widgets/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(FetchProductsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Ma boutique',
            style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
          ),
          actions: [
            Row(children: [CartIcon(), const SizedBox(width: 12)]),
          ],
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return ProductList(products: state.products);
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else {
              return const Center(child: Text('Something went wrong!'));
            }
          },
        ),
      ),
    );
  }
}
