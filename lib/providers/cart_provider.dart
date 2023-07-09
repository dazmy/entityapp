import 'package:entity_delivery_v2/models/cart_list_model.dart';
import 'package:entity_delivery_v2/models/cart_model.dart';
import 'package:entity_delivery_v2/services/cart_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  CartModel? _cartModel;
  CartListModel? _cartListModel;

  CartModel get cartModel => _cartModel!;

  set cartModel(CartModel value) {
    _cartModel = value;
    notifyListeners();
  }


  CartListModel get cartListModel => _cartListModel!;

  set cartListModel(CartListModel value) {
    _cartListModel = value;
    notifyListeners();
  }

  Future<bool> getItemList(String token) async {
    try {
      CartModel cartModel = await CartService().getItemList(token);
      _cartModel = cartModel;
      print('success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addToCart({required String id, required String name, required String token}) async {
    try {
      await CartService().addToCart(id: id, name: name, token: token);
      print('berhasil provider');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addQuantity({required int id, required int qty, required String token}) async {
    try {
      await CartService().addQuantity(id: id, qty: qty, token: token);
      print('provider add success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> reduceQuantity({required int id, required int qty, required String token}) async {
    try {
      await CartService().reduceQuantity(id: id, qty: qty, token: token);
      print('provider reduce success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> checkout({required String token}) async {
    try {
      await CartService().checkout(token: token);
      print('success provider');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}