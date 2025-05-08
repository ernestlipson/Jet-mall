import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cdc_mall/features/home/data/dummy_data_provider.dart';
import 'package:cdc_mall/features/home/data/models/home_models.dart';
import 'package:cdc_mall/features/home/data/services/promo_banner_service.dart';

// Home Events
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeData extends HomeEvent {
  const LoadHomeData();
}

class ToggleFavorite extends HomeEvent {
  final Product product;

  const ToggleFavorite(this.product);

  @override
  List<Object> get props => [product];
}

// Home States
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<PromoBanner> promoBanners;
  final List<Category> categories;
  final List<Product> newProducts;

  const HomeLoaded({
    required this.promoBanners,
    required this.categories,
    required this.newProducts,
  });

  @override
  List<Object> get props => [promoBanners, categories, newProducts];

  HomeLoaded copyWith({
    List<PromoBanner>? promoBanners,
    List<Category>? categories,
    List<Product>? newProducts,
  }) {
    return HomeLoaded(
      promoBanners: promoBanners ?? this.promoBanners,
      categories: categories ?? this.categories,
      newProducts: newProducts ?? this.newProducts,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}

// Home Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeLoading()) {
    on<LoadHomeData>(_onLoadHomeData);
    on<ToggleFavorite>(_onToggleFavorite);
  }
  Future<void> _onLoadHomeData(
      LoadHomeData event, Emitter<HomeState> emit) async {
    try {
      emit(const HomeLoading());

      // Load promo banners from JSON file
      final promoBanners = await PromoBannerService.loadPromoBanners();

      // If no banners were loaded from JSON or there was an error, use dummy data as fallback
      final finalPromoBanners = promoBanners.isEmpty
          ? DummyDataProvider.getPromoBanners()
          : promoBanners;

      // Load other data from dummy provider
      final categories = DummyDataProvider.getCategories();
      final newProducts = DummyDataProvider.getNewProducts();

      emit(HomeLoaded(
        promoBanners: finalPromoBanners,
        categories: categories,
        newProducts: newProducts,
      ));
    } catch (e) {
      emit(HomeError('Failed to load home data: $e'));
    }
  }

  void _onToggleFavorite(ToggleFavorite event, Emitter<HomeState> emit) {
    final state = this.state;
    if (state is HomeLoaded) {
      // Create a new list with the updated product
      final updatedProducts = state.newProducts.map((product) {
        if (product.name == event.product.name) {
          return Product(
            name: product.name,
            price: product.price,
            color: product.color,
            imageUrls: product.imageUrls,
            isFavorite: !product.isFavorite,
          );
        }
        return product;
      }).toList();

      emit(state.copyWith(newProducts: updatedProducts));
    }
  }
}
