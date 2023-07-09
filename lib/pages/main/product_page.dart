import 'package:entity_delivery_v2/models/cart_list_model.dart';
import 'package:entity_delivery_v2/models/cart_model.dart';
import 'package:entity_delivery_v2/models/entity_model.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:entity_delivery_v2/providers/entity_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final EntityModel entity;
  final List<CartListModel> cartModel;
  final String token;
  const ProductPage({Key? key, required this.entity, required this.cartModel, required this.token}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  bool isAdded = false;

  @override
  void initState() {
    if(widget.cartModel.any((element) => element.entityModel.id == widget.entity.id)) {
      print(widget.entity.id);
      setState(() {
        isAdded = true;
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);


    handleAddToCart() async {
      if(await cartProvider.addToCart(id: widget.entity.id, name: widget.entity.name, token: authProvider.user.token)) {
        setState(() {
          isAdded = true;
        });
      } else {
        print('gagal masbro qq');
      }
    }

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: whiteTextColor,
        iconTheme: IconThemeData(
          color: blackTextColor,
        ),
        title: Text('Entity Detail', style: blackTextStyle.copyWith(fontWeight: bold),),
        actions: [
          Image.asset('assets/icon_star.png', width: 19,),
          const SizedBox(width: 9,),
          Center(child: Text(widget.entity.rating.toString(), style: authFieldTextStyle.copyWith(fontSize: 22, fontWeight: bold),)),
          SizedBox(width: 20,),
        ],
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
            onPressed: (isAdded) ? null : handleAddToCart,
            style: TextButton.styleFrom(
              backgroundColor: (isAdded) ? addedBackgroundColor : yellowBackgroundButtonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(23),
              )
            ),
            child: Text((isAdded) ? 'Added' : 'Add to Cart', style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),),
          ),
        ),
      );
    }

    Widget infoEntity({required String info, required Color color}) {
      return Container(
        margin: const EdgeInsets.only(right: 6),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color
        ),
        child: Text(info, style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          SizedBox(height: defaultMargin,),
          Container(
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: NetworkImage(widget.entity.detail!.hdImageUrl),
                fit: BoxFit.cover
              )
            ),
          ),
          const SizedBox(height: 25,),
          // CONTENT TEXT
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(widget.entity.name, style: blackTextStyle.copyWith(fontSize: 28, fontWeight: semiBold),)),
                    Image.asset((isAdded) ? 'assets/icon_circle_green.png' : 'assets/icon_circle.png', width: 26,),
                  ],
                ),
                const SizedBox(height: 8,),
                Text('Rp. ${widget.entity.price.toString() }', style: orangeTextStyle.copyWith(fontSize: 22, fontWeight: bold),),
                SizedBox(height: defaultMargin,),
                Row(
                  children: [
                    infoEntity(info: 'Gorengan', color: orangeTextColor),
                    infoEntity(info: 'Cheap', color: greenBackgroundColor),
                    infoEntity(info: 'Promo', color: redBackgroundColor),
                  ],
                ),
                SizedBox(height: defaultBorder,),
                Text('Description', style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),),
                SizedBox(height: defaultMargin,),
                Text(widget.entity.detail!.note, style: authFieldTextStyle.copyWith(fontSize: 16),),
                SizedBox(height: defaultBorder,),
                SizedBox(height: defaultBorder,), // FOR MARGIN BOTTOM
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
      bottomNavigationBar: customButtonNav(),
    );
  }
}
