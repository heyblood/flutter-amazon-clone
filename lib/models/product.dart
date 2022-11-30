// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
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
}
