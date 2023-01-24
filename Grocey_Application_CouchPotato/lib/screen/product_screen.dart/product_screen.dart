import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Couch_Potato/Page/models/category_model.dart';
import 'package:Couch_Potato/widget/product_card.dart';
import '../../Page/models/product_models.dart';
import '../../home_screen.dart';
import '../../Page/models/models.dart';
import '../../widget/widget.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => ProductScreen(category: category),
    );
  }

  final Category category;

  const ProductScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    // Product.clearProductList();
    // Product.getProduct();
    List<Product> categoryProducts = Product.products
        .where((product) => product.category == category.name)
        .toList();

    print("category list: ${categoryProducts.length}");
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.lightGreenAccent,
          centerTitle: true,
          title: Text(
            category.name,
            style:
                TextStyle(fontSize: 20, letterSpacing: 1, color: Colors.black),
          ),
          actions: [
            IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                onPressed: () {})
          ],
        ),
        body: GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1.15),
            itemCount: categoryProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Center(
                child: ProductCard(
                  index: index,
                  product: categoryProducts[index],
                  widthFactor: 2.2,
                ),
              );
            }));
  }
}
