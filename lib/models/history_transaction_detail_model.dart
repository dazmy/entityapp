import 'package:entity_delivery_v2/models/cart_model.dart';

class HistoryTransactionDetailModel {
  CartModel cartModel = CartModel(updatedAt: DateTime.parse('2023-07-07T10:08:06.000000Z'), itemList: []);

  HistoryTransactionDetailModel({required this.cartModel});

  HistoryTransactionDetailModel.fromJson(Map<String, dynamic> json) {
    cartModel = CartModel.fromJsonTransaction(json['cart']);
  }

  Map<String, dynamic> toJson() {
    return {
      'cart': cartModel.toJsonTransaction(),
    };
  }
}