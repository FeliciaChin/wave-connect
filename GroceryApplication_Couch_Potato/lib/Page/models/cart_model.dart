import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Couch_Potato/Page/models/models.dart';

class Cart extends Equatable {
  final List<Product> products = const <Product>[];
  final double totalPrice = 0.0;
  final firebaseUser = FirebaseAuth.instance.currentUser;

  double get subtotal =>
      products.fold(0, (total, current) => total + current.price);

  double deliveryFee(subtotal) {
    if (subtotal >= 50.00) {
      return 0.0;
    } else {
      return 5.00;
    }
  }

  double total(subtotal, deliveryFee) {
    return subtotal + deliveryFee(subtotal);
  }

  String freeDelivery(subtotal) {
    if (subtotal >= 50.0) {
      return 'You have Free Delivery';
    } else {
      double missing = 50.0 - subtotal;
      return 'Add \RM${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  String get subtotalString => subtotal.toStringAsFixed(2);

  String get totalString => total(subtotal, deliveryFee).toStringAsFixed(2);

  String get deliveryFeeString => deliveryFee(subtotal).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subtotal);

  @override
  List<Object?> get props => [products];
}
