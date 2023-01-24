/*
class ReviewModal {
  String? image;
  String? name;
  double? rating;
  String? date;
  String? comment;

  ReviewModal({this.image, this.name, this.rating, this.date, this.comment});

  ReviewModal.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    name = json['name'];
    rating = json['rating'];
    date = json['date'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['name'] = this.name;
    data['rating'] = this.rating;
    data['date'] = this.date;
    data['comment'] = this.comment;
    return data;
  }
}
*/

/*
import 'package:equatable/equatable.dart';

class ReviewModal extends Equatable {
  final String image;
  final String name; 
  final double rating;
  final String date;
  final String comment;

  const ReviewModal({
    required this.image,
    required this.name,
    required this.rating,
    required this.date, 
    required this.comment,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [image, name, rating, date, comment];
  static List<ReviewModal> review = [
    ReviewModal(
      image:
          'assets/images/men.png',
      name: "User 1",
      rating: 4.80,
      date:
          '06 Jun 2022',
      comment: 'comment',
    ),
    ReviewModal(
      image:
          'assets/images/men.png',
      name: "User 1",
      rating: 4.80,
      date:
          '06 Jun 2022',
      comment: 'comment',
    ),
    ReviewModal(
      image:
          'assets/images/men.png',
      name: "User 1",
      rating: 4.80,
      date:
          '06 Jun 2022',
      comment: 'comment',
    ),
    ReviewModal(
      image:
          'assets/images/men.png',
      name: "User 1",
      rating: 4.80,
      date:
          '06 Jun 2022',
      comment: 'comment',
    )
  ];

  remove(ReviewModal review) {}
}
*/