import 'package:entity_delivery_v2/models/user_model.dart';
import 'package:entity_delivery_v2/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;

  UserModel get user => _user!;

  set user(UserModel value) {
    _user = value;
    notifyListeners();
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      print('provider');
      UserModel user = await AuthService().login(email: email, password: password);
      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> logout({required String token}) async {
    try {
      await AuthService().logout(token: token);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register({required String fName, required String lName, required String phone, required String addressName, required String province, required String city, required String district, required String postal, required String address,required String email, required String password}) async {
    try {
      await AuthService().register(fName: fName, lName: lName, phone: phone, addressName: addressName, province: province, city: city, district: district, postal: postal, address: address, email: email, password: password);
      print('provider success');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}