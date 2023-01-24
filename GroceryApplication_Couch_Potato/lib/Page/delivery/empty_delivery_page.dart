import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import 'package:Couch_Potato/services/delivery_constant.dart';
import '../../navigation.dart';
import '../../Page/cart_page.dart';

class EmptyDeliveryPage extends StatefulWidget {
  @override
  _EmptyDeliveryPageState createState() => _EmptyDeliveryPageState();
}

class _EmptyDeliveryPageState extends State<EmptyDeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        title: Text(
          'Couch Potato',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.black,
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
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
          margin: EdgeInsets.fromLTRB(150, 60, 150, 60),
          width: MediaQuery.of(context).size.width * 0.36,
          height: MediaQuery.of(context).size.height * 0.12,
        ),
        Text(
          'You Have No Order Yet',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 50),
        Text(
          'Make the Payment Now At Cart Page',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 50),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.lightGreenAccent,
            side: BorderSide(color: Colors.lightGreenAccent, width: 1),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            minimumSize: Size(60, 50),
            textStyle: const TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold),
          ),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => CartPage())),
          child: const Text('Cart'),
        )
      ]),
    );
  }
}
