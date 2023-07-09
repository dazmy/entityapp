import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:entity_delivery_v2/widgets/checkout_tile.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddressesProvider addressesProvider = Provider.of<AddressesProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    int total = 0;
    String addressSelect = 'none';
    for(var item in cartProvider.cartModel.itemList.map((e) => e.quantity * e.entityModel.price).toList()) {
      total += item;
    }
    for(var item in addressesProvider.addresses.where((element) => element.chosenAddress == 1)) {
      addressSelect = item.addrName;
    }

    toAddress() async {
      if(await addressesProvider.getAddresses(authProvider.user.token)) {
        return Navigator.pushNamed(context, '/address');
      }
    }

    handleCheckout() async {
      if(await cartProvider.checkout(token: authProvider.user.token)) {
        Navigator.pushNamedAndRemoveUntil(context, '/checkout-success', (route) => false,);
      } else {
        print('qq');
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: whiteTextColor,
        iconTheme: IconThemeData(
          color: blackTextColor
        ),
        title: Text('Checkout Confirmation', style: blackTextStyle.copyWith(fontWeight: bold),),
      );
    }

    Widget customButtonNav() {
      return Container(
        padding: EdgeInsets.symmetric(vertical: defaultMargin, horizontal: defaultBorder),
        decoration: BoxDecoration(
            color: whiteTextColor,
            border: Border(
                top: BorderSide(
                    color: blackBackgroundColor
                )
            )
        ),
        child: Container(
          height: 45,
          width: double.infinity,
          child: TextButton(
            onPressed: handleCheckout,
            style: TextButton.styleFrom(
                backgroundColor: yellowBackgroundButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                )
            ),
            child: Row(
              children: [
                SizedBox(width: defaultBorder,),
                Expanded(child: Text('Rp. $total', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),)),
                Text('Checkout', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
                const SizedBox(width: 12,),
                Image.asset('assets/icon_next.png', width: 26,),
                SizedBox(width: defaultBorder,),
              ],
            ),
          ),
        ),
      );
    }

    Widget address() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: defaultMargin,),
                Text('Address Destination', style: authFieldTextStyle.copyWith(fontSize: 22, fontWeight: bold),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: defaultMargin),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFB6B6B6)),
              ),
              child: Row(
                children: [
                  Image.asset('assets/icon_home.png', width: 25,),
                  const SizedBox(width: 20,),
                  Expanded(child: Text(addressSelect, style: authFieldTextStyle.copyWith(fontSize: 18, fontWeight: bold), overflow: TextOverflow.ellipsis, maxLines: 1,)),
                  GestureDetector(onTap: toAddress, child: Text('ubah', style: orangeTextStyle.copyWith(fontSize: 18, fontWeight: bold),))
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget summary() {
      return Container(
        margin: EdgeInsets.only(top: defaultBorder),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: defaultMargin,),
                Text('Summary', style: authFieldTextStyle.copyWith(fontSize: 22, fontWeight: bold),),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: defaultMargin),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFB6B6B6)),
              ),
              child: Column(
                children: cartProvider.cartModel.itemList.map((e) {
                  return CheckoutTile(cartListModel: e,);
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: ListView(
        padding: EdgeInsets.all(defaultMargin),
        children: [
          address(),
          summary(),
        ],
      ),
      bottomNavigationBar: customButtonNav(),
    );
  }
}
