import 'package:Couch_Potato/delivery_man/Page/signaturePage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import 'package:Couch_Potato/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:signature/signature.dart';
import 'dart:convert';
import '../../Page/delivery/road.dart';
import '../delivery_home_screen.dart';

class DeliveryOrderList extends StatefulWidget {
  @override
  _DeliveryOrderListState createState() => _DeliveryOrderListState();
}

class _DeliveryOrderListState extends State<DeliveryOrderList> {
  CollectionReference _orders = FirebaseFirestore.instance.collection("Order");
  final documentReferences = FirebaseFirestore.instance.collection('Order');

  late Future<QuerySnapshot> _orderList;
  List<Map> orderList = [];
  var productList = [];
  List<Map> idList = [];
  var documentId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderID();
    _orderList = _orders.get();
    _orderList.then((value) {
      setState(() {
        orderList = parseData(value);
      });
    });
  }

  void getOrderID() {
    documentReferences.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        documentId.add(documentSnapshot.id);
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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'Order List',
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
        body: orderList.length == 0
            ? Center(
                child: const Text(
                'No items found',
                style: TextStyle(fontSize: 50),
              ))
            : ListView(
                padding: EdgeInsetsDirectional.all(10.0),
                children: List.generate(orderList.length, (index) {
                  List productDetails =
                      jsonDecode(orderList[index]['productName']);
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
                                    Container(child: LayoutBuilder(
                                        builder: (context, constraints) {
                                      if (orderList[index]['status']
                                              .toString() ==
                                          "Delivering") {
                                        return Text(
                                            "[" +
                                                orderList[index]['status']
                                                    .toString() +
                                                "]",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    209, 244, 5, 5)));
                                      } else if (orderList[index]['status']
                                              .toString() ==
                                          "In Progress") {
                                        return Text(
                                            "[" +
                                                orderList[index]['status']
                                                    .toString() +
                                                "]",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    209, 42, 88, 215)));
                                      } else {
                                        return Text(
                                            "[" +
                                                orderList[index]['status']
                                                    .toString() +
                                                "]",
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color.fromARGB(
                                                    209, 85, 215, 42)));
                                      }
                                    })),
                                    //     else
                                  ],
                                )),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(orderList[index]['address'].toString(),
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
                            //documentId.add(documentReferences.id);

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
                                        'RM' + orderList[index]['price'],
                                        style: TextStyle(
                                            color: Colors.amber[800],
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    orderList[index]['status'].toString() ==
                                            "In Progress"
                                        ? TextButton(
                                            child: Text(
                                              "Accepted",
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 218, 58, 9),
                                              ),
                                            ),
                                            onPressed: () {
                                              _updateData("Delivering",
                                                  documentId.elementAt(index));
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeliveryHomeScreen()),
                                              );
                                            },
                                          )
                                        : Center(),
                                    orderList[index]['status'].toString() ==
                                            "Delivering"
                                        ? TextButton(
                                            child: Text(
                                              'Customer Signature',
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 218, 58, 9),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SignaturePage(documentId
                                                            .elementAt(index))),
                                              );
                                            },
                                          )
                                        : Center()
                                  ],
                                )
                              ]))
                        ]))),
                    SizedBox(
                      height: 10.0,
                    ),
                  ]);
                }),
              ));
  }
}

Future _updateData(String progress, String id) async {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance.collection('Order').doc(id).update({
      'status': progress,
    }).then((result) => print('Update successfully'));
  }
}
