import 'package:entity_delivery_v2/models/entity_model.dart';

class CartListModel {
  int id = 0;
  int quantity = 0;
  DateTime? createdAt;
  int lastPrice = 0;
  EntityModel entityModel = EntityModel(id: '', name: '', price: 0, imageUrl: '', rating: 0);

  CartListModel(
      {required this.id,
      required this.quantity,
      required this.createdAt,
      required this.entityModel,
      required this.lastPrice});

  CartListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['qty'];
    createdAt = DateTime.parse(json['created_at']);
    entityModel = EntityModel.fromJsonCart(json['entity']);
    lastPrice = json['last_price'];
  }

  CartListModel.fromJsonDetail(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['qty'];
    createdAt = DateTime.parse(json['created_at']);
    lastPrice = json['last_price'];
  }

  CartListModel.fromJsonTransaction(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['qty'];
    createdAt = DateTime.parse(json['created_at']);
    entityModel = EntityModel.fromJsonTransaction(json['entity']);
    lastPrice = json['last_price'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'qty': quantity,
      'created_at': createdAt.toString(),
      'entity': entityModel!.toJsonCart(),
      'last_price': lastPrice,
    };
  }

  Map<String, dynamic> toJsonTransaction() {
    return {
      'id': id,
      'qty': quantity,
      'created_at': createdAt.toString(),
      'entity': entityModel!.toJsonTransaction(),
    };
  }
}
