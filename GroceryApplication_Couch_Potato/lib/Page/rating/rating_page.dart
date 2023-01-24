import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'package:Couch_Potato/Page/rating/rate_us_new.dart';
import 'package:Couch_Potato/Page/rating/rating.dart';
import 'package:Couch_Potato/Page/rating/review_new.dart';
import '../../navigation.dart';

class RatingPage extends StatefulWidget {
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'Rating',
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 226, 224, 224),
                          side: BorderSide(
                              color: Color.fromARGB(255, 203, 202, 202),
                              width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          shadowColor: Color.fromARGB(255, 222, 219, 219),
                          minimumSize: Size(350, 100),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ReviewPage())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.comment_bank,
                                color: Colors.orange, size: 35),
                            Text('View Reviews'),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        )))),
            SizedBox(height: 10),
            Container(
                margin: EdgeInsets.fromLTRB(30, 50, 30, 0),
                child: Center(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Color.fromARGB(255, 226, 224, 224),
                          side: BorderSide(
                              color: Color.fromARGB(255, 203, 202, 202),
                              width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          shadowColor: Color.fromARGB(255, 222, 219, 219),
                          minimumSize: Size(350, 100),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => RateUs())),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Icon(Icons.star, color: Colors.yellow, size: 35),
                            Text('Rate Us         '),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        )))),
          ],
        ));
  }
}
