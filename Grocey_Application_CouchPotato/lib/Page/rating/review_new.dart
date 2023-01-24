import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:Couch_Potato/Page/rating/rating_page.dart';

class ReviewPage extends StatefulWidget {
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  int _ratingValue = 0;
  bool isMore = false;

  CollectionReference _reviews =
      FirebaseFirestore.instance.collection("Rating");
  late Future<QuerySnapshot> _reviewList;
  List<Map> reviewHistoryList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _reviewList = _reviews.get();
    _reviewList.then((value) {
      setState(() {
        reviewHistoryList = parseData(value);
      });
    });
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listReview = listDocs
        .map((e) => {
              'userName': e["Name"],
              'userRating': e['Rate'],
              'userComment': e['Comment'],
              'date': e['Date'],
            })
        .toList();

    return listReview;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //drawer: NavBar(),
      appBar: AppBar(
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
          'Reviews',
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
      body: reviewHistoryList.isEmpty
          ? Center(
              child: const Text(
              'No review found',
              style: TextStyle(fontSize: 40),
            ))
          : ListView(
              padding: EdgeInsetsDirectional.all(10.0),
              children: List.generate(reviewHistoryList.length, (index) {
                return Column(
                  children: [
                    ListTile(
                      style: ListTileStyle.drawer,
                      tileColor: Color.fromARGB(255, 223, 219, 207),
                      title: Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                                  width:
                                      MediaQuery.of(context).size.width * 0.12,
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage('assets/images/men.png'),
                                      )),
                                ),
                                Expanded(
                                  child: Text(
                                    reviewHistoryList[index]['userName']
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ]),
                              SizedBox(height: 5),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      "Rating: ${reviewHistoryList[index]['userRating'].toString()}/5",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red)),
                                  SizedBox(width: 20),
                                  Text(
                                      reviewHistoryList[index]['date']
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey)),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(children: [
                                SizedBox(width: 7),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Container(
                                      width: 350,
                                      child: isMore
                                          ? Text(
                                              reviewHistoryList[index]
                                                      ['userComment']
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            )
                                          : Text(
                                              reviewHistoryList[index]
                                                      ['userComment']
                                                  .toString(),
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
                                              ),
                                            )),
                                ),
                              ]),
                              SizedBox(height: 10),
                            ]),
                      ),
                    ),
                    SizedBox(height: 10),
                  ],
                );
              })),
    );
  }
}
