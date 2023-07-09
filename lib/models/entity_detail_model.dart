class EntityDetailModel {
  String note = '';
  String hdImageUrl = '';

  EntityDetailModel({required this.note, required this.hdImageUrl});

  EntityDetailModel.fromJson(Map<String, dynamic> json) {
    note = json['note'];
    hdImageUrl = json['hd_image_url'];
  }

  Map<String, dynamic> toJson() {
    return {
      'note': note,
      'hd_image_url': hdImageUrl,
    };
  }
}