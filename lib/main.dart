import 'package:flutter/material.dart';
import 'screens/login/login.dart';
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
      title: 'Login Demo',

      initialRoute: '/',
      routes: {
        '/': (context) => PatternCarousel(), 
        '/login': (context) => LoginPage(),  
      },
    );
  }
}
