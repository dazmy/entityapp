import 'dart:convert';
import 'package:entity_delivery_v2/models/entity_definition_model.dart';
import 'package:entity_delivery_v2/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthService {
  String baseUrl = 'https://dev.ngecode.my.id';

  Future<UserModel> login({required String email, required String password}) async {
    var urlLogin = Uri.parse('$baseUrl/api/v1/sessions/bearer/new');
    var urlInfo = Uri.parse('$baseUrl/api/v1/info');
    var headers = {
      'Accept': 'application/json',
    };
    var body = {
      'email': email,
      'password': password,
      "user_agent": '666', // randomkan
    };

    var responseLogin = await http.post(urlLogin, headers: headers, body: body);
    print(responseLogin.statusCode);

    if (responseLogin.statusCode == 200) {
      var type = jsonDecode(responseLogin.body)['data']['type'];
      var code = jsonDecode(responseLogin.body)['data']['token'];
      var token = '$type $code';
      var responseInfo = await http.get(urlInfo, headers: {
        'Accept': 'application/json',
        'Authorization': token,
      });
      var userBody = jsonDecode(responseInfo.body)['data']['user'];
      var userEntity = jsonDecode(responseInfo.body)['data']['entity_definition'];
      var user = UserModel.fromJson(userBody);
      user.token = token;
      user.entity = EntityDefinitionModel.fromJson(userEntity);
      print('tes');
      return user;
    } else {
      throw Exception('Error Login');
    }

  }

  Future<bool> logout({required String token}) async {
    var url = Uri.parse('$baseUrl/api/v1/sessions/bearer');
    var headers = {
      'Accept': 'application/json',
      'Authorization': token
    };

    var response = await http.delete(url, headers: headers);
    print(response.statusCode);

    if(response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Gagal Logout');
      return false;
    }
  }

  Future<bool> register({required String fName, required String lName, required String phone, required String addressName, required String province, required String city, required String district, required String postal, required String address,required String email, required String password}) async {
    var url = Uri.parse('$baseUrl/api/v1/users');
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    var bodyAddress = {
      "addr_name": addressName,
      "address": address,
      "address_full": '$address $district $city',
      "postal_code": postal,
      "phone": phone,
      "district_id": "1",
      "city_id": "1",
      "province_id": "1",
      "address_note": '$district $city $province'
    };

    var body = jsonEncode({
      "name": '$fName $lName',
      "email": email,
      "password": password,
      "first_name": fName,
      "last_name": lName,
      "phone": phone,
      "address": bodyAddress,
    });

    var response = await http.post(url, headers: headers, body: body);

    print(response.body);

    if(response.statusCode == 200) {
      print('service success');
      return true;
    } else {
      throw Exception('Failed REGISTER');
    }
  }
}