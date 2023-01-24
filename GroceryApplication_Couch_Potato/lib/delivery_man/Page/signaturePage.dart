import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:signature/signature.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../delivery_home_screen.dart';

class SignaturePage extends StatefulWidget {
  String orderID;
  SignaturePage(this.orderID, {Key? key}) : super(key: key);

  @override
  _SignaturePage createState() => _SignaturePage();
}

class _SignaturePage extends State<SignaturePage> {
  Uint8List? exportedImage;

  SignatureController _signatureController = SignatureController(
    penStrokeWidth: 3.5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

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
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'Signature',
            style:
                TextStyle(fontSize: 30, letterSpacing: 1, color: Colors.black),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DeliveryHomeScreen())),
          ),
        ),
        body: orderList.length == 0
            ? Center(
                child: const Text(
                'No items found',
                style: TextStyle(fontSize: 50),
              ))
            : Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Signature(
                        controller: _signatureController,
                        width: 300,
                        height: 350,
                        backgroundColor: Colors.lightGreenAccent),
                    SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                                onPressed: () async {
                                  List.generate(orderList.length, (index) {
                                    if (widget.orderID ==
                                        documentId.elementAt(index)) {
                                      _updateData("Completed",
                                          documentId.elementAt(index));
                                    }
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DeliveryHomeScreen()));
                                },
                                child: const Text(
                                  "Save",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.red)))))),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: ElevatedButton(
                                onPressed: () {
                                  _signatureController.clear();
                                },
                                child: const Text(
                                  "Clear",
                                  style: TextStyle(fontSize: 20),
                                ),
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.blue),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            side: BorderSide(
                                                color: Colors.red)))))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (exportedImage != null)
                      Image.memory(
                        exportedImage!,
                        width: 300,
                        height: 250,
                      )
                  ],
                ),
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
