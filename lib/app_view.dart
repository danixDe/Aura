import 'package:flutter/material.dart';

class MyApp1 extends StatelessWidget {
  const MyApp1({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text(
            'Donor Alert',
            style: TextStyle(color: Colors.white),
          ),
          shadowColor: Colors.grey,
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.bloodtype_rounded),
          onPressed: () {
            print('pressed!');
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.redAccent, // Color for selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Hospital',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.verified_user),
              label: 'Profile',
            ),
          ],
        ),
        drawer: Drawer(
          child: Text(
            "YO!",
          ),
        ),
      ),
    );
  }
}
