import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;
  final bool isRecommended;
  final bool others;

  const Category(
      {required this.name,
      required this.imageUrl,
      required this.isRecommended,
      required this.others});

  @override
  // TODO: implement props
  List<Object?> get props => [name, imageUrl,isRecommended,others];

  static Category fromSnapshot(DocumentSnapshot snap){
    Category category = Category(
      name: snap['name'], 
      imageUrl: snap['imageUrl'], 
      isRecommended: snap['isRecommended'], 
      others: snap['others']);

      return category;
  }
/*
  static List<Category> categories = [
    Category(
      name: "Frozen Food",
      imageUrl:
          'https://st2.depositphotos.com/1588812/9083/v/450/depositphotos_90835222-stock-illustration-logo-for-frozen-products.jpg',
      isRecommended: true,
      others: false,
    ),
    Category(
      name: "Drinks",
      imageUrl:
          'https://www.nicepng.com/png/detail/59-598830_cool-drinks-png-cold-drink-imageUrls-png.png',
      isRecommended: true,
      others: false,
    ),
    Category(
      name: "Groceries",
      imageUrl:
          'https://media-cldnry.s-nbcnews.com/imageUrl/upload/t_fit-760w,f_auto,q_auto:best/rockcms/2021-12/211213-wee-groceries-se-405p-a36212.jpg',
      isRecommended: true,
      others: false,
    ),
    Category(
      name: "Stationary",
      imageUrl: 'https://cdn-icons-png.flaticon.com/512/1540/1540272.png',
      isRecommended: false,
      others: true,
    ),
    Category(
      name: "Cleaning Products",
      imageUrl:
          'https://st2.depositphotos.com/3687485/11055/v/950/depositphotos_110554488-stock-illustration-house-cleaning-hygiene-and-products.jpg',
      isRecommended: false,
      others: true,
    ),
  ];*/
}
