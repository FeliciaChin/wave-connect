import 'dart:async';
import '../delivery_login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import '../delivery_login.dart';
import '../delivery_home_screen.dart';

class DeliveryProfilePage extends StatefulWidget {
  @override
  _DeliveryProfilePageState createState() => _DeliveryProfilePageState();
}

class _DeliveryProfilePageState extends State<DeliveryProfilePage> {
  //text controller
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _platNumberController = TextEditingController();
  final _phoneController = TextEditingController();
  final _vehiclesController = TextEditingController();

  String myEmail = "";
  String myName = "";
  String myPlatNumber = "";
  String myPhone = "";
  String myVehicles = "";

  String updName = "";
  String updPhone = "";
  String updPlatNumber = "";
  String updVehicle = "";

  bool isObscurePassword = true;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _platNumberController.dispose();
    _phoneController.dispose();
    _vehiclesController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        //drawer: NavBar(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            'My Profile',
            style:
                TextStyle(fontSize: 30, letterSpacing: 1, color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {})
          ],
        ),
        body: Center(
          child: FutureBuilder(
            future: _fetch(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Text('Loading data...Please wait');
              } else {
                return Container(
                  padding: EdgeInsets.only(left: 15, top: 20, right: 15),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      children: [
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4, color: Colors.white),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://media.istockphoto.com/id/1300845620/vector/user-icon-flat-isolated-on-white-background-user-symbol-vector-illustration.jpg?s=612x612&w=0&k=20&c=yBeyba0hUkh14_jgv1OKqIH0CCSWU_4ckRkAoy2p73o='))),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\nRegister Email:',
                          style: TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          '$myEmail',
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.deepOrangeAccent,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 35),
                        buildTextField(_nameController, "Full Name",
                            _nameController.text = "$myName", false),
                        buildTextField(_phoneController, "Phone Number",
                            _phoneController.text = "$myPhone", false),
                        buildTextField(
                            _platNumberController,
                            "Plat Number",
                            _platNumberController.text = "$myPlatNumber",
                            false),
                        buildTextField(_vehiclesController, "Vehicle",
                            _vehiclesController.text = "$myVehicles", false),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () => DeliveryProfilePage(),
                              child: Text("CANCEL",
                                  style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 2,
                                      color: Colors.black)),
                              style: OutlinedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                updName = _nameController.text;
                                updPhone = _phoneController.text;
                                updPlatNumber = _platNumberController.text;
                                updVehicle = _vehiclesController.text;
                                _updateData(updName, updPhone, updPlatNumber,
                                    updVehicle);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DeliveryProfilePage()),
                                );
                              },
                              child: Text('SAVE',
                                  style: TextStyle(
                                      fontSize: 10,
                                      letterSpacing: 2,
                                      color: Colors.white)),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepOrangeAccent,
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeliveryLogIn()),
                            );
                          },
                          child: Text('Log Out',
                              style: TextStyle(
                                  fontSize: 18,
                                  letterSpacing: 2,
                                  color: Color.fromARGB(255, 20, 19, 19))),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Color.fromARGB(255, 240, 240, 60),
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                      ],
                    ),
                  ),
                );
              }

              //
            },
          ),
        ));
  }

  _fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('deliveryMan')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.data()!["deliveryEmail"];
        myName = ds.data()!["deliveryName"];
        myPlatNumber = ds.data()!["deliveryPlatNumber"];
        myPhone = ds.data()!['deliveryPhone'];
        myVehicles = ds.data()!['deliveryVehicles'];
      }).catchError((e) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Retrieve data Failure',
                  style: TextStyle(color: Colors.red),
                ),
                content: Text(e.toString()),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
      });
    }
  }

  Future _updateData(String updateName, String updatePhone,
      String updatePlatNumber, String updateVehicle) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      if (myName != updateName) {
        await FirebaseFirestore.instance
            .collection('deliveryMan')
            .doc(firebaseUser.uid)
            .update({
          'deliveryName': updateName,
        }).then((result) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Update Username Successfully',
                      style: TextStyle(color: Color.fromARGB(255, 63, 232, 63)),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }));
      }
      if (myPhone != updatePhone) {
        await FirebaseFirestore.instance
            .collection('deliveryMan')
            .doc(firebaseUser.uid)
            .update({
          'deliveryPhone': updatePhone,
        }).then((result) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Update Phone Number Successfully',
                      style: TextStyle(color: Color.fromARGB(255, 63, 232, 63)),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }));
      }
      if (myPlatNumber != updatePlatNumber) {
        await FirebaseFirestore.instance
            .collection('deliveryMan')
            .doc(firebaseUser.uid)
            .update({
          'deliveryPlatNumber': updatePlatNumber,
        }).then((result) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Update Plat Number Successfully',
                      style: TextStyle(color: Color.fromARGB(255, 63, 232, 63)),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }));
      }
      if (myVehicles != updateVehicle) {
        await FirebaseFirestore.instance
            .collection('deliveryMan')
            .doc(firebaseUser.uid)
            .update({
          'deliveryVehicles': updateVehicle,
        }).then((result) => showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      'Update Vehicle Types Successfully',
                      style: TextStyle(color: Color.fromARGB(255, 63, 232, 63)),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                }));
      }
    }
  }

  Widget buildTextField(TextEditingController controls, String labelText,
      String placeholder, bool isPasswordTextField) {
    var isObscurePassword;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controls,
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye, color: Colors.grey),
                    onPressed: () {},
                  )
                : null,
            contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrangeAccent,
            )),
      ),
    );
  }
}
