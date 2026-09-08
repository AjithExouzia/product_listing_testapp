import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/cart_item.dart';

class LocalStorageService {
  static const String _favoritesKey = 'favorites';
  static const String _cartKey = 'cart';

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Favorites
  Future<void> addToFavorites(int productId) async {
    final favorites = await getFavorites();
    if (!favorites.contains(productId)) {
      favorites.add(productId);
      await _prefs.setStringList(_favoritesKey, favorites.map((id) => id.toString()).toList());
    }
  }

  Future<void> removeFromFavorites(int productId) async {
    final favorites = await getFavorites();
    favorites.remove(productId);
    await _prefs.setStringList(_favoritesKey, favorites.map((id) => id.toString()).toList());
  }

  Future<List<int>> getFavorites() async {
    final favoritesStr = _prefs.getStringList(_favoritesKey) ?? [];
    return favoritesStr.map((id) => int.parse(id)).toList();
  }

  Future<bool> isFavorite(int productId) async {
    final favorites = await getFavorites();
    return favorites.contains(productId);
  }

  // Cart
  Future<void> addToCart(CartItem item) async {
    final cartItems = await getCart();
    final existingIndex = cartItems.indexWhere((ci) => ci.productId == item.productId);
    
    if (existingIndex >= 0) {
      // Update quantity if product already in cart
      cartItems[existingIndex] = cartItems[existingIndex].copyWith(
        quantity: cartItems[existingIndex].quantity + item.quantity,
      );
    } else {
      cartItems.add(item);
    }
    
    await _saveCart(cartItems);
  }

  Future<void> removeFromCart(int productId) async {
    final cartItems = await getCart();
    cartItems.removeWhere((item) => item.productId == productId);
    await _saveCart(cartItems);
  }

  Future<void> updateCartItemQuantity(int productId, int quantity) async {
    final cartItems = await getCart();
    final index = cartItems.indexWhere((item) => item.productId == productId);
    
    if (index >= 0) {
      if (quantity <= 0) {
        cartItems.removeAt(index);
      } else {
        cartItems[index] = cartItems[index].copyWith(quantity: quantity);
      }
      await _saveCart(cartItems);
    }
  }

  Future<List<CartItem>> getCart() async {
    final cartStr = _prefs.getStringList(_cartKey) ?? [];
    return cartStr.map((itemJson) {
      final json = jsonDecode(itemJson);
      return CartItem(
        productId: json['productId'],
        productTitle: json['productTitle'],
        price: json['price'],
        quantity: json['quantity'],
      );
    }).toList();
  }

  Future<int> getCartItemCount() async {
    final cart = await getCart();
    return cart.fold<int>(0, (sum, item) => sum + item.quantity);
  }

  Future<void> clearCart() async {
    await _prefs.remove(_cartKey);
  }

  Future<void> _saveCart(List<CartItem> cartItems) async {
    final cartJson = cartItems.map((item) => jsonEncode({
      'productId': item.productId,
      'productTitle': item.productTitle,
      'price': item.price,
      'quantity': item.quantity,
    })).toList();
    
    await _prefs.setStringList(_cartKey, cartJson);
  }
}
