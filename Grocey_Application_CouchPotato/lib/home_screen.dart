import 'package:flutter/material.dart';
import 'navigation.dart';
import 'Page/cart_page.dart';
import 'Page/delivery.dart';
import 'Page/profile_page.dart';
import 'Page/product_page.dart';
import 'Page/rating/rating_page.dart';

/*

*/
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screens = [
    ProductPage(),
    CartPage(),
    MainDeliveryPage(),
    ProfilePage(),
    RatingPage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavBar(),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lightGreenAccent,
          selectedItemColor: Colors.deepOrangeAccent,
          iconSize: 30,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Product',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.motorcycle),
              label: 'Delivery',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: 'Rating',
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
}
