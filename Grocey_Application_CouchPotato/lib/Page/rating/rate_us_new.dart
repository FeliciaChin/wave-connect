import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:Couch_Potato/Page/rating/rating_page.dart';
import 'rating.dart';
import '../Provider/rating_controller.dart';

class RateUs extends StatefulWidget {
  const RateUs({Key? key}) : super(key: key);
  @override
  _RateUsState createState() => _RateUsState();
}

class _RateUsState extends State<RateUs> {
  int _rating = 0;
  String myName = "";
  late String comment;

  final _commentController = TextEditingController();
  final _nameController = TextEditingController();
  final _dateController =
      DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //drawer: NavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onTap: () {
                Navigator.of(context)
                    .pop(MaterialPageRoute(builder: (context) => RatingPage()));
              }),
          title: Text(
            'Rate Us',
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
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: Text(
                  'Please tell us your satisfaction about our service.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Rating((rating) {
                setState(() {
                  _rating = rating;
                });
              }),
              SizedBox(
                  height: 20,
                  child: _rating != null && _rating > 0
                      ? Text('$_rating points', style: TextStyle(fontSize: 16))
                      : SizedBox.shrink()),
              SizedBox(height: 10),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                child: TextField(
                  controller: _commentController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: 'Comment',
                    hintText: 'Your comment',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    comment = value;
                  },
                ),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.lightGreenAccent,
                  side: BorderSide(color: Colors.lightGreenAccent, width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  minimumSize: Size(60, 50),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  RatingController rC = RatingController();
                  rC.addRating(
                      _rating,
                      comment,
                      DateFormat('yyyy-MM-dd KK:mm:ss a')
                          .format(DateTime.now()));
                  await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Thank you for your rating !'),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) => RatingPage()));
                                },
                                child: const Text('OK')),
                          ],
                        );
                      });
                },
                child: const Text('Submit'),
              )
            ],
          ),
        ));
  }
}

