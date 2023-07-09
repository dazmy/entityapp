import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({Key? key}) : super(key: key);

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

final List<String> province = ['1'];

class _ManageAddressPageState extends State<ManageAddressPage> {
  String dropdownValue = province.first;

  TextEditingController addressName = TextEditingController(text: '');
  TextEditingController receiverName = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  // province
  TextEditingController provinceApi = TextEditingController(text: '1');
  // city
  TextEditingController city = TextEditingController(text: '1');
  // district
  TextEditingController district = TextEditingController(text: '1');
  // postal
  TextEditingController postal = TextEditingController(text: '59996');
  TextEditingController address = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    AddressesProvider addressesProvider = Provider.of<AddressesProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleCreateAddress() async {
      if(await addressesProvider.createAddress(addressName: addressName.text, receiverName: receiverName.text, phone: phone.text, province: provinceApi.text, city: city.text, district: district.text, postal: postal.text, address: address.text, token: authProvider.user.token)) {
        if(await addressesProvider.getAddresses(authProvider.user.token)) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/address');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              'Gagal Tambah Address',
              textAlign: TextAlign.center,
            )));
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: whiteTextColor,
        iconTheme: IconThemeData(
          color: blackTextColor
        ),
        title: Text('Manage', style: blackTextStyle.copyWith(fontWeight: bold),),
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset('assets/icon_info.png', width: 24,))
        ],
      );
    }

    Widget nameAddressInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name Address', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_home.png'),
                const SizedBox(width: 12,),
                Expanded(
                  child: TextFormField(
                    controller: addressName,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Kontrakan Ku No. 2',
                      hintStyle: authFieldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget receiverInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Receiver Name', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_profile.png'),
                const SizedBox(width: 12,),
                Expanded(
                  child: TextFormField(
                    controller: receiverName,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Input here',
                      hintStyle: authFieldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget phoneInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Number Phone', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_phone.png'),
                const SizedBox(width: 12,),
                Expanded(
                  child: TextFormField(
                    controller: phone,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Input here',
                      hintStyle: authFieldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget provinceInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Province*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: province.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget cityInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('City*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: province.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget districtInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('District*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: province.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget postalInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Postal*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: province.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget addressInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Name Address', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 110,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: address,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    maxLines: 5,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Jl. Monumen Perjuangan No.50, Glondong, Wirokerten, Kec. Banguntapan, Kabupaten Bantul, Daerah Istimewa Yogyakarta 55194',
                      hintStyle: authFieldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget addressForm() {
      return Container(
        padding: EdgeInsets.all(defaultMargin),
        decoration: BoxDecoration(
          color: whiteTextColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: blackBackgroundColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            nameAddressInput(),
            receiverInput(),
            phoneInput(),
            Row(children: [
                Flexible(flex: 1, child: provinceInput()),
                const SizedBox(width: 3,),
                Flexible(flex: 1, child: cityInput()),
            ],),
            Row(children: [
                Flexible(flex: 1, child: districtInput()),
                const SizedBox(width: 3,),
                Flexible(flex: 1, child: postalInput()),
            ],),
            addressInput(),
          ],
        ),
      );
    }

    Widget saveButton() {
      return Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
          onPressed: handleCreateAddress,
          style: TextButton.styleFrom(
            backgroundColor: yellowBackgroundButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )
          ),
          child: Text('Save Address', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          addressForm(),
          SizedBox(height: defaultBorder,),
          saveButton(),
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
