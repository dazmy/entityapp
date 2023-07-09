import 'package:entity_delivery_v2/models/entity_detail_model.dart';

class EntityModel {
  String id = '';
  String name = '';
  int price = 0;
  String imageUrl = '';
  int rating = 0;
  EntityDetailModel? detail;

  EntityModel({required this.id, required this.name, required this.price, required this.imageUrl, required this.rating});

  EntityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['image_url'];
    rating = json['rating'];
    detail = EntityDetailModel.fromJson(json['entity_detail']);
  }

  EntityModel.fromJsonCart(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['image_url'];
  }

  EntityModel.fromJsonTransaction(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    imageUrl = json['image_url'];
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
      'rating': rating,
    };
  }

  Map<String, dynamic> toJsonCart() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image_url': imageUrl,
    };
  }

  Map<String, dynamic> toJsonTransaction() {
    return {
      'id': id,
      'name': name,
      'price': price,
    };
  }
}

