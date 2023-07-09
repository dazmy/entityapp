class EntityDefinitionModel {
  String name = '';

  EntityDefinitionModel({required this.name});

  EntityDefinitionModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
