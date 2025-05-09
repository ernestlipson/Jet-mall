import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Navigation events
abstract class NavigationEvent extends Equatable {
  const NavigationEvent();

  @override
  List<Object> get props => [];
}

// Event to change the selected tab
class TabChanged extends NavigationEvent {
  final int index;

  const TabChanged(this.index);

  @override
  List<Object> get props => [index];
}

// Navigation states
class NavigationState extends Equatable {
  final int currentIndex;

  const NavigationState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

// Navigation bloc
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(const NavigationState(0)) {
    on<TabChanged>(_onTabChanged);
  }

  void _onTabChanged(TabChanged event, Emitter<NavigationState> emit) {
    emit(NavigationState(event.index));
  }
}
