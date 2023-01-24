import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import '../Provider/orderLength.dart';

class OrderController {
  CartProvider cartProvider = Get.find();
  OrderLength oL = Get.find();

  void addOrder(String payMethod) async {
    String status = "In Progress";

    List products = [];
    for (int i = 0; i < cartProvider.products.length; i++) {
      var productMap = {
        "product": cartProvider.products.keys.toList()[i].name,
        "quantity": cartProvider.products.values.toList()[i]
      };
      products.add(productMap);
    }
    String jsonData = jsonEncode(products);

    String userName = "Undefined";
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        userName = ds.data()!["userName"];
      }).catchError((e) {});
    }

    var orderCollection = FirebaseFirestore.instance.collection('Order');
    var docRef = await orderCollection.add({
      "deliveryAddress": cartProvider.deliveryAddress,
      "name": userName,
      "paymentMethod": payMethod,
      "price": cartProvider.total,
      "productList": jsonData,
      "status": status
    });
    var documentId = docRef.id;
    oL.getOrderDocumentId(documentId);
    Get.delete<CartProvider>();
  }
}
