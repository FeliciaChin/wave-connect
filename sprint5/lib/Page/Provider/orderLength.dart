import 'package:get/get.dart';

class OrderLength extends GetxController {
  var _num = {}.obs;

  void addOrder(number) {
    _num[number] = 1;
  }

  void deleteOrder(number) {
    _num.removeWhere((key, value) => key == number);
  }

  get total => _num.length;
}