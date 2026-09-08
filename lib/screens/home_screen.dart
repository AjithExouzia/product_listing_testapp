import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../bloc/cart_cubit.dart';
import '../bloc/favorites_cubit.dart';
import '../models/cart_item.dart';
import '../widgets/category_filter.dart';
import '../widgets/category_icon_grid.dart';
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<String> _categories;
  int _cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _categories = [
      'electronics',
      'jewelery',
      'men\'s clothing',
      'women\'s clothing',
    ];
    // Fetch products on init
    context.read<ProductBloc>().add(const FetchProductsEvent());
    _updateCartCount();
  }

  void _updateCartCount() {
    final cartState = context.read<CartCubit>().state;
    setState(() {
      _cartItemCount = cartState.totalQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final gridColumns = isMobile ? 2 : 3;
    final horizontalPadding = isMobile ? 16.0 : 24.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<ProductBloc>().add(const FetchProductsEvent());
            // Wait for products to load
            await Future.delayed(const Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.all(horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: isMobile ? 28 : 32,
                            backgroundImage: NetworkImage(
                              'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8bWFsZSUyMHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
                            ),
                            backgroundColor: Colors.grey[200],
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Morning 👋',
                                style: TextStyle(
                                  fontSize: isMobile ? 14 : 16,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Andrew Ainsley',
                                style: TextStyle(
                                  fontSize: isMobile ? 18 : 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.notifications_outlined),
                            onPressed: () {},
                          ),
                          Stack(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.favorite_outline),
                                onPressed: () {
                                  // Navigate to favorites screen
                                  context.pushNamed('favorites');
                                },
                              ),
                              if (_cartItemCount > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _cartItemCount.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Search Bar
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: ProductSearchBar(
                    onChanged: (query) {
                      context.read<ProductBloc>().add(
                        SearchProductsEvent(query),
                      );
                    },
                    onFilterTap: () {},
                  ),
                ),

                const SizedBox(height: 16),

                // Special Offers Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Special Offers',
                            style: TextStyle(
                              fontSize: isMobile ? 18 : 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'See All',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: isMobile ? 150 : 180,
                        decoration: BoxDecoration(
                          //   gradient: LinearGradient(
                          //     colors: [Colors.grey[300]!, Colors.grey[200]!],
                          // ),
                          image: DecorationImage(
                            image: AssetImage(
                              "images/vecteezy_stylized-black-mannequin-in-modern-boutique-fashion-display_65469174.jpeg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '30%',
                                      style: TextStyle(
                                        fontSize: isMobile ? 36 : 48,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Today\'s Special!',
                                      style: TextStyle(
                                        fontSize: isMobile ? 14 : 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      'Get discount for every\norder, only valid for today',
                                      style: TextStyle(
                                        fontSize: isMobile ? 11 : 13,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Category Icons
                CategoryIconGrid(
                  onCategoryTap: (category) {
                    context.read<ProductBloc>().add(
                      FilterByCategoryEvent(category),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Most Popular Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Most Popular',
                        style: TextStyle(
                          fontSize: isMobile ? 18 : 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See All',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                // Category Filter
                CategoryFilter(
                  categories: _categories,
                  onCategorySelected: (category) {
                    context.read<ProductBloc>().add(
                      FilterByCategoryEvent(category),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Products Grid
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (state is ProductError) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.error_outline,
                                size: 48,
                                color: Colors.red,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Error loading products',
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                state.message,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<ProductBloc>().add(
                                    const FetchProductsEvent(),
                                  );
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else if (state is ProductLoaded) {
                      if (state.products.isEmpty) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.shopping_cart_outlined,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No products found',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Try adjusting your search or filters',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                        ),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: gridColumns,
                                childAspectRatio: 0.75,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                              ),
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            return BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, favoritesState) {
                                final isFavorite = favoritesState.favoriteIds
                                    .contains(product.id);

                                return ProductCard(
                                  product: product,
                                  isFavorite: isFavorite,
                                  onFavoriteTap: () {
                                    context
                                        .read<FavoritesCubit>()
                                        .toggleFavorite(product.id);
                                  },
                                  onTap: () {
                                    // Navigate to product detail screen
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
                                    context.read<CartCubit>().addToCart(
                                      cartItem,
                                    );
                                    _updateCartCount();
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
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
