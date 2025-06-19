import 'package:flutter/material.dart';
import 'package:foodie/models/menu_item.dart';
import 'package:foodie/providers/cart_provider.dart';
import 'package:foodie/providers/menu_provider.dart';
import 'package:foodie/shared/fancytoast.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = context.watch<MenuProvider>().items;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MENU',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2 / 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];
            return GestureDetector(
              onTap:
                  () => showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(24),
                      ),
                    ),
                    isScrollControlled: true,
                    builder: (_) => _CategoryDetailSheet(context, item),
                  ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(item.imageUrl, fit: BoxFit.cover),
                    Container(color: Colors.teal.shade600.withOpacity(0.4)),
                    Center(
                      child: Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w900,
                          shadows: [
                            const Shadow(
                              color: Colors.black26,
                              offset: Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _CategoryDetailSheet(BuildContext context, MenuItem menuItem) {
    final Map<SubItem, int> quantities = {
      for (var sub in menuItem.subItems) sub: 0,
    };

    return StatefulBuilder(
      builder: (context, setState) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.4,
          maxChildSize: 0.95,
          expand: false,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: ListView(
                controller: controller,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    menuItem.title,
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal.shade700,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...menuItem.subItems.map(
                    (subItem) => Column(
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.fastfood_rounded,
                              color: Colors.teal,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${subItem.name} (PKR ${subItem.price.toStringAsFixed(2)})',
                                style: GoogleFonts.montserrat(fontSize: 16),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      if (quantities[subItem]! > 0) {
                                        quantities[subItem] =
                                            quantities[subItem]! - 1;
                                      }
                                    });
                                  },
                                ),
                                Text(
                                  '${quantities[subItem]}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      quantities[subItem] =
                                          quantities[subItem]! + 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade600,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            icon: const Icon(
                              Icons.shopping_cart_checkout_rounded,
                              color: Colors.white,
                            ),
                            label: Text(
                              'ADD TO CART',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            onPressed: () {
                              if (quantities[subItem]! > 0) {
                                final cart = context.read<CartProvider>();
                                cart.addItem(
                                  subItem.name,
                                  quantities[subItem]!,
                                  subItem.price,
                                );
                                showFancyToast(
                                  context,
                                  '${subItem.name} x${quantities[subItem]} added to cart (PKR ${(quantities[subItem]! * subItem.price).toStringAsFixed(2)})',
                                );
                              }
                            },
                          ),
                        ),
                        const Divider(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
