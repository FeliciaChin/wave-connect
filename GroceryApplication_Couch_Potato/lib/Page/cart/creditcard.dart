import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_form.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:get/get.dart';
import 'package:Couch_Potato/Page/Provider/order_controller.dart';
import 'package:Couch_Potato/Page/delivery.dart';
import 'package:Couch_Potato/Page/Provider/cart_provider.dart';
import '../Provider/orderLength.dart';

class CreditCardPage extends StatefulWidget {
  final String price;
  const CreditCardPage(this.price, {Key? key}) : super(key: key);

  @override
  _CreditCardPageState createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final OrderLength oL = Get.find();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.blue[50],
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              obscureCardNumber: true,
              obscureCardCvv: true,
              onCreditCardWidgetChange: (CreditCardBrand) {},
            ),
            Expanded(
              child: Column(
                children: [
                  CreditCardForm(
                    cardNumber: cardNumber,
                    expiryDate: expiryDate,
                    cardHolderName: cardHolderName,
                    cvvCode: cvvCode,
                    onCreditCardModelChange: onCreditCardModelChange,
                    themeColor: Colors.blue,
                    formKey: formKey,
                    cardNumberDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Number',
                        hintText: 'xxxx xxxx xxxx xxxx'),
                    expiryDateDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Expired Date',
                        hintText: 'xx/xx'),
                    cvvCodeDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'CVV',
                        hintText: 'xxx'),
                    cardHolderDecoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Card Holder',
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            primary: Color(0xff1b447b)),
                        child: Container(
                          margin: EdgeInsets.all(8.0),
                          child: Text(
                            'Pay RM${widget.price}',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'halter',
                              fontSize: 14,
                              package: 'flutter_credit_card',
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (cardNumber == "5555 5555 5555 5555") {
                              _showValidDialog(context, "Transaction Failed",
                                  'The credit/debit card have not enough balance.');
                            } else {
                              //add order to DB
                              OrderController orderController =
                                  new OrderController();
                              orderController.addOrder("Credit/Debit Card");

                              _showValidDialog(
                                  context,
                                  "Transaction Successful",
                                  'Redirecting... Please wait for awhile.');
                              await Future.delayed(Duration(seconds: 3));

                              oL.addOrder(1);

                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MainDeliveryPage()));
                            }
                          } else {
                            _showValidDialog(context, "Invalid",
                                'Invalid credit/debit card! Please try again.');
                          }
                        },
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.all(8.0),
                          backgroundColor: Colors.grey,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
    // ),
    // );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

Future<AlertDialog>? _showValidDialog(
  BuildContext context,
  String title,
  String content,
) {
  showDialog<AlertDialog>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xff1b447b),
          title: Text(title,
              style: TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 255, 255, 255))),
          content: Text(
            content,
            style: TextStyle(
                fontSize: 18, color: Color.fromARGB(255, 255, 255, 255)),
          ),
          actions: title != "Transaction Successful"
              ? [
                  TextButton(
                      child: Text(
                        "OK",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ]
              : [
                  Image.network(
                    'https://i.gifer.com/origin/34/34338d26023e5515f6cc8969aa027bca_w200.gif',
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  )
                ],
        );
      });
  return null;
}
