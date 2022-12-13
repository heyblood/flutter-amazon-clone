// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String name;
  final String description;
  final int price;
  final int quantity;
  final String category;
  final List<String> images;
  final String? id;
  final String? userId;
  const Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'quantity': quantity,
      'category': category,
      'images': images,
      '_id': id,
      'userId': userId,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      quantity: map['quantity'] as int,
      category: map['category'] as String,
      images: List<String>.from((map['images'].cast<String>() as List<String>)),
      id: map['_id'] != null ? map['_id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
