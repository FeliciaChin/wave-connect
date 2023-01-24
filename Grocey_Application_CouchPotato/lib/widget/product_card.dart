import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'package:Couch_Potato/Page/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final int index;
  ProductCard(
      {Key? key,
      required this.index,
      required this.product,
      this.widthFactor = 2.5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double widthValue = MediaQuery.of(context).size.width / widthFactor;
    // final cartController = Get.put(CartProvider());
    final cartController = Get.put(CartProvider());
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            height: 200,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.fitHeight,
            ),
          ),
          Positioned(
            top: 115,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.withAlpha(50),
              ),
            ),
          ),
          Container(
            child: Positioned(
              top: 120,
              left: 5,
              child: Container(
                width: MediaQuery.of(context).size.width / 2.5 - 10,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.name,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepOrangeAccent,
                                    letterSpacing: 1,
                                    height: 1.1),
                              ),
                              Text(
                                product.description,
                                style: TextStyle(fontSize: 14, height: 1.4),
                              ),
                              Text(
                                'RM ${product.price}0',
                                style: TextStyle(
                                    fontSize: 14,
                                    height: 1.4,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                              TextButton(
                                  onPressed: () {
                                    cartController.addProduct(product);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll<Color>(
                                            Colors.orangeAccent),
                                  ),
                                  child: Text('Add To Cart',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1,
                                          height: 1.1))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
