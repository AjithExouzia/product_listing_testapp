import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../services/local_storage_service.dart';

class FavoritesState extends Equatable {
  final Set<int> favoriteIds;

  const FavoritesState({required this.favoriteIds});

  const FavoritesState.initial() : favoriteIds = const {};

  @override
  List<Object?> get props => [favoriteIds];
}

class FavoritesCubit extends Cubit<FavoritesState> {
  final LocalStorageService _storageService;

  FavoritesCubit(this._storageService) : super(const FavoritesState.initial()) {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await _storageService.getFavorites();
    emit(FavoritesState(favoriteIds: favorites.toSet()));
  }

  Future<void> toggleFavorite(int productId) async {
    final isFavorite = state.favoriteIds.contains(productId);
    
    if (isFavorite) {
      await _storageService.removeFromFavorites(productId);
    } else {
      await _storageService.addToFavorites(productId);
    }
    
    await _loadFavorites();
  }

  bool isFavorite(int productId) {
    return state.favoriteIds.contains(productId);
  }
}
