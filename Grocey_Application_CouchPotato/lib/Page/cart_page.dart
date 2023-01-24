import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'package:Couch_Potato/Page/cart/cart_products.dart';
import 'package:Couch_Potato/Page/cart/empty_cart.dart';
import 'package:Couch_Potato/Page/models/cart_model.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import '../navigation.dart';
import 'cart/cart_total.dart';
import 'cart/payment_method.dart';
import 'cart/purchase_method.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final controller = Get.put(CartProvider());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        drawer: NavBar(),
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
        body: controller.products.length == 0
            ? CartEmptyPage()
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  PurchaseMethod(),
                  CartTotal(),
                  CartProducts(),
                ]))));
  }
}
