import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'navigation.dart';
import 'Page/cart_page.dart';
import 'Page/delivery_page.dart';
import 'Page/profile_page.dart';
import 'Page/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*

*/
class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  int currentIndex = 0;
  final screens = [
    ProductPage(),
    CartPage(),
    DeliveryPage(),
    ProfilePage(),
  ];
 


  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavBar(),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lightGreenAccent,
          selectedItemColor: Colors.deepOrangeAccent,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle),
              label: 'Delivery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );


}
