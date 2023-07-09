import 'package:entity_delivery_v2/models/cart_list_model.dart';
import 'package:entity_delivery_v2/models/entity_model.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class CartCard extends StatefulWidget {
  final EntityModel entityModel;
  final int index;
  int qty;
  final CartListModel cartList;
  CartCard({Key? key, required this.entityModel, required this.index, required this.qty, required this.cartList}) : super(key: key);

  @override
  State<CartCard> createState() => _CartCardState();
}

class _CartCardState extends State<CartCard> {
  // int lastQty = widget.qty;
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = Provider.of<CartProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleAddQty() async {
      if(await cartProvider.addQuantity(id: widget.cartList.id, qty: widget.qty + 1, token: authProvider.user.token)) {
          setState(() {
            widget.qty++;
          });
      } else {
        print('mana main');
      }
    }

    handleReduceQty() async {
      if(await cartProvider.reduceQuantity(id: widget.cartList.id, qty: widget.qty - 1, token: authProvider.user.token)) {
          setState(() {
            widget.qty--;
          });
      } else {
        print('mana main');
      }
    }

    return Container(
      margin: EdgeInsets.only(bottom: defaultBorder),
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
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(widget.entityModel.imageUrl, width: 83, height: 83, fit: BoxFit.cover,)),
          const SizedBox(width: 15,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${widget.index}.', style: authFieldTextStyle.copyWith(fontWeight: bold),),
              const SizedBox(height: 2,),
              Text(widget.entityModel.name, style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 4,),
              Text('Rp. ${widget.entityModel.price * widget.qty}', style: orangeTextStyle.copyWith(fontSize: 16, fontWeight: bold),)
            ],
          )),
          GestureDetector(onTap: handleReduceQty, child: Image.asset('assets/icon_min_outlined.png', width: 24,)),
          const SizedBox(width: 8,),
          Text(widget.qty.toString(), style: blackTextStyle.copyWith(fontSize: 28, fontWeight: bold),),
          const SizedBox(width: 8,),
          GestureDetector(onTap: handleAddQty, child: Image.asset('assets/icon_plus_outlined.png', width: 24,)),
        ],
      ),
    );
  }
}
