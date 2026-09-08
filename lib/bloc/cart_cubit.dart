import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/cart_item.dart';
import '../services/local_storage_service.dart';

class CartState extends Equatable {
  final List<CartItem> items;
  final int totalQuantity;

  const CartState({
    required this.items,
    required this.totalQuantity,
  });

  const CartState.initial()
      : items = const [],
        totalQuantity = 0;

  CartState copyWith({
    List<CartItem>? items,
    int? totalQuantity,
  }) {
    return CartState(
      items: items ?? this.items,
      totalQuantity: totalQuantity ?? this.totalQuantity,
    );
  }

  @override
  List<Object?> get props => [items, totalQuantity];
}

class CartCubit extends Cubit<CartState> {
  final LocalStorageService _storageService;

  CartCubit(this._storageService) : super(const CartState.initial()) {
    _loadCart();
  }

  Future<void> _loadCart() async {
    final items = await _storageService.getCart();
    final totalQuantity = items.fold<int>(0, (sum, item) => sum + item.quantity);
    emit(CartState(items: items, totalQuantity: totalQuantity));
  }

  Future<void> addToCart(CartItem item) async {
    await _storageService.addToCart(item);
    await _loadCart();
  }

  Future<void> removeFromCart(int productId) async {
    await _storageService.removeFromCart(productId);
    await _loadCart();
  }

  Future<void> updateQuantity(int productId, int quantity) async {
    await _storageService.updateCartItemQuantity(productId, quantity);
    await _loadCart();
  }

  Future<void> clearCart() async {
    await _storageService.clearCart();
    emit(const CartState(items: [], totalQuantity: 0));
  }
}
