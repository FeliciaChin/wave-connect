import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:Couch_Potato/signup.dart';
import 'delivery_home_screen.dart';
import 'delivery_forget_password.dart';
import 'delivery_signup.dart';
import '../login.dart';

class DeliveryLogIn extends StatefulWidget {
  const DeliveryLogIn({super.key});

  @override
  State<DeliveryLogIn> createState() => _DeliveryLogInState();
}

class _DeliveryLogInState extends State<DeliveryLogIn> {
//initialize firebaseApp
  Future<FirebaseApp> _initializerFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => DeliveryLogIn(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Man Log In',
            style: TextStyle(
                color: Colors.black,
                fontSize: 28.0,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 4.0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_active),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DeliveryHomeScreen()),
              );
            },
            color: Colors.orange,
            iconSize: 40,
          )
        ],
        leading: Icon(
          Icons.dehaze,
          color: Colors.black,
        ),
      ),
      body: FutureBuilder(
        future: _initializerFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return DeliveryLoginScreen();
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      backgroundColor: Colors.lightGreenAccent,
    );
  }
}

class DeliveryLoginScreen extends StatefulWidget {
  const DeliveryLoginScreen({super.key});

  @override
  State<DeliveryLoginScreen> createState() => _DeliveryLoginScreenState();
}

class _DeliveryLoginScreenState extends State<DeliveryLoginScreen> {
  //login function
  static Future<User?> loginUsingEmailPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text(
                'Login Failed',
                style: TextStyle(color: Colors.red),
              ),
              content: Text('Invalid email or password.'),
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
    }

    return user;
  }

  @override
  Widget build(BuildContext context) {
    //create the textfilled controller
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10.0),
            Container(
                height: 180.0,
                width: 200.0,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(20.0)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    "assets/images/couchpotato_logo.png",
                    fit: BoxFit.cover,
                  ),
                )),
            const SizedBox(height: 50.0),
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.0),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: _emailController,
                      obscureText: false,
                      decoration: InputDecoration(
                        hintText: 'Email Address',
                        suffixIcon: const Icon(Icons.email_outlined,
                            color: Colors.orange),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                    width: 250,
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Your Password',
                        suffixIcon: const Icon(FontAwesomeIcons.eyeSlash,
                            color: Colors.orange),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60.0),
                  Container(
                    width: 250,
                    child: RawMaterialButton(
                      fillColor: Colors.orange,
                      elevation: 10.0,
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0)),
                      onPressed: () async {
                        User? user = await loginUsingEmailPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                            context: context);
                        print(user);
                        if (user != null) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => DeliveryHomeScreen()));
                        }
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    child: Text(
                      'Forget Password',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPassword()),
                      );
                    },
                  ),
                  GestureDetector(
                    child: Text(
                      'Sign up an account',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 16.0,
                          fontStyle: FontStyle.italic),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeliverySignupPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            Container(
              child: GestureDetector(
                child: Text(
                  'Back to User Login',
                  style: TextStyle(
                      color: Colors.orange,
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
