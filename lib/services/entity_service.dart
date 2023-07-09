import 'dart:convert';

import 'package:entity_delivery_v2/models/entity_model.dart';
import 'package:entity_delivery_v2/models/user_model.dart';
import 'package:http/http.dart' as http;

class EntityService {
  String baseUrl = 'https://dev.ngecode.my.id';

  Future<List<EntityModel>> getEntity(String token) async {
    var url = Uri.parse('$baseUrl/api/v1/entities-optional');
    var headers = {
      'Authorization': token,
    };

    var response = await http.get(url, headers: headers);

    if(response.statusCode == 200) {
      List data = jsonDecode(response.body)['data'];
      List<EntityModel> entity = [];

      for(var item in data) {
        entity.add(EntityModel.fromJson(item));
      }
      print('ready');
      return entity;
    } else {
      throw Exception('Error fetching data');
    }
  }

  Future<EntityModel> getEntityDetail(String token, String id) async {
    var url = Uri.parse('$baseUrl/api/v1/entities/$id');
    var headers = {
      'Authorization': token,
    };
    print(url);
    var response = await http.get(url, headers: headers);
    print(response.body);

    if(response.statusCode == 200) {
      EntityModel entity = EntityModel.fromJson(jsonDecode(response.body)['data']);
      return entity;
    } else {
      throw Exception('Error Fetching Detail');
    }
  }
}