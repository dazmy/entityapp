import 'package:entity_delivery_v2/models/entity_model.dart';
import 'package:entity_delivery_v2/pages/main/product_page.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:entity_delivery_v2/providers/entity_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class EntityCard extends StatelessWidget {
  final EntityModel entity;
  const EntityCard({Key? key,
  required this.entity}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    CartProvider cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () async {
        if(await cartProvider.getItemList(authProvider.user.token)) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ProductPage(entity: entity, cartModel: cartProvider.cartModel.itemList, token: authProvider.user.token);
        }));
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteTextColor,
          boxShadow: [
            BoxShadow(
              color: blackBackgroundColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(entity.imageUrl, width: 83, height: 83, fit: BoxFit.cover,)),
            const SizedBox(width: 15,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icon_star.png', width: 13,),
                    const SizedBox(width: 6,),
                    Text(entity.rating.toString(), style: authFieldTextStyle.copyWith(fontWeight: bold),),
                  ],
                ),
                const SizedBox(height: 2,),
                Text(entity.name, style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
                const SizedBox(height: 2,),
                Text('Rp. ${entity.price}', style: orangeTextStyle.copyWith(fontSize: 16, fontWeight: bold),)
              ],
            )),
            Image.asset('assets/icon_cart_card.png', width: 38,),
          ],
        ),
      ),
    );
  }
}
