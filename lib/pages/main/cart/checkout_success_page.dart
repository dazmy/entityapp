import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:lottie/lottie.dart';

class CheckoutSuccessPage extends StatelessWidget {
  const CheckoutSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return AppBar(
        backgroundColor: yellowBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: blackTextColor
        ),
        title: Text('Success Checkout', style: blackTextStyle.copyWith(fontWeight: bold),),
      );
    }

    Widget content() {
      return Container(
        margin: EdgeInsets.all(defaultBorder),
        child: Column(
          children: [
            Lottie.asset('assets/icon_success_register.json'),
            SizedBox(height: defaultBorder,),
            Text('TF HERE', style: blackTextStyle.copyWith(fontSize: 20),),
            Text('7164867007', style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),),
            Spacer(),
            Container(
              height: 45,
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
                style: TextButton.styleFrom(
                  backgroundColor: yellowBackgroundButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text('Home', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: content(),
    );
  }
}
