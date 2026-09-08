import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../services/product_api_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductApiService _apiService;
  List<Product> _allProducts = [];
  String? _currentCategory;
  String? _currentSearch;
  final Map<String, List<Product>> _categoryCache = {};
  bool _allProductsFetched = false;

  ProductBloc(this._apiService) : super(const ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchProductsByCategoryEvent>(_onFetchProductsByCategory);
    on<SearchProductsEvent>(_onSearchProducts);
    on<FilterByCategoryEvent>(_onFilterByCategory);
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      _allProducts = await _apiService.fetchAllProducts();
      _currentCategory = null;
      _currentSearch = null;
      emit(ProductLoaded(products: _allProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFetchProductsByCategory(
    FetchProductsByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    emit(const ProductLoading());
    try {
      final products = await _apiService.fetchProductsByCategory(event.category);
      _allProducts = products;
      _currentCategory = event.category;
      _currentSearch = null;
      emit(ProductLoaded(
        products: products,
        selectedCategory: event.category,
      ));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onSearchProducts(
    SearchProductsEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      final query = event.query.toLowerCase().trim();
      _currentSearch = query;

      if (query.isEmpty) {
        // If search is cleared, show all products or filtered by category
        if (_currentCategory != null) {
          final products = await _apiService.fetchProductsByCategory(_currentCategory!);
          emit(ProductLoaded(
            products: products,
            selectedCategory: _currentCategory,
          ));
        } else {
          emit(ProductLoaded(products: _allProducts));
        }
      } else {
        // Filter products based on search query
        final filtered = _allProducts
            .where((product) => product.title.toLowerCase().contains(query))
            .toList();
        emit(ProductLoaded(
          products: filtered,
          selectedCategory: _currentCategory,
          searchQuery: query,
        ));
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onFilterByCategory(
    FilterByCategoryEvent event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (event.category == 'all') {
        _currentCategory = null;
        _currentSearch = null;
        // Use cached all products if available, otherwise fetch
        if (_allProductsFetched) {
          emit(ProductLoaded(products: _allProducts));
        } else {
          emit(const ProductLoading());
          _allProducts = await _apiService.fetchAllProducts();
          _allProductsFetched = true;
          emit(ProductLoaded(products: _allProducts));
        }
      } else {
        // Check cache first before API call
        if (_categoryCache.containsKey(event.category)) {
          final cachedProducts = _categoryCache[event.category]!;
          _currentCategory = event.category;
          _currentSearch = null;
          emit(ProductLoaded(
            products: cachedProducts,
            selectedCategory: event.category,
          ));
        } else {
          emit(const ProductLoading());
          final products = await _apiService.fetchProductsByCategory(event.category);
          _categoryCache[event.category] = products;
          _currentCategory = event.category;
          _currentSearch = null;
          emit(ProductLoaded(
            products: products,
            selectedCategory: event.category,
          ));
        }
      }
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
