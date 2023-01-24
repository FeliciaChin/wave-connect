import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Page/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  const CategoryCard({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product',
          arguments: category,
        );
      },
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 3),
            width: MediaQuery.of(context).size.width / 2.5,
            height: 120,
            child: Image.network(
              category.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 70,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: 60,
              color: Color.fromARGB(255, 221, 229, 232),
            ),
          ),
          Positioned(
            top: 70,
            left: 15,
            child: Container(
              width: MediaQuery.of(context).size.width / 2.5 - 10,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                    width: 4, color: Color.fromARGB(255, 21, 146, 7)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.name,
                            style: GoogleFonts.raleway(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                      color: Colors.black,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
