import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int productId;
  final String productTitle;
  final double price;
  final int quantity;

  const CartItem({
    required this.productId,
    required this.productTitle,
    required this.price,
    required this.quantity,
  });

  CartItem copyWith({
    int? productId,
    String? productTitle,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      productTitle: productTitle ?? this.productTitle,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, productTitle, price, quantity];
}
