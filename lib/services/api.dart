import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:foodie/models/menu_item.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:5000/api/menu';

  static Future<List<MenuItem>> getMenuItems() async {
    final res = await http.get(Uri.parse(baseUrl));

    if (res.statusCode == 200) {
      final List<dynamic> data = jsonDecode(res.body);
      return data.map((json) => MenuItem.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load menu items');
    }
  }

  static Future<void> addMenuItem(MenuItem item) async {
    final res = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to add menu item');
    }
  }

  static Future<void> updateMenuItem(MenuItem item) async {
    if (item.id == null) throw Exception('MenuItem ID is required');

    final res = await http.put(
      Uri.parse('$baseUrl/${item.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update menu item');
    }
  }

  static Future<void> deleteMenuItem(int id) async {
    final res = await http.delete(Uri.parse('$baseUrl/$id'));

    if (res.statusCode != 200) {
      throw Exception('Failed to delete menu item');
    }
  }

  static Future<void> addSubItem(int menuItemId, SubItem subItem) async {
    final res = await http.post(
      Uri.parse('$baseUrl/$menuItemId/subitem'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subItem.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to add sub item');
    }
  }

  static Future<void> updateSubItem(
    int menuItemId,
    int subItemId,
    SubItem subItem,
  ) async {
    final res = await http.put(
      Uri.parse('$baseUrl/$menuItemId/subitem/$subItemId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(subItem.toJson()),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to update sub item');
    }
  }

  static Future<void> deleteSubItem(int menuItemId, int subItemId) async {
    final res = await http.delete(
      Uri.parse('$baseUrl/$menuItemId/subitem/$subItemId'),
    );

    if (res.statusCode != 200) {
      throw Exception('Failed to delete sub item');
    }
  }
}
