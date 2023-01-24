import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'package:Couch_Potato/Page/Provider/order_controller.dart';
import '../../Page/delivery.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import 'creditcard.dart';
import '../Provider/orderLength.dart';

class PaymentMethod extends StatefulWidget {
  final String price;
  const PaymentMethod(this.price);

  @override
  State<PaymentMethod> createState() => _PaymentMethod();
}

class _PaymentMethod extends State<PaymentMethod> {
  List<String> paymentMethods = [
    'Cash On Delivery (COD)',
    'Credit Card / Debit Card',
  ];
  String dropdownValue = 'Cash On Delivery (COD)';

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Payment Method',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 0,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (String? value) {
                      // This is called when the user selects an item.
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: paymentMethods
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            //change it
            FutureBuilder(
                future: _GetAddress(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return Text('Loading data...Pleas');
                  } else {
                    return Container(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16),
                        child: _PaymentMethodDetail(
                            dropdownValue, widget.price, context),
                      ),
                    );
                  }
                }),
          ],
        ));
  }
}

String address = "Address not found.";
_GetAddress() async {
  final firebaseUser = FirebaseAuth.instance.currentUser;
  if (firebaseUser != null) {
    await FirebaseFirestore.instance
        .collection('User')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      address = ds.data()!["userAddress"];
    });
  }
}

_PaymentMethodDetail(paymentMethod, price, context) {
  if (paymentMethod == "Credit Card / Debit Card") return CreditCardPage(price);

  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text(
            "You have selected Cash on Delivery.",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
          ),
        ),
        ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/5229/5229335.png',
                width: 200,
                height: 200, loadingBuilder: (BuildContext context,
                    Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            })),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 50, 0, 10),
          child: Text(
            "Please confirm your delivery address.",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        Text(
          address,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.orangeAccent,
            ),
            onPressed: () async {
              OrderController orderController = new OrderController();
              orderController.addOrder("Cash on delivery (COD)");
              showDialog(
                  context: context,
                  builder: (context) {
                    final OrderLength oL = Get.find();
                    return AlertDialog(
                        backgroundColor: Color(0xff1b447b),
                        insetPadding: EdgeInsets.all(10),
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        title: Text("Order Received",
                            style: TextStyle(
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 255, 255))),
                        content: Text(
                          "Thanks for choosing us!\nYou may track the order.",
                          style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        actions: [
                          TextButton(
                              child: Text(
                                "OK",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              onPressed: () {
                                // Navigator.of(context).pop();
                                oL.addOrder(1);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            MainDeliveryPage()));
                              }),
                        ]);
                  });
              // Navigator.of(context).pushReplacement(
              // MaterialPageRoute(builder: (context) => MainDeliveryPage()));
            },
            child: Text(
              'Pay RM ${price}',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.all(10),
              backgroundColor: Colors.grey,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ])
      ],
    ),
  );
}
