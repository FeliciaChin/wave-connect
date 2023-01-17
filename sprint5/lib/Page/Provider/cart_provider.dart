import 'package:get/get.dart';
import '../models/product_models.dart';

class CartProvider extends GetxController {
  var _products = {}.obs;
  var _deliveryFee = 7.0;
  var _deliveryAddress = "";

  void addProduct(Product product) {
    if (_products.containsKey(product)) {
      _products[product] += 1;
    } else {
      _products[product] = 1;
    }
  }

  void removeProduct(Product product) {
    if (_products.containsKey(product) && _products[product] == 1) {
      //quantity only left 1, remove the item
      _products.removeWhere((key, value) => key == product);
    } else {
      //decrease quantity by 1
      _products[product] -= 1;
    }
  }

  get products => _products;

  get deliveryAddress => _deliveryAddress;
  set setDeliveryAddress(String address) {
    _deliveryAddress = address;
  }

  void changePurchaseMethod(String method) {
    if (method != 'Delivery') {
      _deliveryFee = 0.0;
    } else {
      _deliveryFee = 7.0;
    }
  }

  get deliveryFee => _deliveryFee;
  set setDeliveryFee(double fee) {
    _deliveryFee = fee;
  }

  get productSubtotal => _products.entries
      .map((product) => product.key.price * product.value)
      .toList();

  get total => _products.length > 0
      ? _products.entries
          .map((product) => product.key.price * product.value)
          .toList()
          .reduce((value, element) => value + element + _deliveryFee)
          .toStringAsFixed(2)
      : 0;
}
