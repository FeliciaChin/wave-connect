import 'package:flutter/cupertino.dart';
import '../Page/models/advertisement.dart';
import 'package:flutter/material.dart';

class AdvCard extends StatelessWidget {
  final Advertisement advertisement;

  const AdvCard({
    required this.advertisement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20.0),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(advertisement.imageUrl,
                    fit: BoxFit.cover, width: 1000.0, ),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                         Colors.amberAccent,
                          Color.fromARGB(255, 242, 242, 174),
                          
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    
                    
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
