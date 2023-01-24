import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'package:Couch_Potato/Page/cart/cart_total.dart';
import 'package:Couch_Potato/Page/models/models.dart';

/*
  showing the list of products that has been added
  to the cart.
*/
class CartProducts extends StatelessWidget {
  final CartProvider controller = Get.find();
  CartProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (BuildContext context, int index) {
              return CartProductCard(
                controller: controller,
                product: controller.products.keys.toList()[index],
                quantity: controller.products.values.toList()[index],
                index: index,
              );
            },
          ),
        ));
  }
}

// Display the details of each products (image, name, quantity)
class CartProductCard extends StatelessWidget {
  final CartProvider controller;
  final Product product;
  final int quantity;
  final index;
  const CartProductCard({
    Key? key,
    required this.controller,
    required this.product,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage: NetworkImage(
              product.imageUrl,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(child: Text(product.name)),
          Expanded(
              child: Text(
            'RM ${controller.productSubtotal[index].toStringAsFixed(2)}',
            textAlign: TextAlign.right,
          )),
          IconButton(
              onPressed: () {
                controller.removeProduct(product);
              },
              icon: Icon(Icons.remove_circle)),
          Text('${quantity}'),
          IconButton(
              onPressed: () {
                controller.addProduct(product);
              },
              icon: Icon(Icons.add_circle)),
        ],
      ),
    );
  }
}
