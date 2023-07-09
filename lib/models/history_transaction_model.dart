import 'package:entity_delivery_v2/models/addresses_model.dart';
import 'package:entity_delivery_v2/models/cart_model.dart';

class HistoryTransactionModel {
  String id = '';
  String orderStatus = '';
  String orderStatusMessage = '';
  int totalPrice = 0;
  AddressesModel addressesModel = AddressesModel(
      id: 0,
      addrName: '',
      addressFull: '',
      postalCode: '',
      receiverName: '',
      phone: '',
      districtId: 0,
      cityId: 0,
      provinceId: 0,
      chosenAddress: 0);
  DateTime createdAt = DateTime.parse('2023-07-07T10:57:11.000000Z');
  CartModel cartModel = CartModel(updatedAt: DateTime.parse('2001-01-01T23:42:18.000000Z'), itemList: []);

  HistoryTransactionModel(
      {required this.id,
      required this.orderStatus,
      required this.orderStatusMessage,
      required this.totalPrice,
      required this.addressesModel,
      required this.createdAt,
      required this.cartModel});

  HistoryTransactionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderStatus = json['order_status'];
    orderStatusMessage = json['order_status_message'];
    totalPrice = json['total_price'];
    createdAt = DateTime.parse(json['created_at']);
    addressesModel = AddressesModel.fromJson(json['address']);
    cartModel = CartModel.fromJsonTransaction(json['cart']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order_status': orderStatus,
      'order_status_message': orderStatusMessage,
      'total_price': totalPrice,
      'created_at': createdAt.toString(),
      'address': addressesModel.toJson(),
    };
  }
}
