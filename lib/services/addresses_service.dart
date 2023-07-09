import 'dart:convert';

import 'package:entity_delivery_v2/models/addresses_model.dart';
import 'package:http/http.dart' as http;

class AddressesService {
  String baseUrl = 'https://dev.ngecode.my.id';

  Future<List<AddressesModel>> getAddresses(String token) async {
    var url = Uri.parse('$baseUrl/api/v1/addresses');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token
    };

    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200) {
      List<AddressesModel> addresses = [];
      var data = jsonDecode(response.body)['data'];
      for(var item in data) {
        addresses.add(AddressesModel.fromJson(item));
      }
      return addresses;
    } else {
      throw Exception('Error Fetching Address');
    }
  }

  Future<bool> createAddress({required String addressName, required String receiverName, required String phone, required String province, required String city, required String district, required String postal, required String address, required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/addresses');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };
    var body = {
      'receiver_name': receiverName,
      'addr_name': addressName,
      'address': address,
      'address_full': address,
      'postal_code': postal,
      'phone': phone,
      'is_choosen_address': '1',
      'district_id': '1',
      'city_id': '1',
      'province_id': '1',
      'address_note': '$addressName, $receiverName',
    };

    var response = await http.post(url, headers: headers, body: body);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      print('success service');
      return true;
    } else {
      throw Exception('Fail Create Address');
    }
  }

  Future<bool> deleteAddress(int id, String token) async {
    var url = Uri.parse('$baseUrl/api/v1/addresses/$id');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };

    var response = await http.delete(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      print('delete success service');
      return true;
    } else {
      throw Exception('Gagal Delete');
    }
  }

  Future<bool> selectAddress(int id, String token) async {
    var url = Uri.parse('$baseUrl/api/v1/addresses/$id/select');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token,
    };

    print(id);
    var response = await http.patch(url, headers: headers);
    print(response.statusCode);
    print(response.body);

    if(response.statusCode == 200) {
      print('select success service');
      return true;
    } else {
      throw Exception('Gagal select');
    }
  }
}