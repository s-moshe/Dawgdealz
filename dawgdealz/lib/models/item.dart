import 'package:intl/intl.dart';

class Item {
  final String name;
  final String description;
  final String price;
  final String category;
  final String condition;
  final List<String> images;
  final String listedDate;

  Item({
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.condition,
    required this.images,
    required this.listedDate
  });

  factory Item.fromMap(Map<String, dynamic> data) {
    return Item(
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: data['price'] ?? '',
      category: data['category'] ?? '',
      condition: data['condition'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      listedDate: DateFormat('MM/dd/yyyy').format(DateTime.parse(data['timestamp'])),
    );
  }
}
