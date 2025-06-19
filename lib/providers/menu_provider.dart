import 'package:flutter/material.dart';
import '../models/menu_item.dart';

class MenuProvider extends ChangeNotifier {
  final List<MenuItem> _items = [
    MenuItem(
      title: 'BURGER',
      imageUrl:
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?q=80&w=999&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      subItems: [
        SubItem(name: 'Beef Burger', price: 499),
        SubItem(name: 'Chicken Burger', price: 399),
        SubItem(name: 'Zinger Burger', price: 549),
        SubItem(name: 'Cheese Burger', price: 429),
        SubItem(name: 'Smash Burger', price: 625),
      ],
    ),
    MenuItem(
      title: 'PIZZA',
      imageUrl:
          'https://images.unsplash.com/photo-1513104890138-7c749659a591?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      subItems: [
        SubItem(name: 'Margherita', price: 699),
        SubItem(name: 'Pepperoni', price: 749),
        SubItem(name: 'BBQ Chicken', price: 825),
        SubItem(name: 'Fajita', price: 775),
        SubItem(name: 'Cheese Burst', price: 950),
      ],
    ),
    MenuItem(
      title: 'SALAD',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      subItems: [
        SubItem(name: 'Greek Salad', price: 350),
        SubItem(name: 'Caesar Salad', price: 400),
        SubItem(name: 'Garden Fresh', price: 325),
        SubItem(name: 'Protein Bowl', price: 500),
      ],
    ),
    MenuItem(
      title: 'DRINKS',
      imageUrl:
          'https://images.unsplash.com/photo-1668165903615-bc26154cc98e?q=80&w=764&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      subItems: [
        SubItem(name: 'Coke', price: 150),
        SubItem(name: 'Pepsi', price: 150),
        SubItem(name: 'Mint Margarita', price: 200),
        SubItem(name: 'Cold Coffee', price: 250),
        SubItem(name: 'Fresh Juice', price: 275),
      ],
    ),
  ];

  List<MenuItem> get items => _items;

  // Add a new MenuItem
  void addItem(MenuItem item) {
    _items.add(item);
    notifyListeners();

    // ApiService.saveMenuItem(item);
  }

  // Delete a MenuItem
  void deleteItem(MenuItem item) {
    _items.remove(item);
    notifyListeners();

    // ApiService.deleteMenuItem(item.id);
  }

  // Update a MenuItem
  void updateItem(MenuItem oldItem, MenuItem updatedItem) {
    final index = _items.indexOf(oldItem);
    if (index != -1) {
      _items[index] = updatedItem;
      notifyListeners();

      // ApiService.updateMenuItem(updatedItem);
    }
  }

  // Add subitem to a specific menu item
  void addSubItem(MenuItem parent, SubItem subItem) {
    parent.subItems.add(subItem);
    notifyListeners();

    // ApiService.addSubItem(parent.id, subItem);
  }

  // Delete subitem
  void deleteSubItem(MenuItem parent, SubItem subItem) {
    parent.subItems.remove(subItem);
    notifyListeners();

    // ApiService.deleteSubItem(parent.id, subItem.id);
  }

  // Update subitem
  void updateSubItem(MenuItem parent, SubItem oldSubItem, SubItem newSubItem) {
    final index = parent.subItems.indexOf(oldSubItem);
    if (index != -1) {
      parent.subItems[index] = newSubItem;
      notifyListeners();

      // ApiService.updateSubItem(parent.id, newSubItem);
    }
  }
}
