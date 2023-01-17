import 'package:flutter/material.dart';
import '../navigation.dart';

class logOutPage extends StatefulWidget {
  @override
  _logOutPageState createState() => _logOutPageState();
}

class _logOutPageState extends State<logOutPage> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
        body: Center(
            child: Text('Log Out back to Sign in //add later',
                style: TextStyle(fontSize: 19))),
      );
}
