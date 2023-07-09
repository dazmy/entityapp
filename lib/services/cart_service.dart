import 'dart:convert';

import 'package:entity_delivery_v2/models/cart_list_model.dart';
import 'package:entity_delivery_v2/models/cart_model.dart';
import 'package:http/http.dart' as http;

class CartService {
  String baseUrl = 'https://dev.ngecode.my.id';

  Future<CartModel> getItemList(String token) async {
    var url = Uri.parse('$baseUrl/api/v1/carts');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    var response = await http.get(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      var cart = jsonDecode(response.body)['data']['cart'];
      CartModel cartModel = CartModel.fromJson(cart);
      print('success fetch cart');
      return cartModel;
    } else {
      throw Exception('Gagal Fetch Cart');
    }
  }

  Future<bool> addToCart({required String id, required String name, required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/carts');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = {
      'data': {
        'id': id,
        'name': name
      },
    };

    print(body);
    var response = await http.post(url, headers: headers, body: jsonEncode(body));
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      print('berhasil gaes service');
      return true;
    } else {
      throw Exception('Gagal add to cart');
    }
  }

  Future<bool> addQuantity({required int id, required int qty, required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/carts');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var body = {
      'data': {
        'id': id,
        'qty': qty,
      },
      'action': 'updateQuantity',
    };

    var response = await http.put(url, headers: headers, body: jsonEncode(body));
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      // var data = jsonDecode(response.body)['data'];
      // CartListModel cartListModel = CartListModel.fromJson(data);
      print('service add success');
      return true;
    } else {
      throw Exception('Error Add QTY');
    }
  }

  Future<bool> reduceQuantity({required int id, required int qty, required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/carts');
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': token
    };
    var body = {
      'data': {
        'id': id,
        'qty': qty,
      },
      'action': 'updateQuantity',
    };

    var response = await http.put(url, headers: headers, body: jsonEncode(body));
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      // var data = jsonDecode(response.body)['data'];
      // CartListModel cartListModel = CartListModel.fromJson(data);
      print('service reduce success');
      return true;
    } else {
      throw Exception('Error reduce QTY');
    }
  }

  Future<bool> checkout({required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/checkout');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.post(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      print('success checkout');
      return true;
    } else {
      throw Exception('Checkout failed');
    }
  }
}