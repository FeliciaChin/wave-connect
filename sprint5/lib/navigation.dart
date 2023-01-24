import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Couch_Potato/Page/rating/rating_page.dart';
import 'package:Couch_Potato/login.dart';
import 'package:Couch_Potato/main.dart';
import 'home_screen.dart';
import 'package:flutter/material.dart';
import 'Page/product_page.dart';
import 'Page/profile_page.dart';
import 'Page/cart_page.dart';
import 'Page/logOut_page.dart';
import 'Page/orderHistory.dart';
import 'Page/delivery.dart';

class NavBar extends StatelessWidget {
  String myName = "";
  String myEmail = "";

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'Couch Potato',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              'Shop anywhere and anytime',
              style: TextStyle(fontSize: 15),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/couchpotato_logo.png",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.person,
              size: 40,
            ),
            title: Text(
              'Profile Page',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => ProfilePage()))),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              size: 40,
            ),
            title: Text(
              'Product Page',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => ProductPage()))),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: 40,
            ),
            title: Text(
              'My Cart',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => CartPage()))),
          ),
          ListTile(
            leading: Icon(
              Icons.motorcycle,
              size: 40,
            ),
            title: Text(
              'Delivery Page',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: ((context) => MainDeliveryPage()))),
          ),
          ListTile(
            leading: Icon(
              Icons.star,
              size: 40,
            ),
            title: Text(
              'Rating',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => RatingPage())),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.history,
              size: 40,
            ),
            title: Text(
              'Order History',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => HistoryPage())),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.lock,
              size: 40,
            ),
            title: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: ((context) => HomePage())),
            ),
          ),
        ],
      ),
    );
  }
}
