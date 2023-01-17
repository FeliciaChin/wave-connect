import 'package:flutter/material.dart';
import '../product_page.dart';

class CartEmptyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.fromLTRB(150, 60, 150, 60),
        width: MediaQuery.of(context).size.width * 0.36,
        height: MediaQuery.of(context).size.height * 0.12,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/cart_icon.jpg'),
            )),
      ),
      Text(
        'Your Cart is Empty',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
      SizedBox(height: 50),
      Text(
        'Look like you haven\'t \n add any item to your cart yet',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.blueGrey,
          fontSize: 26,
          fontWeight: FontWeight.w400,
        ),
      ),
      SizedBox(height: 50),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightGreenAccent,
          side: BorderSide(color: Colors.lightGreenAccent, width: 1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          minimumSize: Size(60, 50),
          textStyle: const TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
        onPressed: () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => ProductPage())),
        child: const Text('Shop Now'),
      )
    ]);
  }
}
