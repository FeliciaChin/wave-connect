import 'dart:math';

import 'package:flutter/material.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import 'package:Couch_Potato/home_screen.dart';
import '../navigation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  CollectionReference _orders = FirebaseFirestore.instance.collection("Order");
  late Future<QuerySnapshot> _orderList;
  List<Map> historyList = [];
  var productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderList = _orders.get();
    _orderList.then((value) {
      setState(() {
        historyList = parseData(value);
      });
    });
  }

  List<Map> parseData(QuerySnapshot querySnapshot) {
    List<QueryDocumentSnapshot> listDocs = querySnapshot.docs;
    List<Map> listOrder = listDocs
        .map((e) => {
              'productName': e["productList"],
              'price': e['price'],
              'payment': e['paymentMethod'],
              'address': e['deliveryAddress'],
              'status': e['status'],
            })
        .toList();

    return listOrder;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        drawer: NavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'Order History',
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
        body: historyList.length == 0
            ? Center(
                child: const Text(
                'No items found',
                style: TextStyle(fontSize: 50),
              ))
            : ListView(
                padding: EdgeInsetsDirectional.all(10.0),
                children: List.generate(historyList.length, (index) {
                  List productDetails =
                      jsonDecode(historyList[index]['productName']);
                  return Column(children: [
                    ListTile(
                        style: ListTileStyle.drawer,
                        tileColor: Colors.white,
                        title: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color.fromARGB(
                                                255, 210, 210, 210)))),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order #" + (index + 1).toString(),
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ],
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(historyList[index]['address'].toString(),
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: Colors.black45)),
                            SizedBox(
                              height: 10.0,
                            ),
                          ],
                        )),
                        subtitle: Container(
                            child: Column(children: [
                          Column(
                              children:
                                  List.generate(productDetails.length, (index) {
                            var imageURL = '';
                            var products = Product.products;
                            for (var product in products) {
                              if (product.name
                                  .contains(productDetails[index]['product'])) {
                                imageURL = product.imageUrl;
                              }
                            }
                            return ListTile(
                              leading: Image.network(
                                imageURL,
                                fit: BoxFit.fitHeight,
                              ),
                              title: Text(
                                productDetails[index]["product"].toString(),
                                textAlign: TextAlign.left,
                              ),
                              subtitle: Text(
                                " x" +
                                    productDetails[index]["quantity"]
                                        .toString(),
                                style: TextStyle(fontSize: 15),
                              ),
                              // tileColor: Colors.amberAccent,
                            );
                          })),
                          Container(
                              padding: const EdgeInsets.all(15.0),
                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Color.fromARGB(
                                              255, 161, 161, 161)))),
                              child: Column(children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text("Order Total: "),
                                      Text(
                                        'RM' + historyList[index]['price'],
                                        style: TextStyle(
                                            color: Colors.amber[800],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                              ]))
                        ]))),
                    SizedBox(
                      height: 10.0,
                    )
                  ]);
                }),
              ));
  }
}
