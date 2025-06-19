import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodie/models/menu_item.dart';
import 'package:foodie/providers/menu_provider.dart';
import 'package:foodie/shared/fancytoast.dart';

class ManageMenuPage extends StatefulWidget {
  const ManageMenuPage({super.key});

  @override
  State<ManageMenuPage> createState() => _ManageMenuPageState();
}

class _ManageMenuPageState extends State<ManageMenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  void _showSubItemDialog(MenuItem menuItem, [SubItem? existing]) {
    if (existing != null) {
      _nameController.text = existing.name;
      _priceController.text = existing.price.toString();
    } else {
      _nameController.clear();
      _priceController.clear();
    }

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              existing != null ? 'Edit SubItem' : 'Add SubItem',
              style: GoogleFonts.montserrat(),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price (PKR)'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade600,
                ),
                onPressed: () {
                  final name = _nameController.text.trim();
                  final price = double.tryParse(_priceController.text.trim());

                  if (name.isEmpty || price == null) return;

                  final updated = SubItem(name: name, price: price);
                  final menuProvider = context.read<MenuProvider>();

                  if (existing != null) {
                    menuProvider.updateSubItem(menuItem, existing, updated);
                    showFancyToast(context, 'SubItem "$name" updated');
                  } else {
                    menuProvider.addSubItem(menuItem, updated);
                    showFancyToast(context, 'SubItem "$name" added');
                  }

                  Navigator.pop(context);
                },
                child: Text(
                  existing != null ? 'Update' : 'Add',
                  style: GoogleFonts.montserrat(color: Colors.white),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final menuItems = context.watch<MenuProvider>().items;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade600,
        title: Text(
          'MANAGE',
          style: GoogleFonts.montserrat(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: menuItems.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final menuItem = menuItems[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            margin: const EdgeInsets.only(bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(menuItem.imageUrl),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.teal.shade900.withOpacity(0.6),
                    BlendMode.darken,
                  ),
                ),
              ),
              child: ExpansionTile(
                backgroundColor: Colors.transparent,
                collapsedBackgroundColor: Colors.transparent,
                title: Text(
                  menuItem.title,
                  style: GoogleFonts.montserrat(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                children: [
                  ...menuItem.subItems.map(
                    (sub) => ListTile(
                      leading: const Icon(Icons.fastfood, color: Colors.white),
                      title: Text(
                        sub.name,
                        style: GoogleFonts.montserrat(color: Colors.white),
                      ),
                      subtitle: Text(
                        'PKR ${sub.price}',
                        style: GoogleFonts.montserrat(
                          fontSize: 13,
                          color: Colors.white70,
                        ),
                      ),
                      trailing: Wrap(
                        spacing: 8,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () => _showSubItemDialog(menuItem, sub),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              context.read<MenuProvider>().deleteSubItem(
                                menuItem,
                                sub,
                              );
                              showFancyToast(
                                context,
                                'SubItem "${sub.name}" deleted',
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal.shade600,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _showSubItemDialog(menuItem),
                        icon: const Icon(Icons.add, color: Colors.white),
                        label: Text(
                          'Add SubItem',
                          style: GoogleFonts.montserrat(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
