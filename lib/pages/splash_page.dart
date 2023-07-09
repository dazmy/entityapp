import 'dart:async';

import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 130,
              height: 150,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_splash.png'),
                )
              ),
            ),
            Text('Entity Delivery', style: blackTextStyle.copyWith(fontSize: 30, fontWeight: bold),),
            SizedBox(height: defaultMargin,),
            Text('by.', style: greyTextStyle,),
            const SizedBox(height: 4,),
            Text('Abd. Naufal & Adam Fz', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),),
          ],
        ),
      ),
    );
  }
}
