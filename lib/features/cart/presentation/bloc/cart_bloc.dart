import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:cdc_mall/features/home/data/models/home_models.dart';

// Cart Events
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  final int quantity;

  const AddToCart(this.product, {this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];
}

class RemoveFromCart extends CartEvent {
  final Product product;

  const RemoveFromCart(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateCartItemQuantity extends CartEvent {
  final Product product;
  final int quantity;

  const UpdateCartItemQuantity(this.product, this.quantity);

  @override
  List<Object> get props => [product, quantity];
}

class ClearCart extends CartEvent {}

// Cart Item Model
class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({required this.product, required this.quantity});

  @override
  List<Object> get props => [product, quantity];

  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}

// Cart State
class CartState extends Equatable {
  final List<CartItem> items;
  final double total;

  const CartState({
    this.items = const [],
    this.total = 0.0,
  });

  @override
  List<Object> get props => [items, total];

  int get itemCount {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  CartState copyWith({List<CartItem>? items, double? total}) {
    return CartState(
      items: items ?? this.items,
      total: total ?? this.total,
    );
  }
}

// Cart Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final existingIndex =
        currentItems.indexWhere((item) => item.product == event.product);

    if (existingIndex != -1) {
      // If item already exists, update quantity
      final updatedItem = currentItems[existingIndex].copyWith(
          quantity: currentItems[existingIndex].quantity + event.quantity);
      currentItems[existingIndex] = updatedItem;
    } else {
      // Add new item
      currentItems.add(CartItem(
        product: event.product,
        quantity: event.quantity,
      ));
    }

    // Calculate new total
    final newTotal = _calculateTotal(currentItems);

    emit(state.copyWith(
      items: currentItems,
      total: newTotal,
    ));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.product == event.product);

    // Calculate new total
    final newTotal = _calculateTotal(currentItems);

    emit(state.copyWith(
      items: currentItems,
      total: newTotal,
    ));
  }

  void _onUpdateCartItemQuantity(
      UpdateCartItemQuantity event, Emitter<CartState> emit) {
    final currentItems = List<CartItem>.from(state.items);
    final index =
        currentItems.indexWhere((item) => item.product == event.product);

    if (index != -1) {
      if (event.quantity <= 0) {
        // Remove item if quantity is zero or negative
        currentItems.removeAt(index);
      } else {
        // Update quantity
        final updatedItem =
            currentItems[index].copyWith(quantity: event.quantity);
        currentItems[index] = updatedItem;
      }

      // Calculate new total
      final newTotal = _calculateTotal(currentItems);

      emit(state.copyWith(
        items: currentItems,
        total: newTotal,
      ));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(const CartState());
  }

  double _calculateTotal(List<CartItem> items) {
    return items.fold(
        0, (total, item) => total + (item.product.price * item.quantity));
  }
}
