class SubItem {
  final int? id;
  final String name;
  final double price;

  SubItem({this.id, required this.name, required this.price});

  factory SubItem.fromJson(Map<String, dynamic> json) {
    return SubItem(
      id: json['id'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {if (id != null) 'id': id, 'name': name, 'price': price};
  }
}

class MenuItem {
  final int? id;
  final String title;
  final String imageUrl;
  final List<SubItem> subItems;

  MenuItem({
    this.id,
    required this.title,
    required this.imageUrl,
    this.subItems = const [],
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      id: json['id'],
      title: json['title'],
      imageUrl: json['imageUrl'],
      subItems:
          (json['subItems'] as List<dynamic>)
              .map((e) => SubItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'imageUrl': imageUrl,
      'subItems': subItems.map((e) => e.toJson()).toList(),
    };
  }
}
