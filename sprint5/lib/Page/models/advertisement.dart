import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Advertisement extends Equatable {
  final String name;
  final String imageUrl;

  const Advertisement({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];
  static Advertisement fromSnapshot(DocumentSnapshot snap) {
    Advertisement advertisement = Advertisement(
      name: snap['name'],
      imageUrl: snap['imageUrl'],
    );
    return advertisement;
  }

  static List<Advertisement> advertisement = [
    Advertisement(
        name: "frozenfood",
        imageUrl:
            "https://img.freepik.com/free-vector/ad-template-ice-cream_52683-19497.jpg"),
    Advertisement(
        name: "drinks",
        imageUrl:
            'https://mir-s3-cdn-cf.behance.net/projects/404/706ea4120514887.Y3JvcCw1NzUzLDQ1MDAsMTEyNSww.png'),
    Advertisement(
        name: "canfood",
        imageUrl:
            'https://img.pikbest.com/backgrounds/20210806/fashion-cartoon-farm-supermarket-food-banner_6080029.jpg!c1024wm0'),
  ];
}
