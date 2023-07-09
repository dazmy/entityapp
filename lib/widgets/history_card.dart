import 'package:entity_delivery_v2/models/history_transaction_model.dart';
import 'package:entity_delivery_v2/pages/main/history/detail_history_page.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/history_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryCard extends StatelessWidget {
  final HistoryTransactionModel historyTransactionModel;
  const HistoryCard({Key? key, required this.historyTransactionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dt = historyTransactionModel.createdAt;
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    HistoryTransactionProvider historyTransactionProvider = Provider.of<HistoryTransactionProvider>(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DetailHistoryPage(historyTransactionModel: historyTransactionModel);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: defaultMargin),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: defaultMargin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteTextColor,
          boxShadow: [
            BoxShadow(
              color: blackBackgroundColor.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/icon_cart_history.png',
                  width: 32,
                ),
                SizedBox(
                  width: defaultMargin,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat('yMMMMEEEEd').format(dt),
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: semiBold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID :',
                            style: greyTertiaryTextStyle.copyWith(fontSize: 12),
                          ),
                          Text(
                            historyTransactionModel.id,
                            style: greyTertiaryTextStyle.copyWith(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  'assets/icon_dots.png',
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rp. ${historyTransactionModel.totalPrice}',
                        style: blackTextStyle.copyWith(
                            fontSize: 20, fontWeight: bold),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            'Address : ',
                            style: greyTertiaryTextStyle,
                          ),
                          Text(
                            historyTransactionModel.addressesModel.addrName,
                            style: blackTextStyle.copyWith(fontWeight: bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (historyTransactionModel.orderStatus == 'Pending') ? orangeTextColor : (historyTransactionModel.orderStatus == 'Delivering') ? yellowBackgroundButtonColor : greenBackgroundColor),
                  child: Text(
                    historyTransactionModel.orderStatus.toUpperCase(),
                    style:
                        whiteTextStyle.copyWith(fontWeight: bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
