import 'package:entity_delivery_v2/models/cart_list_model.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';

class DetailHistoryCard extends StatelessWidget {
  final CartListModel cartListModel;
  const DetailHistoryCard({Key? key, required this.cartListModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(cartListModel.entityModel.imageUrl, width: 83, height: 83, fit: BoxFit.cover,)),
          // Container(
          //   width: 83,
          //   height: 83,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(12),
          //     image: DecorationImage(
          //       image: NetworkImage(cartListModel.entityModel.imageUrl),
          //       fit: BoxFit.cover
          //     )
          //   ),
          // ),
          const SizedBox(width: 15,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text('1.', style: authFieldTextStyle.copyWith(fontWeight: bold),),
              // const SizedBox(height: 2,),
              Text(cartListModel.entityModel.name, style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold), maxLines: 1, overflow: TextOverflow.ellipsis,),
              const SizedBox(height: 4,),
              Text('Rp. ${cartListModel.entityModel.price}', style: orangeTextStyle.copyWith(fontSize: 16, fontWeight: bold),)
            ],
          )),
          Row(
            children: [
              Text(cartListModel.quantity.toString(), style: blackTextStyle.copyWith(fontSize: 28, fontWeight: bold),),
              const SizedBox(width: 4,),
              Text('pcs', style: greyTertiaryTextStyle.copyWith(fontWeight: bold),)
            ],
          ),
        ],
      ),
    );
  }
}
