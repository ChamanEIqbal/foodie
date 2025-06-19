class SubItem {
  final String name;
  final double price;

  SubItem({required this.name, required this.price});

  factory SubItem.fromJson(Map<String, dynamic> json) {
    return SubItem(
      name: json['name'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price};
  }
}

class MenuItem {
  final String title;
  final String imageUrl;
  final List<SubItem> subItems;

  MenuItem({
    required this.title,
    required this.imageUrl,
    this.subItems = const [],
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
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
      'title': title,
      'imageUrl': imageUrl,
      'subItems': subItems.map((e) => e.toJson()).toList(),
    };
  }
}
