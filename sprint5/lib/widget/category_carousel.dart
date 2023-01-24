import 'package:flutter/material.dart';
import '../Page/models/category_model.dart';
import 'widget.dart';

class CategoryCarousel extends StatelessWidget {
  final List<Category> categories;

  const CategoryCarousel({
    Key? key,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        height: 120,
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.0),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: CategoryCard(category: categories[index]),
            );
          },
        ),
      ),
    );
  }
}
