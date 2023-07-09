import 'package:entity_delivery_v2/models/cart_list_model.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';

class CheckoutTile extends StatelessWidget {
  final CartListModel cartListModel;
  const CheckoutTile({Key? key, required this.cartListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Image.asset('assets/image_gorengan.png', width: 50,),
          SizedBox(width: defaultMargin,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(cartListModel.entityModel.name, style: blackTextStyle.copyWith(fontSize: 16),),
              const SizedBox(height: 5,),
              Row(
                children: [
                  Text(cartListModel.quantity.toString(), style: blackTextStyle.copyWith(fontSize: 16),),
                  Text(' * ', style: blackTextStyle.copyWith(fontSize: 16),),
                  Text('Rp. ${cartListModel.entityModel.price}', style: blackTextStyle.copyWith(fontSize: 16),),
                  Text(' = ', style: blackTextStyle.copyWith(fontSize: 16),),
                  Text('Rp. ${cartListModel.quantity * cartListModel.entityModel.price}', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
