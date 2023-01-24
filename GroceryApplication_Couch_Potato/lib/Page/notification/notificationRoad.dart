import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../delivery/road.dart';
import '../../navigation.dart';
import '../delivery.dart';
import '../Provider/orderStatus.dart';

class NotificationRoadPage extends StatefulWidget {
  @override
  _NotificationRoadPageState createState() => _NotificationRoadPageState();
}

class _NotificationRoadPageState extends State<NotificationRoadPage> {
  final end1 =
      DateTime.now().subtract(const Duration(minutes: 10, seconds: 30));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        title: Text(
          'Notifications',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => OrderStatusPage())),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(
                child: Container(
              width: 500,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Order Delivered",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Your Order is delivering now.",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 100),
                        child: Text(
                          DateFormat('yyyy-MM-dd KK:mm:ss a')
                              .format(DateTime.now()),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
            Padding(padding: EdgeInsets.all(10)),
            SizedBox(
                child: Container(
              width: 500,
              height: 140,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Order Received",
                          style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          "Your order is under processing now.",
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 180),
                        child: Text(
                          DateFormat('yyyy-MM-dd KK:mm:ss a').format(end1),
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
