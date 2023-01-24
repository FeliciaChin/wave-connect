import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/orderLength.dart';
import 'delivery/empty_delivery_page.dart';
import 'delivery/deliveryPage.dart';
import 'Provider/orderStatus.dart';
import '../navigation.dart';

class MainDeliveryPage extends StatefulWidget {
  @override
  _MainDeliveryPageState createState() => _MainDeliveryPageState();
}

class _MainDeliveryPageState extends State<MainDeliveryPage> {
  final oLength = Get.put(OrderLength());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        body: oLength.total == 0 ? EmptyDeliveryPage() : OrderStatusPage()));
  }
}
