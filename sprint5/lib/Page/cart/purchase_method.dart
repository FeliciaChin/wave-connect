import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'package:Couch_Potato/Page/cart_page.dart';

class PurchaseMethod extends StatefulWidget {
  const PurchaseMethod({super.key});

  @override
  State<PurchaseMethod> createState() => _PurchaseMethod();
}

class _PurchaseMethod extends State<PurchaseMethod> {
  CartProvider controller = Get.find();
  List<String> purchaseMethods = ['Delivery', 'Pick up'];
  String dropdownValue = 'Delivery';
  String destinationAddress = 'Unknown';
  String methodTitle = 'Unknown';
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  _purchaseMethod_Detail() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null && dropdownValue == 'Delivery') {
      methodTitle = 'Delivery to:';
      await FirebaseFirestore.instance
          .collection('User')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        destinationAddress = ds.data()!["userAddress"];
      }).catchError((e) {
        destinationAddress = "Unknown";
      });
    } else {
      destinationAddress = 'No.23, Jln Tkd, Tmn, 80990 Skudai, Johor';
      methodTitle = 'Pick up at: ';
    }

    controller.setDeliveryAddress = methodTitle + destinationAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.black,
                ),
                onChanged: (String? value) {
                  // This is called when the user selects an item.
                  setState(() {
                    dropdownValue = value!;
                  });
                  controller.changePurchaseMethod(dropdownValue);
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => CartPage()),
                  //   (Route<dynamic> route) => false,
                  // );
                },
                items: purchaseMethods
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Column(
              children: [
                FutureBuilder(
                  future: _purchaseMethod_Detail(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState != ConnectionState.done) {
                      return Text('Loading data...Please wait');
                    } else {
                      return Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            methodTitle,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(destinationAddress),
                        ],
                      ));
                    }
                  },
                )
              ],
            )
          ],
        ));
  }
}
