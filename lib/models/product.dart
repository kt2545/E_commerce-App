import 'dart:convert';
import 'package:e_commerce_app/models/rating.dart';

class Product {
  final String name;
  final String description;
  final int quantity;
  final List<String> images;
  final String category;
  final double price;
  final String? id;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
    required this.category,
    required this.price,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating?.map((x) => x.toMap()).toList(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      quantity: map['quantity'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      category: map['category'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      id: map['_id'],
      rating: map['rating'] != null
          ? List<Rating>.from(
              map['rating']?.map(
                (x) => Rating.fromMap(x),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
