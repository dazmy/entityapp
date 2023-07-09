import 'package:entity_delivery_v2/models/cart_list_model.dart';

class CartModel {
  DateTime? updatedAt;
  List<CartListModel> itemList = [];

  CartModel({required this.updatedAt, required this.itemList});

  CartModel.fromJson(Map<String, dynamic> json) {
    updatedAt = DateTime.parse(json['updated_at']);
    itemList = json['item_list'].map<CartListModel>((e) => CartListModel.fromJson(e)).toList();
  }

  CartModel.fromJsonTransaction(Map<String, dynamic> json) {
    updatedAt = DateTime.parse(json['updated_at']);
    itemList = json['item_list'].map<CartListModel>((e) => CartListModel.fromJsonTransaction(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'updated_at': updatedAt.toString(),
      'item_list': itemList.map((e) => e.toJson()).toList(),
    };
  }

  Map<String, dynamic> toJsonTransaction() {
    return {
      'updated_at': updatedAt.toString(),
      'item_list': itemList.map((e) => e.toJsonTransaction()).toList(),
    };
  }
}