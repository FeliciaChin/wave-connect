import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:Couch_Potato/Page/models/category_model.dart';
import 'package:Couch_Potato/screen/product_screen.dart/product_screen.dart';
import 'package:Couch_Potato/screen/screen.dart';
import '../home_screen.dart';
import '../Page/models/product_models.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return HomeScreen.route();
      case HomeScreen.routeName:
        return HomeScreen.route();
      case ProductScreen.routeName:
        return ProductScreen.route(category: settings.arguments as Category);
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
      ),
    );
  }
}
