class AddressesModel {
  int id = 0;
  String addrName = '';
  String addressFull = '';
  String postalCode = '';
  String receiverName = '';
  String phone = '';
  // int country = 0;
  int districtId = 0;
  int cityId = 0;
  int provinceId = 0;
  int chosenAddress = 0;

  AddressesModel(
      {required this.id,
      required this.addrName,
      required this.addressFull,
      required this.postalCode,
      required this.receiverName,
      required this.phone,
      // required this.country,
      required this.districtId,
      required this.cityId,
      required this.provinceId,
      required this.chosenAddress});

  AddressesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    addrName = json['addr_name'];
    addressFull = json['address_full'];
    postalCode = json['postal_code'];
    receiverName = json['receiver_name'];
    phone = json['phone'];
    cityId = json['city_id'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    chosenAddress = json['is_choosen_address'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'addr_name': addrName,
      'address_full': addressFull,
      'postal_code': postalCode,
      'receiver_name': receiverName,
      'phone': phone,
      'city_id': cityId,
      'province_id': provinceId,
      'district_id': districtId,
      'is_choosen_address': chosenAddress,
    };
  }
}
