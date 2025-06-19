import 'package:flutter/material.dart';

class FoodieBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const FoodieBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  static const List<_NavBarItemData> _items = [
    _NavBarItemData(icon: Icons.settings_rounded, label: 'Manage'),

    _NavBarItemData(icon: Icons.home_rounded, label: 'Home'),

    _NavBarItemData(icon: Icons.shopping_cart_rounded, label: 'Cart'),
  ];

  @override
  Widget build(BuildContext context) {
    final Color primary = Colors.teal.shade600;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade100.withOpacity(0.25),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(_items.length, (index) {
          final selected = index == currentIndex;
          final item = _items[index];
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: selected ? Colors.white : Colors.transparent,
                        boxShadow:
                            selected
                                ? [
                                  BoxShadow(
                                    color: primary.withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                                : [],
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        item.icon,
                        size: 28,
                        color: selected ? primary : Colors.teal.shade400,
                      ),
                    ),
                    const SizedBox(height: 4),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 350),
                      style: TextStyle(
                        color: selected ? Colors.white : Colors.teal.shade400,
                        fontWeight:
                            selected ? FontWeight.bold : FontWeight.w500,
                        fontSize: selected ? 14 : 12,
                        letterSpacing: 0.2,
                      ),
                      child: Text(item.label),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _NavBarItemData {
  final IconData icon;
  final String label;
  const _NavBarItemData({required this.icon, required this.label});
}
