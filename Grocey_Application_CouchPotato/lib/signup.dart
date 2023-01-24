import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Couch_Potato/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  Future<bool> signUp() async {
    try {
      if (passwordConfirm()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            )
            .then((result) => addUserDetails(
                  result.user,
                  _usernameController.text.trim(),
                  _phoneController.text.trim(),
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                ));
        return true;
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(
                  'Sign up Failure',
                  style: TextStyle(color: Colors.red),
                ),
                content: Text('Password did not match. Please try again.'),
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
        return false;
      }
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Sign up Failure',
                style: TextStyle(color: Colors.red),
              ),
              content: Text(e.message.toString()),
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
      return false;
    }
    //create user
  }

  Future addUserDetails(User? user, String userName, String userPhone,
      String email, String password) async {
    await FirebaseFirestore.instance.collection('User').doc(user?.uid).set({
      'userName': userName,
      'userPhone': userPhone,
      'userPassword': password,
      'userEmail': email,
      'userAddress': "",
    }).then((result) {
      print("Success!");
    }).catchError((error) {
      print("Error!");
    });
  }

  bool passwordConfirm() {
    if (_passwordController.text.trim() ==
        _confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Sign Up',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.lightGreenAccent,
        body: Center(
            child: SingleChildScrollView(
                child: Column(children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              height: 150.0,
              width: 150.0,
              // Logo
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.black),
                  borderRadius: BorderRadius.circular(20.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  "./assets/images/couchpotato_logo.png",
                  fit: BoxFit.cover,
                ),
              )),
          Container(
              width: 400,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  //username
                  TextField(
                    controller: _usernameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      hintText: 'Your Name',
                      prefixIcon: Icon(Icons.person, color: Colors.orange),
                    ),
                  ),
                  //password textfield + view password
                  TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        hintText: 'At least 6 characters.',
                        prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      )),
                  //confirm password textfield + view password
                  TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Need to same as password entered.',
                        prefixIcon: Icon(Icons.lock, color: Colors.orange),
                      )),
                  //email
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'example@mail.com',
                      prefixIcon: Icon(Icons.mail, color: Colors.orange),
                    ),
                  ),
                  //Phone number
                  TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    maxLength: 11,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                      hintText: '012xxxxxxx',
                      prefixIcon: Icon(Icons.phone, color: Colors.orange),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  //sign up button
                  Container(
                    width: double.infinity,
                    child: RawMaterialButton(
                      fillColor: const Color(0xFFFFB74D),
                      elevation: 0.0,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () => signUp().then((value) {
                        if (value) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text(
                                    'Sign up Successfully',
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  content: const Text(
                                      'You are sucessfully sign up an account. Click "OK" to login now!'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              }).then((value) => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              ));
                        }
                      }),
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()),
                              );
                            },
                            child: Text(
                              'Already have an account',
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontStyle: FontStyle.italic),
                            ),
                          ),
                        ]),
                  ),
                ],
              )),
        ]))));
  }
}
