import 'package:flutter/material.dart';

/// Widget to display a badge with item count on navigation icons
class CartBadge extends StatelessWidget {
  final Widget child;
  final int count;
  final Color badgeColor;
  final Color textColor;

  const CartBadge({
    super.key,
    required this.child,
    required this.count,
    this.badgeColor = const Color(0xFFF97316),
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        if (count > 0)
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: badgeColor,
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Center(
                child: Text(
                  count > 9 ? '9+' : count.toString(),
                  style: TextStyle(
                    color: textColor,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
