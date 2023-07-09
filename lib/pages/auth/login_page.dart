import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/entity_provider.dart';
import 'package:flutter/material.dart';
import 'package:entity_delivery_v2/theme.dart';
import 'package:provider/provider.dart';
import 'package:localstore/localstore.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleLogin() async {
      if(await authProvider.login(email: emailController.text, password: passwordController.text)) {
        if(await Provider.of<EntityProvider>(context, listen: false).getEntity(authProvider.user.token)) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: const Text(
              'Gagal Login',
              textAlign: TextAlign.center,
            )));
      }
    }

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

    Widget loginText() {
      return Center(
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text(
                'Login to Entity',
                style: blackTextStyle.copyWith(fontSize: 24, fontWeight: bold),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Buy Entity from Here',
                style: blackSecondaryTextStyle,
              ),
            ],
          ),
        ),
      );
    }

    Widget usernameInput() {
      return Container(
        height: 45,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Center(
          child: Row(
            children: [
              Image.asset('assets/icon_profile.png'),
              const SizedBox(width: 12,),
              Expanded(
                child: TextFormField(
                  controller: emailController,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                  decoration: InputDecoration.collapsed(
                    hintText: 'email',
                    hintStyle: authFieldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget passwordInput() {
      return Container(
        height: 45,
        margin: const EdgeInsets.only(top: 15),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: greyBackgroundColor,
        ),
        child: Center(
          child: Row(
            children: [
              Image.asset('assets/icon_password.png'),
              const SizedBox(width: 12,),
              Expanded(
                child: TextFormField(
                  controller: passwordController,
                  obscureText: (isOpen) ? false : true,
                  style: blackTextStyle.copyWith(fontWeight: medium),
                  decoration: InputDecoration.collapsed(
                    hintText: 'password',
                    hintStyle: authFieldTextStyle,
                  ),
                ),
              ),
              GestureDetector(onTap: () {
                setState(() {
                  isOpen = !isOpen;
                });
              }, child: Image.asset((isOpen) ? 'assets/icon_eye_password_open.png' : 'assets/icon_eye_password.png')),
            ],
          ),
        ),
      );
    }

    Widget loginForm() {
      return Container(
        margin: const EdgeInsets.only(top: 35),
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
        child: Column(
          children: [
            usernameInput(),
            passwordInput(),
          ],
        ),
      );
    }

    Widget forgotPassword() {
      return Container(
        margin: const EdgeInsets.only(top: 18, right: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('Forgot Password ?', style: greyTextStyle,),
          ],
        ),
      );
    }

    Widget loginButton() {
      return Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultBorder),
        child: TextButton(
          onPressed: handleLogin,
          style: TextButton.styleFrom(
            backgroundColor: blackBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          child: Text('Login', style: whiteTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
        ),
      );
    }

    Widget orText() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: Text('or', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
      );
    }

    Widget toRegisterButton() {
      return Container(
        height: 45,
        width: double.infinity,
        margin: EdgeInsets.only(top: defaultMargin),
        child: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/register');
          },
          style: TextButton.styleFrom(
            backgroundColor: yellowBackgroundButtonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            )
          ),
          child: Text('Create New Account', style: blackTextStyle.copyWith(fontSize: 16, fontWeight: bold),),
        ),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: header(),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          child: Column(
            children: [
              loginText(),
              loginForm(),
              forgotPassword(),
              loginButton(),
              orText(),
              toRegisterButton(),
            ],
          ),
        ),
      ),
    );
  }
}
