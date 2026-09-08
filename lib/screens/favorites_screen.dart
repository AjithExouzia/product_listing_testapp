import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/favorites_cubit.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../bloc/cart_cubit.dart';
import '../models/cart_item.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final gridColumns = isMobile ? 2 : 3;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        elevation: 0,
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, favoritesState) {
          if (favoritesState.favoriteIds.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No favorites yet',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add items to your favorites to see them here',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              if (productState is ProductLoaded) {
                final favoriteProducts = productState.products
                    .where((product) => favoritesState.favoriteIds.contains(product.id))
                    .toList();

                if (favoriteProducts.isEmpty) {
                  return const Center(
                    child: Text('No favorite products found'),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gridColumns,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: favoriteProducts.length,
                  itemBuilder: (context, index) {
                    final product = favoriteProducts[index];
                    return ProductCard(
                      product: product,
                      isFavorite: true,
                      onFavoriteTap: () {
                        context.read<FavoritesCubit>().toggleFavorite(product.id);
                      },
                      onTap: () {
                        context.push(
                          '/product/${product.id}',
                          extra: product.toJson(),
                        );
                      },
                      onAddToCart: () {
                        final cartItem = CartItem(
                          productId: product.id,
                          productTitle: product.title,
                          price: product.price,
                          quantity: 1,
                        );
                        context.read<CartCubit>().addToCart(cartItem);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Added to cart'),
                            duration: Duration(milliseconds: 1500),
                          ),
                        );
                      },
                    );
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          );
        },
      ),
    );
  }
}
