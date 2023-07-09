import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:lottie/lottie.dart';

class RegisterSuccessPage extends StatelessWidget {
  const RegisterSuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize:
        Size.fromHeight(MediaQuery.of(context).size.height * 0.25),
        child: AppBar(
          backgroundColor: transparentBackgroundColor,
          elevation: 0,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                color: yellowBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(defaultBorder),
                  bottomRight: Radius.circular(defaultBorder),
                )),
          ),
        ),
      );
    }

    Widget iconSuccess() {
      return Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.only(top: 50),
        child: Lottie.asset('assets/icon_success_register.json'),
      );
    }

    Widget successText() {
      return Container(
        margin: EdgeInsets.only(top: defaultBorder),
        child: Column(
          children: [
            Text('Account Created', style: authTitleTextStyle.copyWith(fontSize: 24, fontWeight: bold),),
            const SizedBox(height: 4,),
            Text('Time to Login', style: blackTextStyle,)
          ],
        ),
      );
    }

    Widget toLoginButton() {
      return Container(
        margin: const EdgeInsets.only(top: 40),
        height: 45,
        width: 150,
        child: TextButton(
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
          },
          style: TextButton.styleFrom(
            backgroundColor: yellowBackgroundButtonColor
          ),
          child: Text('Login', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: Center(
        child: Column(
          children: [
            iconSuccess(),
            successText(),
            toLoginButton(),
          ],
        ),
      ),
    );
  }
}
