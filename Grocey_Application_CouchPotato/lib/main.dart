import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/models/product_models.dart';
import 'Page/Provider/cart_provider.dart';
import 'blocs/advertisement/advertisement_bloc.dart';
import 'blocs/blocs.dart';
import 'blocs/category/category_bloc.dart';
import 'home_screen.dart';
import 'config/app_router.dart';
import 'login.dart';
import '.env';
import 'repositories/repositories.dart';
import 'dart:io';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = new PostHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AdvertisementBloc(
            AdvertisementRepository: AdvertisementRepository(),
          )..add(
              LoadAdvertisement(),
            ),
        ),
        BlocProvider(
          create: (_) => CategoryBloc(
            categoryRepository: CategoryRepository(),
          )..add(
              LoadCategories(),
            ),
        ),
        BlocProvider(
          create: (_) => ProductBloc(
            productRepository: ProductRepository(),
          )..add(LoadProducts()),
        ),
      ],
      child: MaterialApp(
        home: HomePage(),
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
