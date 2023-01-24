import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Couch_Potato/Page/models/models.dart';
import '../blocs/blocs.dart';
import '../navigation.dart';
import '../widget/widget.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: NavBar(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
        title: Text(
          'Couch Potato',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 1,
            color: Colors.black,
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<AdvertisementBloc, advertisementState>(
              builder: (context, state) {
                if (state is advertisementLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is advertisementLoaded) {
                  return CarouselSlider(
                    options: CarouselOptions(
                      aspectRatio: 1.5,
                      viewportFraction: 0.9,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      autoPlay: true,
                    ),
                    items: state.advertisement
                        .map((advertisement) =>
                            AdvCard(advertisement: advertisement))
                        .toList(),
                  );
                } else {
                  return Text('Something went wrong.');
                }
              },
            ),
            /* Container(
                child: CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
                autoPlay: true,
              ),
              items: Advertisement.advertisement
                  .map((advertisement) => AdvCard(advertisement: advertisement))
                  .toList(),
            )),*/
            SectionTitle(title: 'Categories'),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CategoryCarousel(
                    categories: state.categories
                        .where((Category) => Category.isRecommended)
                        .toList(),
                  );
                } else {
                  return Text('Something went wrong.');
                }
              },
            ),
            /*CategoryCarousel(
                categories: Category.categories
                    .where((Category) => Category.isRecommended)
                    .toList()),*/
            SectionTitle(title: 'Others'),
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoryLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is CategoryLoaded) {
                  return CategoryCarousel(
                    categories: state.categories
                        .where((Category) => Category.others)
                        .toList(),
                  );
                } else {
                  return Text('Something went wrong.');
                }
              },
            ),
            /*CategoryCarousel(
                categories: Category.categories
                    .where((Category) => Category.others)
                    .toList()),*/
          ],
        ),
      ),
    );
  }
}





//new
