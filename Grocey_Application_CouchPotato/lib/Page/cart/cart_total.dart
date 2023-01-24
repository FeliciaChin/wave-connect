import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import 'payment_method.dart' as paymentMethod;
import '../Provider/orderLength.dart';

class CartTotal extends StatelessWidget {
  final CartProvider controller = Get.find();
  // final OrderLength oL = Get.find();
  CartTotal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        //color: Colors.grey[100],
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.grey),
                bottom: BorderSide(color: Colors.grey))),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'Total: RM${controller.total}',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '''Delivery fee: 
RM${controller.deliveryFee.toStringAsFixed(2)}''',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.orangeAccent),
                ),
                onPressed: () => {
                  // oL.addOrder(1),
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return Dialog(
                            insetPadding: EdgeInsets.all(10),
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SingleChildScrollView(
                                child: paymentMethod.PaymentMethod(
                                    controller.total)));
                      })
                },
                // paymentController.makePayment(
                // amount: '${controller.total}', currency: 'MYR'),
                // Navigator.of(context).pushReplacement(
                // MaterialPageRoute(builder: (context) => DeliveryPage())),
                child: Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              )
            ]),
            Row(
              children: [],
            ),
          ],
        )));
  }
}
