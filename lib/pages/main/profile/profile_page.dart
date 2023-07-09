import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    AddressesProvider addressesProvider = Provider.of<AddressesProvider>(context);
    String currentAddress = 'none';
    for(var item in addressesProvider.addresses.where((element) => element.chosenAddress == 1)) {
      currentAddress = item.addrName;
    }

    handleLogout() async {
      if(await authProvider.logout(token: authProvider.user.token)) {

        // Navigator.popUntil(context, ModalRoute.withName('/login')); // GX BISA
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              'Gagal Logout',
              textAlign: TextAlign.center,
            )));
      }
    }

    getAddresses() async {
      if(await addressesProvider.getAddresses(authProvider.user.token)) {
        return Navigator.pushNamed(context, '/address');
      }
    }

    Future<void> handleButtonLogout() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) => Container(
          width: MediaQuery.of(context).size.width - (2 * defaultMargin),
          child: AlertDialog(
            backgroundColor: whiteTextColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorder),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Align(alignment: Alignment.topLeft, child: GestureDetector(onTap: () {Navigator.pop(context);}, child: Icon(Icons.close, color: blackTextColor,))),
                  SizedBox(height: defaultMargin,),
                  Text('are you sure ?', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(height: defaultBorder,),
                  Container(
                    height: 45,
                    width: 100,
                    child: TextButton(
                      onPressed: handleLogout,
                      style: TextButton.styleFrom(
                        backgroundColor: redBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                      child: Text('Yes', style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
    }

    PreferredSizeWidget header() {
      return AppBar(
        iconTheme: IconThemeData(
          color: blackTextColor
        ),
        backgroundColor: whiteTextColor,
        // elevation: 0,
        title: Text('Profile', style: blackTextStyle.copyWith(fontWeight: bold),),
      );
    }

    Widget content() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/image_profile.png', width: 120,),
            const SizedBox(height: 25,),
            Text(authProvider.user.name, style: blackTextStyle.copyWith(fontSize: 28, fontWeight: bold),),
            const SizedBox(height: 10,),
            Text('UUID :', style: authFieldTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
            Text(authProvider.user.id, style: authFieldTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
            const SizedBox(height: 45,),
            Column(
              children: [
                Text('Current Address :', style: authFieldTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
                const SizedBox(height: 3,),
                Text(currentAddress, style: greyTertiaryTextStyle.copyWith(fontSize: 18),)
              ],
            ),
            SizedBox(height: defaultBorder,),
            Container(
              height: 45,
              width: 215,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  backgroundColor: yellowBackgroundButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  )
                ),
                child: Text('Reset Password', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
              ),
            ),
            const SizedBox(height: 40,),
            Container(
              height: 45,
              width: 215,
              child: TextButton(
                onPressed: handleButtonLogout,
                style: TextButton.styleFrom(
                    backgroundColor: yellowBackgroundButtonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
                child: Text('Logout', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: whiteTextColor,
      appBar: header(),
      body: content(),
    );
  }
}
