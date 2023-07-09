import 'package:entity_delivery_v2/models/entity_definition_model.dart';

class UserModel {
  String id = '';
  String name = '';
  String email = '';
  String token = '';
  EntityDefinitionModel? entity;

  UserModel({required this.id, required this.name, required this.email, required this.token,});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    token = '';
    // entity = EntityModel.fromJson(json['entity_definition']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'token': token,
    };
  }
}