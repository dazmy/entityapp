import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final List<String> provinceDummy = ['1', '2'];

class _RegisterPageState extends State<RegisterPage> {
  String dropdownValue = provinceDummy.first;
  int indexPage = 1;

  TextEditingController fName = TextEditingController(text: '');
  TextEditingController lName = TextEditingController(text: '');
  TextEditingController phone = TextEditingController(text: '');
  TextEditingController addressName = TextEditingController(text: '');
  // province
  TextEditingController province = TextEditingController(text: '1');
  // city
  TextEditingController city = TextEditingController(text: '1');
  // district
  TextEditingController district = TextEditingController(text: '1');
  // postal
  TextEditingController postal = TextEditingController(text: '59996');
  TextEditingController address = TextEditingController(text: '');
  TextEditingController email = TextEditingController(text: '');
  TextEditingController password = TextEditingController(text: '');
  TextEditingController passwordConfirm = TextEditingController(text: '');


  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleRegister() async {
      if(password.text == passwordConfirm.text) {
        if(await authProvider.register(fName: fName.text, lName: lName.text, phone: phone.text, addressName: addressName.text, province: province.text, city: city.text, district: district.text, postal: postal.text, address: address.text, email: email.text, password: password.text)) {
          Navigator.pushNamedAndRemoveUntil(context, '/register-success', (route) => false);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              'Gagal Register',
              textAlign: TextAlign.center,
            )));
      }
    }

    PreferredSizeWidget header() {
      return PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.22),
        child: AppBar(
          backgroundColor: transparentBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(
            color: blackTextColor,
          ),
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

    Widget registerText() {
      return Container(
        margin: const EdgeInsets.only(top: 70, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (indexPage > 2) ? 'Create Account' : 'Personal Identity',
              style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              (indexPage > 2)
                  ? 'Enter Email, Password and Password Confirmation'
                  : 'Enter Your Name and Address',
              style: blackSecondaryTextStyle,
            ),
          ],
        ),
      );
    }

    Widget firstNameInput() {
      return Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: fName,
                style: blackTextStyle.copyWith(fontWeight: medium),
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                  hintStyle: authFieldTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget lastNameInput() {
      return Container(
        height: 45,
        margin: EdgeInsets.only(top: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: lName,
                style: blackTextStyle.copyWith(fontWeight: medium),
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                  hintStyle: authFieldTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phoneInput() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextFormField(
                controller: phone,
                style: blackTextStyle.copyWith(fontWeight: medium),
                decoration: InputDecoration.collapsed(
                  hintText: 'Phone',
                  hintStyle: authFieldTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget nameAddressInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Name Address', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: Row(
              children: [
                Image.asset('assets/icon_home.png'),
                const SizedBox(width: 12,),
                Expanded(
                  child: TextFormField(
                    controller: addressName,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    decoration: InputDecoration.collapsed(
                      hintText: 'Kontrakan Ku No. 2',
                      hintStyle: authFieldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget provinceInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Province*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: provinceDummy.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget cityInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('City*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: provinceDummy.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget districtInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('District*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: provinceDummy.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget postalInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Postal*', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 45,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: DropdownButton(
              isExpanded: true,
              style: authFieldTextStyle.copyWith(fontSize: 16),
              underline: Container(
                color: transparentBackgroundColor,
              ),
              value: dropdownValue,
              onChanged: (value) {
                setState(() {
                  dropdownValue = value!;
                });
              },
              items: provinceDummy.map((String value) {
                return DropdownMenuItem(value: value,child: Text(value,),);
              }).toList(),
            ),
          ),
        ],
      );
    }

    Widget addressInput() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: defaultMargin,),
          Text('Full Address', style: blackTextStyle.copyWith(fontSize: 18, fontWeight: bold),),
          const SizedBox(height: 12,),
          Container(
            height: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: greyBackgroundColor,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: address,
                    style: blackTextStyle.copyWith(fontWeight: medium),
                    maxLines: 2,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Jl. Monumen Perjuangan No.50, Glondong, Wirokerten, Kec. Banguntapan, Kabupaten Bantul, Daerah Istimewa Yogyakarta 55194',
                      hintStyle: authFieldTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget emailInput() {
      return Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: email,
                style: blackTextStyle.copyWith(fontWeight: medium),
                decoration: InputDecoration.collapsed(
                  hintText: 'Email',
                  hintStyle: authFieldTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        height: 45,
        margin: EdgeInsets.only(top: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: password,
                obscureText: true,
                style: blackTextStyle.copyWith(fontWeight: medium),
                decoration: InputDecoration.collapsed(
                  hintText: 'Password',
                  hintStyle: authFieldTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget passwordConfirmInput() {
      return Container(
        height: 45,
        margin: EdgeInsets.only(top: defaultMargin),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: passwordConfirm,
                obscureText: true,
                style: blackTextStyle.copyWith(fontWeight: medium),
                decoration: InputDecoration.collapsed(
                  hintText: 'Password Confirmation',
                  hintStyle: authFieldTextStyle,
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget registerFirst() {
      return Column(
        children: [
          firstNameInput(),
          lastNameInput(),
          phoneInput(),
        ],
      );
    }

    Widget registerSecond() {
      return Column(
        children: [
          nameAddressInput(),
          Row(
            children: [
              Flexible(flex: 1, child: provinceInput()),
              const SizedBox(width: 3,),
              Flexible(flex: 1, child: cityInput()),
            ],
          ),
          Row(
            children: [
              Flexible(flex: 1, child: districtInput()),
              const SizedBox(width: 3,),
              Flexible(flex: 1, child: postalInput()),
            ],
          ),
          addressInput(),
        ],
      );
    }

    Widget registerThird() {
      return Column(
        children: [
          emailInput(),
          passwordInput(),
          passwordConfirmInput(),
        ],
      );
    }

    Widget registerForm() {
      return Container(
        // width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: whiteTextColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: blackBackgroundColor.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 0),
            )
          ],
        ),
        child: (indexPage == 1) ? registerFirst() : (indexPage == 2) ? registerSecond() : registerThird(),
      );
    }

    Widget nextOrRegisterButton() {
      return Align(
        alignment: const Alignment(1, 0),
        child: Container(
          height: 45,
          width: 150,
          margin: EdgeInsets.only(top: defaultBorder),
          child: TextButton(
            onPressed: (indexPage > 2)
                ? handleRegister
                : () {
                    setState(() {
                      indexPage++;
                    });
                  },
            style: TextButton.styleFrom(
              backgroundColor: yellowBackgroundButtonColor,
            ),
            child: Text(
              (indexPage > 2) ? 'Register' : 'Next',
              style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: header(),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          registerText(),
          registerForm(),
          nextOrRegisterButton(),
        ],
      ),
    );
  }
}
