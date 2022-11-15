import 'package:flutter/material.dart';
import '../navigation.dart';
import 'cart_page.dart';
import 'delivery_page.dart';
import 'profile_page.dart';
import 'product_page.dart';

class DeliveryPage extends StatefulWidget {
  @override
  _DeliveryPageState createState() => _DeliveryPageState();
}

class _DeliveryPageState extends State<DeliveryPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'Delivery',
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
        body: Center(
            child: Text('Delivery Page', style: TextStyle(fontSize: 19))),
      );
}
