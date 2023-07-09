import 'package:entity_delivery_v2/pages/auth/login_page.dart';
import 'package:entity_delivery_v2/pages/auth/register_page.dart';
import 'package:entity_delivery_v2/pages/auth/register_success_page.dart';
import 'package:entity_delivery_v2/pages/main/cart/cart_page.dart';
import 'package:entity_delivery_v2/pages/main/cart/checkout_page.dart';
import 'package:entity_delivery_v2/pages/main/cart/checkout_success_page.dart';
import 'package:entity_delivery_v2/pages/main/history/detail_history_page.dart';
import 'package:entity_delivery_v2/pages/main/history/history_page.dart';
import 'package:entity_delivery_v2/pages/main/home_page.dart';
import 'package:entity_delivery_v2/pages/main/profile/address_page.dart';
import 'package:entity_delivery_v2/pages/main/profile/manage_address_page.dart';
import 'package:entity_delivery_v2/pages/main/profile/profile_page.dart';
import 'package:entity_delivery_v2/pages/splash_page.dart';
import 'package:entity_delivery_v2/providers/addresses_provider.dart';
import 'package:entity_delivery_v2/providers/auth_provider.dart';
import 'package:entity_delivery_v2/providers/cart_provider.dart';
import 'package:entity_delivery_v2/providers/entity_provider.dart';
import 'package:entity_delivery_v2/providers/history_transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((value) => runApp(const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => EntityProvider()),
        ChangeNotifierProvider(create: (context) => AddressesProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => HistoryTransactionProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          '/register-success': (context) => const RegisterSuccessPage(),
          '/home': (context) => const HomePage(),
          '/cart': (context) => const CartPage(),
          '/checkout': (context) => const CheckoutPage(),
          '/checkout-success': (context) => const CheckoutSuccessPage(),
          '/profile': (context) => const ProfilePage(),
          '/address': (context) => const AddressPage(),
          '/address-edit': (context) => const ManageAddressPage(),
          '/history': (context) => const HistoryPage(),
        },
      ),
    );
  }
}
