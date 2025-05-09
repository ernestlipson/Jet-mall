import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cdc_mall/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:cdc_mall/features/navigation/presentation/widgets/cart_badge.dart';

/// Custom styled bottom navigation bar component
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Home'),
              _buildCartNavItem(),
              _buildNavItem(
                  2, Icons.receipt_long_outlined, Icons.receipt_long, 'Orders'),
              _buildNavItem(
                  3, Icons.settings_outlined, Icons.settings, 'Settings'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCartNavItem() {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return InkWell(
        onTap: () => onTap(1),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: currentIndex == 1
                ? const Color(0xFFFFEEE3)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CartBadge(
                count: state.itemCount,
                child: Icon(
                  currentIndex == 1
                      ? Icons.shopping_cart
                      : Icons.shopping_cart_outlined,
                  color:
                      currentIndex == 1 ? const Color(0xFFF97316) : Colors.grey,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Cart',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight:
                      currentIndex == 1 ? FontWeight.w600 : FontWeight.normal,
                  color:
                      currentIndex == 1 ? const Color(0xFFF97316) : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = currentIndex == index;
    return InkWell(
      onTap: () => onTap(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFEEE3) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? const Color(0xFFF97316) : Colors.grey,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? const Color(0xFFF97316) : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
