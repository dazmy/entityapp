import 'package:entity_delivery_v2/models/addresses_model.dart';
import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class AddressPage extends StatefulWidget {
  const AddressPage({Key? key}) : super(key: key);

  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  @override
  Widget build(BuildContext context) {
    AddressesProvider addressesProvider =
        Provider.of<AddressesProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleDeleteAddress(int id, String token) async {
      if (await addressesProvider.deleteAddress(id: id, token: token)) {
        if(await addressesProvider.getAddresses(token)) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pushNamed(context, '/address');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              'Gagal Delete Address',
              textAlign: TextAlign.center,
            )));
      }
    }

    Future<void> handleButtonDelete(int id, String token) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) => Container(
                width: MediaQuery.of(context).size.width - (2 * defaultMargin),
                child: AlertDialog(
                  backgroundColor: whiteTextColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultBorder),
                  ),
                  content: SingleChildScrollView(
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.close,
                                  color: blackTextColor,
                                ))),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Text(
                          'are you sure ?',
                          style: blackTextStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: defaultBorder,
                        ),
                        Container(
                          height: 45,
                          width: 100,
                          child: TextButton(
                            onPressed: () => handleDeleteAddress(id, token),
                            style: TextButton.styleFrom(
                                backgroundColor: redBackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                )),
                            child: Text(
                              'Yes',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 18, fontWeight: bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ));
    }

    Widget radioAddressCustom(AddressesModel addressesModel, int index) {
      int isSelect = addressesModel.chosenAddress;
      return GestureDetector(
        onTap: () async {
          if(await addressesProvider.selectAddress(addressesModel.id, authProvider.user.token)) {
            if(await addressesProvider.getAddresses(authProvider.user.token)) {
              setState(() {
                isSelect = 1;
              });
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(bottom: defaultBorder),
          padding:
              EdgeInsets.symmetric(horizontal: 20, vertical: defaultBorder),
          decoration: BoxDecoration(
            color: whiteTextColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: isSelect == 1
                    ? orangeTextColor
                    : transparentBackgroundColor,
                width: 2),
            boxShadow: [
              BoxShadow(
                color: blackBackgroundColor.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 0),
              )
            ],
          ),
          child: Row(
            children: [
              Image.asset(
                (isSelect == 1)
                    ? 'assets/icon_selected.png'
                    : 'assets/icon_unselected.png',
                width: 20,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icon_home.png',
                          width: 16,
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Text(
                          addressesModel.addrName,
                          style: blackTextStyle.copyWith(fontWeight: bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: defaultMargin,
                    ),
                    Text(
                      addressesModel.addressFull,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, color: Color(0xFFB6B6B6)),
                    )
                  ],
                ),
              ),
              Image.asset(
                'assets/icon_edit.png',
                width: 20,
              ),
              const SizedBox(
                width: 8,
              ),
              GestureDetector(
                  onTap: () => handleButtonDelete(
                      addressesModel.id, authProvider.user.token),
                  child: Image.asset(
                    'assets/icon_delete.png',
                    width: 20,
                  )),
            ],
          ),
        ),
      );
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: whiteTextColor,
        // iconTheme: IconThemeData(color: blackTextColor),
        automaticallyImplyLeading: true,
        leading: GestureDetector(onTap: () async {
          if(await addressesProvider.getAddresses(authProvider.user.token)) {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/checkout');
          }
        }, child: InkWell(child: Icon(Icons.arrow_back, color: blackTextColor,))),
        title: Text(
          'Address',
          style: blackTextStyle.copyWith(fontWeight: bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icon_info.png',
                width: 24,
              )),
        ],
      );
    }

    Widget emptyAddress() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_home.png'),
            SizedBox(
              height: defaultBorder,
            ),
            Text(
              'No Address Yet',
              style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),
            ),
            SizedBox(
              height: defaultBorder,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Do you want to add an address ? ',
                  style:
                      blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/address-edit');
                    },
                    child: Text(
                      'Click here',
                      style: authFieldTextStyle.copyWith(
                          fontSize: 16, fontWeight: bold),
                    )),
              ],
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          SizedBox(
            height: defaultBorder,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Manage',
                style: blackTextStyle.copyWith(fontSize: 22, fontWeight: bold),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/address-edit');
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: orangeTextColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    'Add Address',
                    style:
                        whiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),
                  )),
            ],
          ),
          SizedBox(
            height: defaultBorder,
          ),
          Column(
            children: addressesProvider.addresses.map((e) {
              return radioAddressCustom(e, e.id);
            }).toList(),
          )
        ],
      );
    }

    return WillPopScope(
      onWillPop: () async {
        if(await addressesProvider.getAddresses(authProvider.user.token)) {
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, '/checkout');
          return true;
        } else {
          return false;
        }
      },
      child: Scaffold(
        appBar: header(),
        body: (addressesProvider.addresses.isEmpty) ? emptyAddress() : content(),
      ),
    );
  }
}
