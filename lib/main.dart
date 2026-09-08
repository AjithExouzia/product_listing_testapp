import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'bloc/product_bloc.dart';
import 'bloc/cart_cubit.dart';
import 'bloc/favorites_cubit.dart';
import 'services/product_api_service.dart';
import 'services/local_storage_service.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/orders_screen.dart';
import 'screens/wallet_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/nav_shell.dart';
import 'models/product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize local storage
  final localStorageService = LocalStorageService();
  await localStorageService.init();

  runApp(MyApp(localStorageService: localStorageService));
}

class MyApp extends StatelessWidget {
  final LocalStorageService localStorageService;

  const MyApp({Key? key, required this.localStorageService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final apiService = ProductApiService();

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductBloc(apiService)),
        BlocProvider(create: (context) => CartCubit(localStorageService)),
        BlocProvider(create: (context) => FavoritesCubit(localStorageService)),
      ],
      child: MaterialApp.router(
        title: 'Product Listing App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.black,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black87),
            bodySmall: TextStyle(color: Colors.grey),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        routerConfig: _createRouter(),
      ),
    );
  }

  GoRouter _createRouter() {
    return GoRouter(
      routes: [
        ShellRoute(
          builder: (context, state, child) => NavShell(child: child),
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
            GoRoute(
              path: '/cart',
              name: 'cart',
              builder: (context, state) => const CartScreen(),
            ),
            GoRoute(
              path: '/orders',
              name: 'orders',
              builder: (context, state) => const OrdersScreen(),
            ),
            GoRoute(
              path: '/wallet',
              name: 'wallet',
              builder: (context, state) => const WalletScreen(),
            ),
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        GoRoute(
          path: '/product/:id',
          name: 'product_detail',
          builder: (context, state) {
            final productJson = state.extra as Map<String, dynamic>;
            final product = Product.fromJson(productJson);
            return ProductDetailScreen(product: product);
          },
        ),
        GoRoute(
          path: '/favorites',
          name: 'favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
      ],
      errorBuilder:
          (context, state) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(child: Text('Route error: ${state.error}')),
          ),
    );
  }
}
