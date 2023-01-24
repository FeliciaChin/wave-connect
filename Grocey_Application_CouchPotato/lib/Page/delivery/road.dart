import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:im_stepper/stepper.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import 'package:Couch_Potato/Page/orderCollect.dart';
import 'package:Couch_Potato/services/delivery_constant.dart';
import '../../navigation.dart';
import '../notification/notificationRoad.dart';
import '../orderCancel.dart';
import '../Provider/orderLength.dart';
import 'package:get/get.dart';

class RoadPage extends StatefulWidget {
  @override
  _RoadPageState createState() => _RoadPageState();
}

class _RoadPageState extends State<RoadPage> {
  final OrderLength oL = Get.find();
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

  String id = "";

  String getDeleteID() {
    if (documentId.isNotEmpty) {
      List.generate(historyList.length, (index) {
        if (orderId.id == documentId.elementAt(index)) {
          id = orderId.id;
        }
      });
    }
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        title: Text(
          'Delivery',
          style: TextStyle(fontSize: 30, letterSpacing: 1, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: Stack(children: [
              Icon(
                Icons.notifications,
                size: 35,
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 15,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.deepOrangeAccent),
                  child: Center(
                    child: Text(
                      "1",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
              )
            ]),
            onPressed: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (context) => NotificationRoadPage())),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16),
              child: Text(
                  DateFormat('yyyy-MM-dd KK:mm:ss a').format(DateTime.now()),
                  style: GoogleFonts.comicNeue(
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 16),
              child: Text("Order ID: #12345",
                  style: GoogleFonts.comicNeue(
                    textStyle:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Text("Orders",
                  style: GoogleFonts.coda(
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  )),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: MediaQuery.of(context).size.height / 4,
                  width: MediaQuery.of(context).size.width / 6,
                  child: IconStepper(
                    direction: Axis.vertical,
                    enableNextPreviousButtons: false,
                    enableStepTapping: false,
                    stepColor: Colors.green,
                    activeStepBorderColor: Colors.blue,
                    activeStepBorderWidth: 0,
                    activeStepBorderPadding: 0,
                    lineColor: Colors.green,
                    lineLength: 70,
                    lineDotRadius: 2,
                    stepRadius: 16,
                    icons: [
                      Icon(
                        Icons.check,
                      ),
                      Icon(
                        Icons.check,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(2),
                    itemCount: trackOrderList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(top: 10),
                            width: MediaQuery.of(context).size.width / 1.5,
                            child: ListTile(
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 16),
                              leading: Icon(
                                trackOrderList[index].icon,
                                size: 40,
                                color: Colors.orangeAccent,
                              ),
                              title: Text(trackOrderList[index].title,
                                  style: GoogleFonts.comicNeue(
                                    textStyle: TextStyle(
                                      fontSize: 25,
                                    ),
                                  )),
                              subtitle: Text(
                                trackOrderList[index].subtitle,
                                style: GoogleFonts.comicNeue(
                                  textStyle: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightGreenAccent,
                        side: BorderSide(
                            color: Colors.lightGreenAccent, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        minimumSize: Size(60, 50),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        oL.deleteOrder(1);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => orderCollectedPage()));
                      },
                      child: const Text('Confirm Order'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.lightGreenAccent,
                        side: BorderSide(
                            color: Colors.lightGreenAccent, width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        minimumSize: Size(60, 50),
                        textStyle: const TextStyle(
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        oL.deleteOrder(1);
                        getOrderID();
                        _delete(getDeleteID());
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => orderCancelPage()));
                      },
                      child: const Text('Cancel Order'),
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    """If you are not received any order, 
please contact us at:
Ms Alis: 017-000 9999
Email: couchPotato@gmail.com""",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

_delete(String id) async {
  await FirebaseFirestore.instance.collection('Order').doc(id).delete();
}
