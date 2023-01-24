import 'package:flutter/material.dart';
import '../navigation.dart';
import 'rating/rating_page.dart';
import '../home_screen.dart';

class orderCancelPage extends StatefulWidget {
  @override
  _orderCancelPageState createState() => _orderCancelPageState();
}

class _orderCancelPageState extends State<orderCancelPage> {
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
          // margin: EdgeInsets.fromLTRB(60, 60, 60, 60),
          width: MediaQuery.of(context).size.width * 0.36,
          height: MediaQuery.of(context).size.height * 0.15,
        ),
        Text(
          'Your Order Had Been Cancelled',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Text(
            "If you pay with credit card/master card, the transaction will be transfer back within 15 minutes. If you didn't receive the money, please reach us as soon as possible.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 15,
            ),
          ),
        ),
        SizedBox(height: 50),
        Text(
          """Any Problem, please contact us at:
      Ms Alis: 017-000 9999
   Email: couchPotato@gmail.com""",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 15,
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
              MaterialPageRoute(builder: (context) => HomeScreen())),
          child: const Text('Return Main Page'),
        )
      ]),
    );
  }
}
