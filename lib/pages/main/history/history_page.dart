import 'package:entity_delivery_v2/providers/history_transaction_provider.dart';
import 'package:entity_delivery_v2/widgets/history_card.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HistoryTransactionProvider historyTransactionProvider = Provider.of<HistoryTransactionProvider>(context);

    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: whiteTextColor,
        iconTheme: IconThemeData(
            color: blackTextColor
        ),
        title: Text('Transaction History', style: blackTextStyle.copyWith(fontWeight: bold),),
        actions: [
          IconButton(onPressed: () {}, icon: Image.asset('assets/icon_info.png', width: 24,)),
        ],
      );
    }

    Widget emptyHistory() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon_history.png'),
            SizedBox(height: defaultBorder,),
            Text('No History Yet', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
            SizedBox(height: defaultBorder,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Do you want to add a history ? ', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: medium),),
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
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: defaultMargin),
        children: historyTransactionProvider.transactions.map((e) {
          return HistoryCard(historyTransactionModel: e,);
        }).toList(),
      );
    }

    return Scaffold(
      appBar: header(),
      body: (historyTransactionProvider.transactions.isEmpty) ? emptyHistory() : content(),
    );
  }
}
