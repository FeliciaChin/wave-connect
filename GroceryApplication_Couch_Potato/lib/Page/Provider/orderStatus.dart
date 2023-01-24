import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../delivery/deliveryPage.dart';
import '../delivery/road.dart';
import '../Provider/orderLength.dart';
import 'package:get/get.dart';

class OrderStatusPage extends StatefulWidget {
  @override
  _OrderStatusPageState createState() => _OrderStatusPageState();
}

class _OrderStatusPageState extends State<OrderStatusPage> {
  final orderId = Get.put(OrderLength());

  CollectionReference orders = FirebaseFirestore.instance.collection("Order");
  final documentReferences = FirebaseFirestore.instance.collection('Order');

  late Future<QuerySnapshot> _orderList;
  List<Map> historyList = [];
  var productList = [];
  var documentId = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderID();
    _orderList = orders.get();
    _orderList.then((value) {
      setState(() {
        historyList = parseData(value);
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

  String status = "";

  String getOrderStatus() {
    if (historyList.length != 0) {
      List.generate(historyList.length, (index) {
        if (orderId.id == documentId.elementAt(index)) {
          status = historyList[index]['status'].toString();
        }
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
