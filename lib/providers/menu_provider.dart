// providers/menu_provider.dart
import 'package:flutter/material.dart';
import '../models/menu_item.dart';
import '../services/api.dart';

class MenuProvider extends ChangeNotifier {
  final List<MenuItem> _items = [];

  List<MenuItem> get items => _items;

  Future<void> fetchItemsFromApi() async {
    try {
      final fetchedItems = await ApiService.getMenuItems();
      _items.clear();
      _items.addAll(fetchedItems);
      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching menu: \$e');
    }
  }

  void addItem(MenuItem item) {
    _items.add(item);
    notifyListeners();
    ApiService.addMenuItem(item);
  }

  void deleteItem(MenuItem item) {
    if (item.id == null) return;
    _items.remove(item);
    notifyListeners();
    ApiService.deleteMenuItem(item.id!);
  }

  void updateItem(MenuItem oldItem, MenuItem updatedItem) {
    final index = _items.indexOf(oldItem);
    if (index != -1) {
      _items[index] = updatedItem;
      notifyListeners();
      ApiService.updateMenuItem(updatedItem);
    }
  }

  void addSubItem(MenuItem parent, SubItem subItem) {
    if (parent.id == null) return;
    parent.subItems.add(subItem);
    notifyListeners();
    ApiService.addSubItem(parent.id!, subItem);
  }

  void deleteSubItem(MenuItem parent, SubItem subItem) {
    if (parent.id == null || subItem.id == null) return;
    parent.subItems.remove(subItem);
    notifyListeners();
    ApiService.deleteSubItem(parent.id!, subItem.id!);
  }

  void updateSubItem(MenuItem parent, SubItem oldSubItem, SubItem newSubItem) {
    if (parent.id == null || oldSubItem.id == null) return;
    final index = parent.subItems.indexOf(oldSubItem);
    if (index != -1) {
      parent.subItems[index] = newSubItem;
      notifyListeners();
      ApiService.updateSubItem(parent.id!, oldSubItem.id!, newSubItem);
    }
  }
}
