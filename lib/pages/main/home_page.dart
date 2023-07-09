import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:entity_delivery_v2/providers/entity_provider.dart';
import 'package:entity_delivery_v2/providers/history_transaction_provider.dart';
import 'package:entity_delivery_v2/widgets/entity_card.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    EntityProvider entityProvider = Provider.of<EntityProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AddressesProvider addressesProvider = Provider.of<AddressesProvider>(context);
    HistoryTransactionProvider historyTransactionProvider = Provider.of<HistoryTransactionProvider>(context);

    Widget header() {
      return PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.23),
        child: AppBar(
          // title: Text('Welcome to Entity!', style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),),
          backgroundColor: transparentBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: blackBackgroundColor),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search))
          ],
          flexibleSpace: Container(
            height: MediaQuery.of(context).size.height * 0.23,
            color: yellowBackgroundColor,
            child: Align(
              alignment: const Alignment(-0.7, 0.6),
                child: Text(
              'Welcome to Entity!',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
            )),
          ),
        ),
      );
    }

    Widget customButtonNav() {
      return BottomNavigationBar(
        onTap: (index) async {
          switch (index) {
            case 0:
              if(await cartProvider.getItemList(authProvider.user.token)) {
                Navigator.pushNamed(context, '/cart');
              }
              break;
            case 1:
              if(await historyTransactionProvider.getTransactions(token: authProvider.user.token)) {
                Navigator.pushNamed(context, '/history');
              }
              break;
            default:
              if(await addressesProvider.getAddresses(authProvider.user.token)) {
                Navigator.pushNamed(context, '/profile');
              }
          }
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteTextColor,
        selectedItemColor: blackSecondaryTextColor,
        unselectedItemColor: blackSecondaryTextColor,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        items: [
          BottomNavigationBarItem(icon: Image.asset('assets/icon_cart.png', width: 30,), label: 'Cart',),
          BottomNavigationBarItem(icon: Image.asset('assets/icon_history.png', width: 30,), label: 'History'),
          BottomNavigationBarItem(icon: Image.asset('assets/icon_profile_outlined.png', width: 30,), label: 'Profile'),
        ],
      );
    }

    Widget content() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
          color: whiteTextColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(defaultBorder)),
        ),
        child: Column(
          children: [
            // NAME
            Container(
              margin: const EdgeInsets.only(left: 3, top: 40),
              child: Row(
                children: [
                  Text('Hallo ', style: blackTextStyle.copyWith(fontSize: 18),),
                  Text(authProvider.user.name, style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
                ],
              ),
            ),
            // PLAIN TEXT
            Container(
              margin: EdgeInsets.only(top: defaultBorder, left: 3),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('What Your Order ', style: blackTextStyle.copyWith(fontSize: 18),),
                      Text('Today ?', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Our platfrom define ', style: blackTextStyle.copyWith(fontSize: 18),),
                      Text('Entity ', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
                      Text('as { ', style: blackTextStyle.copyWith(fontSize: 18),),
                      Text(authProvider.user.entity!.name, style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
                      Text(' } ', style: blackTextStyle.copyWith(fontSize: 18),),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40,),
            Column(
              children: entityProvider.entity.map((e) => EntityCard(entity: e,)).toList(),
            ),
          ],
        ),
      );
    }

    refreshData() async {
      await entityProvider.getEntity(authProvider.user.token);
      setState(() {});
    }

    return Scaffold(
      backgroundColor: yellowBackgroundColor,
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: ListView(
          children: [
            header(),
            content(),
          ],
        ),
      ),
      bottomNavigationBar: customButtonNav(),
    );
  }
}
