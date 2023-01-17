import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../delivery/deliveryPage.dart';
import '../delivery/road.dart';

class OrderStatusPage extends StatefulWidget {
  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  CollectionReference orders = FirebaseFirestore.instance.collection("Order");
  late Future<QuerySnapshot> _orderList;
  List<Map> historyList = [];
  var productList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _orderList = orders.get();
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

  String status = "";

  String getOrderStatus() {
    if (historyList.length != 0) {
      List.generate(historyList.length, (index) {
        status = historyList[0]['status'].toString();
      });
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
            (getOrderStatus() == "In Progress") ? DeliveryPage() : RoadPage());
  }
}
