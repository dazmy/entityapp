import 'package:entity_delivery_v2/models/addresses_model.dart';
import 'package:entity_delivery_v2/services/addresses_service.dart';
import 'package:flutter/material.dart';

class AddressesProvider with ChangeNotifier {
  List<AddressesModel>? _addresses;

  List<AddressesModel> get addresses => _addresses!;

  set addresses(List<AddressesModel> value) {
    _addresses = value;
    notifyListeners();
  }

  Future<bool> getAddresses(String token) async {
    try {
      List<AddressesModel> addresses = await AddressesService().getAddresses(token);
      _addresses = addresses;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> createAddress({required String addressName, required String receiverName, required String phone, required String province, required String city, required String district, required String postal, required String address, required String token}) async {
    try {
      await AddressesService().createAddress(addressName: addressName, receiverName: receiverName, phone: phone, province: province, city: city, district: district, postal: postal, address: address, token: token);
      print('success provider');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAddress({required int id, required String token}) async {
    try {
      await AddressesService().deleteAddress(id, token);
      print('delete success provider');
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> selectAddress(int id, String token) async {
    try {
      await AddressesService().selectAddress(id, token);
      print('select success provider');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}