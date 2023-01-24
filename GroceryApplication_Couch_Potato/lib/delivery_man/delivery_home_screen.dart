import 'package:flutter/material.dart';
import 'Page/delivery_profile_page.dart';
import 'Page/Oder_List.dart';

/*

*/
class DeliveryHomeScreen extends StatefulWidget {
  const DeliveryHomeScreen({super.key});

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => DeliveryHomeScreen());
  }

  @override
  State<DeliveryHomeScreen> createState() => _DeliveryHomeScreenState();
}

class _DeliveryHomeScreenState extends State<DeliveryHomeScreen> {
  int currentIndex = 0;
  final screens = [
    DeliveryOrderList(),
    DeliveryProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
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
              icon: Icon(Icons.list),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
}
