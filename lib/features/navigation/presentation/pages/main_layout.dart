import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cdc_mall/features/home/presentation/pages/home_page.dart';
import 'package:cdc_mall/features/cart/presentation/pages/cart_page.dart';
import 'package:cdc_mall/features/orders/presentation/pages/orders_page.dart';
import 'package:cdc_mall/features/settings/presentation/pages/settings_page.dart';
import 'package:cdc_mall/features/navigation/presentation/bloc/navigation_bloc.dart';
import 'package:cdc_mall/features/navigation/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:cdc_mall/features/navigation/presentation/widgets/fade_indexed_stack.dart';

/// Main layout with bottom navigation
class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    // List of pages for the bottom navigation
    final List<Widget> pages = [
      const HomePage(),
      const CartPage(),
      const OrdersPage(),
      const SettingsPage(),
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: FadeIndexedStackTransition(
            index: state.currentIndex,
            children: pages,
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.currentIndex,
            onTap: (index) {
              context.read<NavigationBloc>().add(TabChanged(index));
            },
          ),
        );
      },
    );
  }
}
