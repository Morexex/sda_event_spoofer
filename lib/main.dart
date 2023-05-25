import 'package:flutter/material.dart';
import 'package:sda_event_spoofer/auth/general_login.dart';
import 'package:sda_event_spoofer/auth/general_signup.dart';
import 'package:sda_event_spoofer/auth/supplier_login.dart';
import 'package:sda_event_spoofer/auth/supplier_signup.dart';
import 'main_screens/general_screens/general_screen.dart';
import 'main_screens/service_providers/services_screen.dart';
import 'main_screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: WelcomeScreen(),
      initialRoute: '/welcome_screen',
      routes: {
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/general_home': (context) => const GeneralScreen(),
        '/services_home': (context) => const ServicesScreen(),
        '/generalSignup_screen': (context) => const GeneralRegisterScreen(),
        '/generalLogin_screen': (context) => const GeneralLoginScreen(),
        '/supplierLogin_screen': (context) => const SupplierLoginScreen(),
        '/supplierSignup_screen': (context) => const SupplierRegisterScreen(),
      },
    );
  }
}


