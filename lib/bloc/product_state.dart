import 'package:equatable/equatable.dart';
import '../models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();
}

class ProductLoading extends ProductState {
  const ProductLoading();
}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final String? selectedCategory;
  final String? searchQuery;

  const ProductLoaded({
    required this.products,
    this.selectedCategory,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [products, selectedCategory, searchQuery];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
