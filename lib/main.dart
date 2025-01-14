import 'package:flutter/material.dart';
import 'screens/login/donor_login.dart';
import 'screens/login/hos_login.dart';
import 'screens/login/role_selection.dart';
import 'screens/landing/landing.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => PatternCarousel(),
        '/donor-login': (context) => LoginPage(),
        '/hospital-login':(context) => const HospitalLoginPage(),
        '/role-selection': (context) => const RoleSelectionPage(),
      },
    );
  }
}
