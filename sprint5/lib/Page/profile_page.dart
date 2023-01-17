import 'dart:async';

import '../main.dart';
import '../login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import '../login.dart';
import '../navigation.dart';
import '../home_screen.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //text controller
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();

  String myEmail = "";
  String myName = "";
  String myAddress = "";
  String myPhone = "";

  bool isObscurePassword = true;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavBar(),
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
                        buildTextField(
                            _nameController, "Full Name", "$myName", false),
                        buildTextField(_phoneController, "Phone Number",
                            "$myPhone", false),
                        buildTextField(
                            _addressController, "Address", "$myAddress", false),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            OutlinedButton(
                              onPressed: () => ProfilePage(),
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
                                var updName = _nameController.text;
                                var updPhone = _phoneController.text;
                                var updAddress = _addressController.text;

                                _updateData(updName, updPhone, updAddress);
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
                            )
                          ],
                        )
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
          .collection('User')
          .doc(firebaseUser.uid)
          .get()
          .then((ds) {
        myEmail = ds.data()!["userEmail"];
        myName = ds.data()!["userName"];
        myAddress = ds.data()!["userAddress"];
        myPhone = ds.data()!['userPhone'];
      }).catchError((e) {
        print(e);
      });
    }
  }

  Future _updateData(
      String updateName, String updatePhone, String updateAddress) async {
    final firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(firebaseUser.uid)
          .update({
        'userName': updateName,
        'userPhone': updatePhone,
        'userAddress': updateAddress,
      }).then((result) => print('Added successfully'));
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
