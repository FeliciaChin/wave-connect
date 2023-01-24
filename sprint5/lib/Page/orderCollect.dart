import 'package:flutter/material.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import '../navigation.dart';
import 'rating/rating_page.dart';
import 'order.dart';
import 'orderHistory.dart';
import '../Page/rating/rate_us_new.dart';

class orderCollectedPage extends StatefulWidget {
  @override
  _orderCollectedPageState createState() => _orderCollectedPageState();
}

class _orderCollectedPageState extends State<orderCollectedPage> {
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
          // margin: EdgeInsets.fromLTRB(150, 60, 150, 60),
          width: MediaQuery.of(context).size.width * 0.36,
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Text(
          'Order Collected Successfully',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 25),
        Text(
          'Review us at: ',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 26,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 25),
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
              MaterialPageRoute(builder: (context) => RateUs())),
          child: const Text('Rate Page'),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            'Check Your Order History: ',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blueGrey,
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 25),
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
              MaterialPageRoute(builder: (context) => HistoryPage())),
          child: const Text('Order History'),
        )
      ]),
    );
  }
}
