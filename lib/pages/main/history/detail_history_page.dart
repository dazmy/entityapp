import 'package:entity_delivery_v2/models/history_transaction_model.dart';
import 'package:entity_delivery_v2/widgets/detail_history_card.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:intl/intl.dart';

class DetailHistoryPage extends StatelessWidget {
  final HistoryTransactionModel historyTransactionModel;
  const DetailHistoryPage({Key? key, required this.historyTransactionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: whiteTextColor,
        iconTheme: IconThemeData(color: blackTextColor),
        title: Text(
          'Transaction Detail',
          style: blackTextStyle.copyWith(fontWeight: bold),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icon_info.png',
                width: 24,
              )),
        ],
      );
    }

    Widget content() {
      return ListView(
        children: [
          Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                color: yellowBackgroundButtonColor,
              ),
              // CIRCLE + ICON
              Container(
                margin: EdgeInsets.only(top: defaultBorder),
                width: MediaQuery.of(context).size.width * 2,
                height: 500,
                decoration: BoxDecoration(
                  color: whiteTextColor,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  margin: EdgeInsets.only(top: defaultBorder * 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        (historyTransactionModel.orderStatus == 'Pending') ? 'assets/cooking.gif' : (historyTransactionModel.orderStatus == 'Delivering') ? 'assets/ontheway.gif' : 'assets/shopping.gif',
                        width: 166,
                      ),
                    ],
                  ),
                ),
              ),
              //CONTENT ORDER
              Container(
                margin: const EdgeInsets.only(top: 260),
                // height: MediaQuery.of(context).size.height,
                color: whiteTextColor,
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 25,
                        ),
                        Center(
                            child: Text(
                              historyTransactionModel.orderStatusMessage,
                              style: blackTextStyle.copyWith(
                                  fontSize: 28, fontWeight: bold),
                            )),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text(
                                'ORDER ID :',
                                style: greyTertiaryTextStyle.copyWith(fontSize: 18),
                              ),
                              Text(
                                historyTransactionModel.id.toString(),
                                style: greyTertiaryTextStyle.copyWith(
                                    fontSize: 18, fontWeight: bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: defaultBorder,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: defaultMargin),
                            child: Text(
                              'Last Transaction Activity :',
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: bold),
                            )),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: defaultMargin),
                            child: Row(
                              children: [
                                Text(
                                    DateFormat('jms').format(historyTransactionModel.createdAt),
                                  style: greyTertiaryTextStyle.copyWith(fontSize: 18),
                                ),
                                const SizedBox(width: 3,),
                                Text(
                                    DateFormat('yMMMMEEEEd').format(historyTransactionModel.createdAt),
                                  style: greyTertiaryTextStyle.copyWith(fontSize: 18),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: defaultMargin),
                            child: Text(
                              'List Order :',
                              style: blackTextStyle.copyWith(
                                  fontSize: 18, fontWeight: bold),
                            )),
                        SizedBox(
                          height: defaultMargin,
                        ),
                        Column(
                          children: historyTransactionModel.cartModel.itemList.map((e) {
                            return DetailHistoryCard(cartListModel: e,);
                          }).toList(),
                        ),
                      ],
                    )),
              ),
            ],
          ),
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
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
                backgroundColor: yellowBackgroundButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                )
            ),
            child: Text('Go Back', style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteTextColor,
      appBar: header(),
      body: content(),
      bottomNavigationBar: customButtonNav(),
    );
  }
}
