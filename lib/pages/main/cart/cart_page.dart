import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:entity_delivery_v2/widgets/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AddressesProvider addressesProvider = Provider.of<AddressesProvider>(context);

    handleNextCheckout() async {
      if(await cartProvider.getItemList(authProvider.user.token)) {
        if(await addressesProvider.getAddresses(authProvider.user.token)) {
        return Navigator.pushNamed(context, '/checkout');
        }
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: yellowBackgroundColor,
        iconTheme: IconThemeData(
          color: blackTextColor,
        ),
        title: Text('Order', style: blackTextStyle.copyWith(fontWeight: bold),),
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
            onPressed: handleNextCheckout,
            style: TextButton.styleFrom(
                backgroundColor: yellowBackgroundButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Checkout', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
                const SizedBox(width: 12,),
                Image.asset('assets/icon_next.png', width: 26,),
              ],
            ),
          ),
        ),
      );
    }

    Widget cartText() {
      return Container(
        margin: const EdgeInsets.only(top: 35),
        child: Column(
          children: [
            Text('Cart', style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),),
            const SizedBox(height: 6,),
            Text('Review and Checkout Now!', style: blackTextStyle.copyWith(fontSize: 16,),)
          ],
        ),
      );
    }

    Widget emptyCart() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_cart.png'),
            SizedBox(height: defaultBorder,),
            Text('No Cart Yet', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
            SizedBox(height: defaultBorder,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do you want to add an entity ? ', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),),
                GestureDetector(onTap: () {
                  Navigator.pop(context);
                }, child: Text('Click here', style: authFieldTextStyle.copyWith(fontSize: 16, fontWeight: bold),)),
              ],
            ),
          ],
        ),
      );
    }


    Widget content() {
      int index = 0;
      return Container(
        margin: const EdgeInsets.only(top: 35),
        child: Column(
          children: cartProvider.cartModel.itemList.map((e) {
            setState(() {
              index++;
            });
            return CartCard(cartList: e, entityModel: e.entityModel, index: index, qty: e.quantity);
          }).toList(),
        ),
      );
    }

    refreshData() async {
      await cartProvider.getItemList(authProvider.user.token);
      setState(() {});
    }

    return Scaffold(
      appBar: header(),
      body: (cartProvider.cartModel.itemList.isEmpty) ? emptyCart() : RefreshIndicator(onRefresh: refreshData,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          children: [
            cartText(),
            content(),
          ],
        ),
      ),
      bottomNavigationBar: (cartProvider.cartModel.itemList.isEmpty) ? const SizedBox() :customButtonNav(),
    );
  }
}
