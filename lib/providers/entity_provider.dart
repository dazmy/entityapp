import 'package:entity_delivery_v2/models/entity_model.dart';
import 'package:entity_delivery_v2/services/entity_service.dart';
import 'package:flutter/material.dart';

class EntityProvider with ChangeNotifier {
  List<EntityModel> _entity = [];
  EntityModel? _entityModel;

  List<EntityModel> get entity => _entity;

  set entity(List<EntityModel> value) {
    _entity = value;
    notifyListeners();
  }


  EntityModel get entityModel => _entityModel!;

  set entityModel(EntityModel value) {
    _entityModel = value;
    notifyListeners();
  }

  Future<bool> getEntity(String token) async {
    try {
      List<EntityModel> entity = await EntityService().getEntity(token);
      _entity = entity;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // Future<void> getEntityDetail(String token, String id) async {
  //   try {
  //     print('e');
  //     EntityModel entityModel = await EntityService().getEntityDetail(token, id);
  //     _entityModel = entityModel;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}