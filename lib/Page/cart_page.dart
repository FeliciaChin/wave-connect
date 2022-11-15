import 'package:flutter/material.dart';
import '../navigation.dart';
import 'cart_page.dart';
import 'delivery_page.dart';
import 'profile_page.dart';
import 'product_page.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'My Cart',
            style: TextStyle(fontSize: 30, letterSpacing: 1),
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
        body: Center(child: Text('Cart Page', style: TextStyle(fontSize: 19))),
      );
}
