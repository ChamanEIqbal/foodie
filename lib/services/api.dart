import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodie/models/menu_item.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api';

  static Future<List<MenuItem>> getMenuItems() async {
    final res = await http.get(Uri.parse('$baseUrl/menu'));

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => MenuItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  static Future<void> addMenuItem(MenuItem item) async {
    final res = await http.post(
      Uri.parse('$baseUrl/menu'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to add menu item');
    }
  }

  static Future<void> updateMenuItem(MenuItem item) async {
    final res = await http.put(
      Uri.parse('$baseUrl/menu/${item.title}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update menu item');
    }
  }

  static Future<void> deleteMenuItem(String itemTitle) async {
    final res = await http.delete(Uri.parse('$baseUrl/menu/$itemTitle'));

    if (res.statusCode != 200) {
      throw Exception('Failed to delete menu item');
    }
  }

  static Future<void> addSubItem(String menuItemId, SubItem subItem) async {
    final res = await http.post(
      Uri.parse('$baseUrl/menu/$menuItemId/subitem'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subItem.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to add sub item');
    }
  }

  static Future<void> updateSubItem(
    String menuItemId,
    String subItemId,
    SubItem subItem,
  ) async {
    final res = await http.put(
      Uri.parse('$baseUrl/menu/$menuItemId/subitem/$subItemId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subItem.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update sub item');
    }
  }

  static Future<void> deleteSubItem(String menuItemId, String subItemId) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/menu/$menuItemId/subitem/$subItemId'),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to delete sub item');
    }
  }
}
