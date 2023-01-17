import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Product extends Equatable {
  // final String productID;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final String category;

  const Product({
    // required this.productID,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.category,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        //productID,
        name, description, imageUrl, price, category
      ];

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
        //productID: snap['productID'],
        name: snap['name'],
        description: snap['description'],
        imageUrl: snap['imageUrl'],
        price: snap['price'],
        category: snap['category']);

    return product;
  }

  static List<Product> products = [
    Product(
      name: "Oreo Ice Cream Stick",
      description:
          'Weight: 110ml\nExpired Date: 22 December 2022\nCalories: 219',
      imageUrl:
          'https://cdn.shopify.com/s/files/1/0422/4794/6401/products/133126-1-1_802758d8-0a47-4ccf-a564-0b61a202d0c0_800x.jpg?v=1658748896',
      price: 5.80,
      category: 'Frozen Food',
    ),
    Product(
      name: "Walls Maxi Top Ten Vanilla",
      description:
          'Weight: 73ml\nExpired Date: 22 December 2022\nCalories: 209',
      imageUrl:
          'https://d1sag4ddilekf6.azureedge.net/compressed_webp/items/MYITE20210827065421019515/detail/5d7bf3a7_VANILLA73ML.webp',
      price: 2.80,
      category: 'Frozen Food',
    ),
    Product(
      name: "Labour Liquid Dishwash Lime ",
      description: 'Weight: 900ml',
      imageUrl:
          'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/1571890590114-9556046531035%20Labour%20Liquid%20Dishwash%20Lime%20900ml.jpeg',
      price: 6.60,
      category: 'Cleaning Products',
    ),
    Product(
      name: "Febreze Ambi Pur Fabric Refreshener",
      description: 'Weight: 800ml',
      imageUrl:
          'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/300X300/1629440268086-extra%20str.jfif.png',
      price: 21.80,
      category: 'Cleaning Products',
    ),
    Product(
      name: "Fanta Strawberry",
      description:
          'Weight: 1.5L\nExpired Date: 22 December 2022\nCalories: 300',
      imageUrl:
          'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/1576562860766-1568987289066-9555589200903%20-%20Fanta%20Strawberry%201.5L.png',
      price: 3.50,
      category: 'Drinks',
    ),
    Product(
      name: "Spritzer Mineral Water Bottle",
      description:
          'Weight: 6L\nExpired Date: 22 December 2023\nCalories: 0\nNatural Mineral Water',
      imageUrl:
          'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/9556135670959.jpg',
      price: 11.90,
      category: 'Drinks',
    ),
    Product(
      name: "Nestlé Fitnesse Cereal Original 375g",
      description:
          'Weight: 375g\nExpired Date: 22 December 2023\nCalories: 206\nWhole Grain',
      imageUrl:
          'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/1596015732992-fitness_.jpeg',
      price: 15.90,
      category: 'Groceries',
    ),
    Product(
      name: "Wonderful Classic Roasted Salted Almonds",
      description:
          'Weight: 168g\nExpired Date: 22 December 2023\nCalories: 167',
      imageUrl:
          'https://mygroser.s3.ap-southeast-1.amazonaws.com/productImages/1000X1000/1597309219386-alm_w.jpeg',
      price: 25.50,
      category: 'Groceries',
    ),
    Product(
      name: "ACRYLIC LEAFLET HOLDER (A4) STZ-51000",
      description:
          'Size: 225mm(H)X234mm(L)X83mm(W)\nPacking quantity= 2pcs/Box',
      imageUrl:
          'https://store.gsstationery.com/image/cjtee/image/cache/data/all_product_images/product-248/STZ51000%20A4-420x420.jpg',
      price: 88.00,
      category: 'Stationary',
    ),
    Product(
      name: "FABER CASTELL BP CX PLUS PEN",
      description: 'Size: 0.5mm\nPacking quantity= 25pcs/ BOX',
      imageUrl:
          'https://store.gsstationery.com/image/cjtee/image/cache/data/all_product_images/product-1024/FABER%20CASTELL%20CX%20PLUS%20BALL%20PEN%200.5MM-420x420.jpg',
      price: 1.50,
      category: 'Stationary',
    ),
  ];

  // static Future getProduct() async {
  // CollectionReference _collectionRef =
  // FirebaseFirestore.instance.collection('products');
  // QuerySnapshot querySnapshot = await _collectionRef.get();
  // for (int i = 0; i < querySnapshot.docs.length; i++) {
  // products.add(Product(
  // productID: querySnapshot.docs[i].id,
  // name: querySnapshot.docs[i]["name"],
  // category: querySnapshot.docs[i]["category"],
  // price: querySnapshot.docs[i]['price'].toDouble(),
  // imageUrl: querySnapshot.docs[i]['imageUrl'],
  // description: querySnapshot.docs[i]['description']));
  // }
  // print(products.length);
  // }
//
  // static clearProductList() {
  // products.clear();
  // }

  remove(Product product) {}
}
