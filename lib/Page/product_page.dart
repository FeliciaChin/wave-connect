import 'package:flutter/material.dart';
import '../navigation.dart';
import 'cart_page.dart';
import 'delivery_page.dart';
import 'profile_page.dart';
import 'product_page.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'Couch Potato',
            style: TextStyle(
              fontSize: 30,
              letterSpacing: 1,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
        body:
            Center(child: Text('Product Page', style: TextStyle(fontSize: 19))),
      );
}
